/****************************************************************************
** Meta object code from reading C++ file 'console.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../cncSoftware/src/core/console.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'console.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Console_t {
    QByteArrayData data[23];
    char stringdata0[266];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Console_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Console_t qt_meta_stringdata_Console = {
    {
QT_MOC_LITERAL(0, 0, 7), // "Console"
QT_MOC_LITERAL(1, 8, 7), // "getData"
QT_MOC_LITERAL(2, 16, 0), // ""
QT_MOC_LITERAL(3, 17, 4), // "data"
QT_MOC_LITERAL(4, 22, 17), // "signal_StartGcode"
QT_MOC_LITERAL(5, 40, 16), // "signal_StopGcode"
QT_MOC_LITERAL(6, 57, 12), // "consoleDebug"
QT_MOC_LITERAL(7, 70, 4), // "text"
QT_MOC_LITERAL(8, 75, 13), // "sendToConsole"
QT_MOC_LITERAL(9, 89, 4), // "time"
QT_MOC_LITERAL(10, 94, 4), // "type"
QT_MOC_LITERAL(11, 99, 6), // "source"
QT_MOC_LITERAL(12, 106, 7), // "message"
QT_MOC_LITERAL(13, 114, 9), // "textColor"
QT_MOC_LITERAL(14, 124, 26), // "signal_ReadyForNextCommand"
QT_MOC_LITERAL(15, 151, 17), // "signal_FileLoaded"
QT_MOC_LITERAL(16, 169, 17), // "displayEachSecond"
QT_MOC_LITERAL(17, 187, 3), // "log"
QT_MOC_LITERAL(18, 191, 22), // "receivedFromSerialPort"
QT_MOC_LITERAL(19, 214, 21), // "prepareFileForSending"
QT_MOC_LITERAL(20, 236, 5), // "debug"
QT_MOC_LITERAL(21, 242, 15), // "commandReceived"
QT_MOC_LITERAL(22, 258, 7) // "command"

    },
    "Console\0getData\0\0data\0signal_StartGcode\0"
    "signal_StopGcode\0consoleDebug\0text\0"
    "sendToConsole\0time\0type\0source\0message\0"
    "textColor\0signal_ReadyForNextCommand\0"
    "signal_FileLoaded\0displayEachSecond\0"
    "log\0receivedFromSerialPort\0"
    "prepareFileForSending\0debug\0commandReceived\0"
    "command"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Console[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      14,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       7,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   84,    2, 0x06 /* Public */,
       4,    0,   87,    2, 0x06 /* Public */,
       5,    0,   88,    2, 0x06 /* Public */,
       6,    1,   89,    2, 0x06 /* Public */,
       8,    5,   92,    2, 0x06 /* Public */,
      14,    0,  103,    2, 0x06 /* Public */,
      15,    0,  104,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      16,    0,  105,    2, 0x0a /* Public */,
      17,    5,  106,    2, 0x0a /* Public */,
      17,    4,  117,    2, 0x2a /* Public | MethodCloned */,
      17,    3,  126,    2, 0x2a /* Public | MethodCloned */,
      19,    1,  133,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      20,    0,  136,    2, 0x02 /* Public */,
      21,    1,  137,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QByteArray,    3,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    7,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString,    9,   10,   11,   12,   13,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Bool,   10,   11,   12,   13,   18,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString,   10,   11,   12,   13,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,   10,   11,   12,
    QMetaType::Void, QMetaType::QString,   12,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   22,

       0        // eod
};

void Console::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Console *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->getData((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 1: _t->signal_StartGcode(); break;
        case 2: _t->signal_StopGcode(); break;
        case 3: _t->consoleDebug((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: _t->sendToConsole((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4])),(*reinterpret_cast< QString(*)>(_a[5]))); break;
        case 5: _t->signal_ReadyForNextCommand(); break;
        case 6: _t->signal_FileLoaded(); break;
        case 7: _t->displayEachSecond(); break;
        case 8: _t->log((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4])),(*reinterpret_cast< bool(*)>(_a[5]))); break;
        case 9: _t->log((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4]))); break;
        case 10: _t->log((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
        case 11: _t->prepareFileForSending((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 12: _t->debug(); break;
        case 13: _t->commandReceived((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Console::*)(const QByteArray & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Console::getData)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Console::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Console::signal_StartGcode)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Console::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Console::signal_StopGcode)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Console::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Console::consoleDebug)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (Console::*)(QString , QString , QString , QString , QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Console::sendToConsole)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (Console::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Console::signal_ReadyForNextCommand)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (Console::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Console::signal_FileLoaded)) {
                *result = 6;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject Console::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_Console.data,
    qt_meta_data_Console,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *Console::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Console::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Console.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Console::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 14)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 14;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 14)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 14;
    }
    return _id;
}

// SIGNAL 0
void Console::getData(const QByteArray & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Console::signal_StartGcode()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Console::signal_StopGcode()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void Console::consoleDebug(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void Console::sendToConsole(QString _t1, QString _t2, QString _t3, QString _t4, QString _t5)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t5))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void Console::signal_ReadyForNextCommand()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void Console::signal_FileLoaded()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
