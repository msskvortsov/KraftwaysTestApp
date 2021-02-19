#include "factorialcounter.h"

FactorialCounter::FactorialCounter()
    : m_value(0), m_result(0)
{
    connect(this, &FactorialCounter::started, this, &FactorialCounter::runningChanged);
    connect(this, &FactorialCounter::finished, this, &FactorialCounter::runningChanged);
}

void FactorialCounter::setValue(int val)
{
    if (isRunning())
        return;
    m_value = val;
    start();
}

long long FactorialCounter::result() const
{
    return m_result;
}

void FactorialCounter::run()
{
    m_result = 1;
    for (int i = 1; i <= m_value; i++)
         m_result *= i;
    emit resultChanged();
}
