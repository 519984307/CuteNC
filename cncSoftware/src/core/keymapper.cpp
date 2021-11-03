#include "keymapper.h"
#include <QKeyEvent>
#include <QDebug>

bool KeyMapper::eventFilter(QObject* obj, QEvent* event)
{
    if(!m_isEditing){
        if (event->type()==QEvent::KeyPress) {
            QKeyEvent* key = static_cast<QKeyEvent*>(event);

            //TODO (fat)
            //search every key, if it has macro then start the macro

            if ( (key->key()==Qt::Key_Enter) || (key->key()==Qt::Key_Return) ) {
                //Enter or return was pressed
                qDebug() << "enter or return pressed";



            } else {
                return QObject::eventFilter(obj, event);
            }
            return true;
        } else {
            return QObject::eventFilter(obj, event);
        }
        return false;
    }
    return true;
}
