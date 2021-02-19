#include "globalmousetracker.h"

#include <QCursor>

GlobalMouseTracker::GlobalMouseTracker(uint trackRateMsec)
    : m_position(),
      m_trackRate(trackRateMsec)
{

}

void GlobalMouseTracker::run()
{
    while(true) {
        QPoint oldPosition = m_position;
        m_position = QCursor::pos();

        if (oldPosition != m_position)
            posChanged();

        if (oldPosition.x() != m_position.x())
            xChanged();

        if (oldPosition.y() != m_position.y())
            yChanged();

        msleep(m_trackRate);
    }
}

int GlobalMouseTracker::x() const
{
    return m_position.x();
}

int GlobalMouseTracker::y() const
{
    return m_position.y();
}

QPoint GlobalMouseTracker::pos() const
{
    return m_position;
}
