#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>
#include <QtDebug>
#include <QScopedPointer>

#include "globalmousetracker.h"
#include "factorialcounter.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQuickView view;

    QScopedPointer<GlobalMouseTracker> mouseGlobal(new GlobalMouseTracker());
    mouseGlobal->start();
    view.rootContext()->setContextProperty("mouseGlobal", mouseGlobal.get());

    QScopedPointer<FactorialCounter> factorialCounter(new FactorialCounter());
    view.rootContext()->setContextProperty("factorialCounter", factorialCounter.get());

    view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
