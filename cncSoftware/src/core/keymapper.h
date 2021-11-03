#ifndef KEYMAPPER_H
#define KEYMAPPER_H
#include <QObject>
#include <QDebug>
class KeyMapper : public QObject
{

    Q_OBJECT
    Q_PROPERTY(bool isEditing READ isEditing WRITE setIsEditing NOTIFY isEditingChanged)
public:
    void setIsEditing(const bool &a) {
        if (a != m_isEditing) {
            m_isEditing = a;
            emit isEditingChanged();
        }
    }
    bool isEditing() const {
        return m_isEditing;
    }
signals:
    void isEditingChanged();
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
