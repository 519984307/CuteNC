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

#include "global.h"


//threads
#include <QtConcurrent>

int main(int argc, char *argv[])
{
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

    QFontDatabase fontDatabase;
    if (fontDatabase.addApplicationFont(":/fonts/fontello.ttf") == -1){
        qWarning() << "Failed to load fontello.ttf";
        console.log("error","backend","Failed to load fontello font");
    }
    if (fontDatabase.addApplicationFont(":/fonts/Roboto-Regular.ttf") == -1){
        qWarning() << "Failed to load Roboto-Regular.ttf";
        console.log("error","backend","Failed to load Roboto-Regular.ttf");
    }
    if (fontDatabase.addApplicationFont(":/fonts/FontAwesomeRegular.otf") == -1){
        qWarning() << "Failed to load FontAwesomeRegular.otf";
        console.log("error","backend","Failed to load FontAwesomeRegular.otf");
    }
    if (fontDatabase.addApplicationFont(":/fonts/FontAwesomeSolid.otf") == -1){
        qWarning() << "Failed to load FontAwesomeSolid.otf";
        console.log("error","backend","Failed to load FontAwesomeSolid.otf");
    }
    //default font
    // app.setFont(QFont("Roboto-Regular.ttf"));



    //   QQuickView view;
    //   view.setFlags(view.flags() | Qt::FramelessWindowHint);
    //   view.setResizeMode(QQuickView::SizeRootObjectToView);
    //   view.rootContext()->setContextProperty("view",&view);
    //   view.setSource(QUrl("qrc:/splashscreen.qml"));

    //    view.resize(1200,900);
    //    view.show();


    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "cncSoftware_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }


    // We register the qml file by specifying its path.
    qmlRegisterSingletonType(QUrl("qrc:/style.qml"), "Style", 1, 0, "Style");
    // We register the qml file by specifying its path.
    qmlRegisterSingletonType(QUrl("qrc:/util.qml"), "Util", 1, 0, "Util");

    //jedno odkomentowane! splashcreen - poczatkowy ekran
    //const QUrl url(QStringLiteral("qrc:/qml/editor.qml"));
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);


    QQuickWindow::setSceneGraphBackend(QSGRendererInterface::Software);



    //backend.startUp();
    //console.displayEachSecond();


    QObject::connect(&app, SIGNAL(aboutToQuit()), &backend, SLOT(handleQuit()));

    return app.exec();
}
