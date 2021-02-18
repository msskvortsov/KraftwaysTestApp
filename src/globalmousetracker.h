#ifndef GLOBALMOUSETRACKER_H
#define GLOBALMOUSETRACKER_H

#include <QThread>
#include <QPoint>


// Tracks mouse wherever it goes. Standard Qt methods doesn't track it when it goes outside the app's window
// or when app loses focus.
class GlobalMouseTracker : public QThread
{
    Q_OBJECT

    Q_PROPERTY(int x READ x NOTIFY xChanged)
    Q_PROPERTY(int y READ y NOTIFY yChanged)
    Q_PROPERTY(QPoint pos READ pos NOTIFY posChanged)

protected:
    void run() override;

public:
    GlobalMouseTracker();

signals:
    void xChanged();
    void yChanged();
    void posChanged();

private:
    int x() const;
    int y() const;
    QPoint pos() const;

private:
    QPoint m_position;
};

#endif // GLOBALMOUSETRACKER_H
