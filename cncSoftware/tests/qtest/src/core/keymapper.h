#ifndef KEYMAPPER_H
#define KEYMAPPER_H
#include <QObject>
#include <QDebug>
class KeyMapper : public QObject
{

    Q_OBJECT
public:
    explicit KeyMapper(QObject *parent = nullptr);
    Q_INVOKABLE void setKeyMapping(bool active){
        if(active){
            m_isEditing = true;
        }else{
            m_isEditing = false;
        }
        qDebug() << m_isEditing;
    }
    Q_INVOKABLE bool isKeyAllowed(QEvent* event);
private:
    bool m_isEditing;
protected:
    bool eventFilter(QObject* obj, QEvent* event);

    typedef enum{
        KEY_ESC,
        KEY_TAB,
        KEY_SHIFT,
        KEY_CTRL,
        KEY_ALT,
        KEY_RETURN,
        KEY_ENTER,
        KEY_BACKSPACE,
        KEY_FN,
        KEY_INS,
        KEY_DEL,
        KEY_HOME,
        KEY_PAGEUP,
        KEY_PAGEDOWN,
    }ReservedKeys;

};

#endif // KEYMAPPER_H
