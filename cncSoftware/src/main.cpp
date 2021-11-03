#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQuickView>

#include <QLocale>
#include <QTranslator>

#include <QFont>
#include <QFontDatabase>

#include <QtQml>
#include <QQmlContext>

#include <QWindow>

#include <QDebug>

#include <QSettings>
#include "global.h"

//threads
#include <QtConcurrent>

#include "httplistener.h"
#include "httprequesthandler.h"

#include "gcode/syntaxhighlighter.h"
#include "gcode/textcharformat.h"

using namespace stefanfrings;

QString searchConfigFile()
{
    QString binDir=QCoreApplication::applicationDirPath();
    QString fileName("webconfig.ini");

    QStringList searchList;
    searchList.append(binDir);
    searchList.append(binDir+"/data");
    searchList.append(binDir+"/../data");
    searchList.append(binDir+"/../cncSoftware/data"); // for development with shadow build (Linux)
    searchList.append(binDir+"/../../cncSoftware/data"); // for development with shadow build (Windows)
    searchList.append(QDir::rootPath()+"data/opt");
    searchList.append(QDir::rootPath()+"data");

    foreach (QString dir, searchList)
    {
        QFile file(dir+"/"+fileName);
        if (file.exists())
        {
            fileName=QDir(file.fileName()).canonicalPath();
            qDebug("Using config file %s",qPrintable(fileName));
            return fileName;
        }
    }

    // not found
    foreach (QString dir, searchList)
    {
        qWarning("%s/%s not found",qPrintable(dir),qPrintable(fileName));
    }
    qFatal("Cannot find config file %s",qPrintable(fileName));
    return nullptr;
}


int main(int argc, char *argv[])
{
    //Setup backend
    backend.setup();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);


    QGuiApplication app(argc, argv);
    app.setAttribute(Qt::AA_UseHighDpiPixmaps);

    QQmlApplicationEngine engine;
    QQmlContext *rootContext = engine.rootContext();

    //Connect QML to C++
    Console serialconsole;

    rootContext->setContextProperty("backend", &backend);
    rootContext->setContextProperty("consoleLog", &console);
    rootContext->setContextProperty("comport", &comport);
    rootContext->setContextProperty("keyMapper", keyMapper);
//Fonts
    //Load fonts from directory
    QFontDatabase fontDatabase;
    QString pathToFonts = ":data/fonts/";
    QDir directory(pathToFonts);
    QStringList fonts = directory.entryList(QStringList() << "*.ttf" << "*.otf",QDir::Files);
    foreach(QString filename, fonts) {
        if (fontDatabase.addApplicationFont(pathToFonts+filename) == -1){
            qWarning() << "Failed to load "+filename;
            console.log("error","backend","Failed to load "+filename);
        }else{
            qDebug() << "Loaded font "+filename;
        }
    }
//EOF Fonts

    //   QQuickView view;
    //   view.setFlags(view.flags() | Qt::FramelessWindowHint);
    //   view.setResizeMode(QQuickView::SizeRootObjectToView);
    //   view.rootContext()->setContextProperty("view",&view);
    //   view.setSource(QUrl("qrc:/splashscreen.qml"));

    //    view.resize(1200,900);
    //    view.show();

//Translations
    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "cncSoftware_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }
//EOF Translations


//Singletons *currently not in use
    qmlRegisterSingletonType(QUrl("qrc:/style.qml"), "Style", 1, 0, "Style");
    qmlRegisterSingletonType(QUrl("qrc:/util.qml"), "Util", 1, 0, "Util");
//EOF Singletons

// Syntax Highlighter For GCode
    qmlRegisterType< SyntaxHighlighter >( "StephenQuan", 1, 0, "SyntaxHighlighter" );
    qmlRegisterType< TextCharFormat >( "StephenQuan", 1, 0, "TextCharFormat" );
// EOF Syntax Highlighter For GCode


    //jedno odkomentowane! splashcreen - poczatkowy ekran
    //const QUrl url(QStringLiteral("qrc:/qml/editor.qml"));
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


//Key Mapper
        keyMapper = new KeyMapper();
        app.installEventFilter(keyMapper);
//EOF Key Mapper



    engine.load(url);


    QQuickWindow::setSceneGraphBackend(QSGRendererInterface::Software);

// Web Server

    // Search for webconfig.ini
    QString configFileName=searchConfigFile();

    // Session store
    QSettings* sessionSettings = new QSettings(configFileName, QSettings::IniFormat, &app);
    sessionSettings->beginGroup("sessions");
    sessionStore = new HttpSessionStore(sessionSettings, &app);

    // Static file controller (index.html)
    QSettings* fileSettings = new QSettings(configFileName, QSettings::IniFormat, &app);
    fileSettings->beginGroup("files");
    staticFileController = new StaticFileController(fileSettings, &app);

    // HTTP Server
    QSettings* listenerSettings = new QSettings(configFileName, QSettings::IniFormat, &app);
    listenerSettings->beginGroup("listener");
    new HttpListener(listenerSettings, new Websocket(&app), &app);

// EOF Web Server

    QObject::connect(&app, SIGNAL(aboutToQuit()), &backend, SLOT(handleQuit()));

    return app.exec();
}
