#ifndef FACTORIALCOUNTER_H
#define FACTORIALCOUNTER_H

#include <QThread>

class FactorialCounter : public QThread
{
    Q_OBJECT
    Q_PROPERTY(long long result READ result NOTIFY resultChanged)
    Q_PROPERTY(bool isRunning READ isRunning NOTIFY runningChanged)

public:
    FactorialCounter();

    Q_INVOKABLE void setValue(int val);
    long long result() const;

signals:
    void resultChanged();
    void runningChanged();

protected:
    void run() override;

private:
    int m_value;
    long long m_result;
};

#endif // FACTORIALCOUNTER_H
