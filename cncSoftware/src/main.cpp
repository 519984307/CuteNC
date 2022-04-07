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
#include <QTimer>

#include "gcode/syntaxhighlighter.h"
#include "gcode/textcharformat.h"

#include "gcode/line-numbers.h"

#include "core/backend.h"

//translations
#include <QTranslator>
#include <QtQuickTest>
//testing


using namespace CuteNC;
using namespace stefanfrings;
using namespace CleanEditorUI;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));

    QGuiApplication app(argc, argv);
    app.setAttribute(Qt::AA_UseHighDpiPixmaps);

    QQmlApplicationEngine engine;
    QQmlContext *rootContext = engine.rootContext();

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    Backend *backend = new Backend(&app);
    rootContext->setContextProperty("backend",backend);
    rootContext->setContextProperty("consoleLog",backend->m_Console);
    rootContext->setContextProperty("comport",backend->m_Comport);
    rootContext->setContextProperty("axisController",backend->m_AxisController);

    ////Fonts
    //Load fonts from directory
    qDebug() << "loading fonts";
    QFontDatabase fontDatabase;
    QString pathToFonts = ":data/fonts/";
    QDir directory(pathToFonts);
    QStringList fonts = directory.entryList(QStringList() << "*.woff" << "*.woff2" << "*.ttf" << "*.otf",QDir::Files);
    foreach(QString filename, fonts) {
        if (fontDatabase.addApplicationFont(pathToFonts+filename) == -1){
            qDebug() << "Failed to load "+filename;
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
            qDebug() << "Sucessfully installed translation" + baseName;
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

    qmlRegisterType<LineNumbers>("CleanEditor", 1, 0, "LineNumbers");

    engine.load(url);


    QObject::connect(&app, SIGNAL(aboutToQuit()), backend, SLOT(handleQuit()));
    return app.exec();
}

