#include "keymapper.h"
#include <QKeyEvent>
#include <QDebug>
KeyMapper keyMapper;
KeyMapper::KeyMapper(QObject *parent) : QObject(parent){

}
bool KeyMapper::eventFilter(QObject* obj, QEvent* event){
    if(m_isEditing){
        if (event->type()==QEvent::KeyPress) {
            QKeyEvent* key = static_cast<QKeyEvent*>(event);

            //TODO (fat)
            //search every key, if it has macro then start the macro


            qDebug() << "keyclicked";
            qDebug() << key->key();


        } else {
            return QObject::eventFilter(obj, event);
        }
        return true;
    }
    return false;
}


bool KeyMapper::isKeyAllowed(QEvent* event){
    if (event->type()==QEvent::KeyPress) {
        QKeyEvent* key = static_cast<QKeyEvent*>(event);
        if ((key->key()==Qt::Key_Enter)
                ||(key->key()==Qt::Key_Return)
                ||(key->key()==Qt::Key_Escape)
                ||(key->key()==Qt::Key_Alt)
                ||(key->key()==Qt::Key_Shift)
                ||(key->key()==Qt::Key_Control)
                ||(key->key()==Qt::Key_PageDown)
                ||(key->key()==Qt::Key_PageUp)
                ||(key->key()==Qt::Key_Home)
                ||(key->key()==Qt::Key_Insert)
                ||(key->key()==Qt::Key_Delete)
                ||(key->key()==Qt::Key_End)
                ||(key->key()==Qt::Key_Tab)
                ||(key->key()==Qt::Key_CapsLock)
                ){
            qDebug() << "NOT allowed key pressed";
            return false;
        }else{
            qDebug() << "allowed key pressed";
            return true;
        }
    }
}
