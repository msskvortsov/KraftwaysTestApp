#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtDebug>
#include <QScopedPointer>

#include "globalmousetracker.h"
#include "factorialcounter.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    GlobalMouseTracker mouseGlobal;
    mouseGlobal.start();
    engine.rootContext()->setContextProperty("mouseGlobal", &mouseGlobal);
    QObject::connect(&engine, &QQmlEngine::quit, &mouseGlobal, [&mouseGlobal] () {
        mouseGlobal.terminate();
        mouseGlobal.wait();
    }, Qt::DirectConnection);

    FactorialCounter factorialCounter;
    engine.rootContext()->setContextProperty("factorialCounter", &factorialCounter);
    QObject::connect(&engine, &QQmlEngine::quit, &factorialCounter, [&factorialCounter]() {
        factorialCounter.terminate();
        factorialCounter.wait();
    }, Qt::DirectConnection);

    engine.load(url);

    QObject::connect(&engine, &QQmlEngine::quit, &app, &QGuiApplication::quit, Qt::DirectConnection);

    return app.exec();
}
