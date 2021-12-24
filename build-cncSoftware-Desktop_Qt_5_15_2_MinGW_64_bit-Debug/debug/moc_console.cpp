/****************************************************************************
** Meta object code from reading C++ file 'console.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../cncSoftware/src/console/console.h"
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
    QByteArrayData data[24];
    char stringdata0[218];
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
QT_MOC_LITERAL(4, 22, 14), // "refreshConsole"
QT_MOC_LITERAL(5, 37, 12), // "consoleDebug"
QT_MOC_LITERAL(6, 50, 4), // "text"
QT_MOC_LITERAL(7, 55, 13), // "sendToConsole"
QT_MOC_LITERAL(8, 69, 4), // "time"
QT_MOC_LITERAL(9, 74, 4), // "type"
QT_MOC_LITERAL(10, 79, 6), // "source"
QT_MOC_LITERAL(11, 86, 7), // "message"
QT_MOC_LITERAL(12, 94, 9), // "textColor"
QT_MOC_LITERAL(13, 104, 17), // "displayEachSecond"
QT_MOC_LITERAL(14, 122, 7), // "getType"
QT_MOC_LITERAL(15, 130, 8), // "position"
QT_MOC_LITERAL(16, 139, 9), // "getSource"
QT_MOC_LITERAL(17, 149, 10), // "getMessage"
QT_MOC_LITERAL(18, 160, 7), // "getTime"
QT_MOC_LITERAL(19, 168, 12), // "getTextColor"
QT_MOC_LITERAL(20, 181, 12), // "clearConsole"
QT_MOC_LITERAL(21, 194, 13), // "countMessages"
QT_MOC_LITERAL(22, 208, 5), // "debug"
QT_MOC_LITERAL(23, 214, 3) // "log"

    },
    "Console\0getData\0\0data\0refreshConsole\0"
    "consoleDebug\0text\0sendToConsole\0time\0"
    "type\0source\0message\0textColor\0"
    "displayEachSecond\0getType\0position\0"
    "getSource\0getMessage\0getTime\0getTextColor\0"
    "clearConsole\0countMessages\0debug\0log"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Console[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      15,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   89,    2, 0x06 /* Public */,
       4,    0,   92,    2, 0x06 /* Public */,
       5,    1,   93,    2, 0x06 /* Public */,
       7,    5,   96,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      13,    0,  107,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      14,    1,  108,    2, 0x02 /* Public */,
      16,    1,  111,    2, 0x02 /* Public */,
      17,    1,  114,    2, 0x02 /* Public */,
      18,    1,  117,    2, 0x02 /* Public */,
      19,    1,  120,    2, 0x02 /* Public */,
      20,    0,  123,    2, 0x02 /* Public */,
      21,    0,  124,    2, 0x02 /* Public */,
      22,    0,  125,    2, 0x02 /* Public */,
      23,    4,  126,    2, 0x02 /* Public */,
      23,    3,  135,    2, 0x22 /* Public | MethodCloned */,

 // signals: parameters
    QMetaType::Void, QMetaType::QByteArray,    3,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString,    8,    9,   10,   11,   12,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::QString, QMetaType::Int,   15,
    QMetaType::QString, QMetaType::Int,   15,
    QMetaType::QString, QMetaType::Int,   15,
    QMetaType::QString, QMetaType::Int,   15,
    QMetaType::QString, QMetaType::Int,   15,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString,    9,   10,   11,   12,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString,    9,   10,   11,

       0        // eod
};

void Console::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Console *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->getData((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 1: _t->refreshConsole(); break;
        case 2: _t->consoleDebug((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->sendToConsole((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4])),(*reinterpret_cast< QString(*)>(_a[5]))); break;
        case 4: _t->displayEachSecond(); break;
        case 5: { QString _r = _t->getType((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 6: { QString _r = _t->getSource((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 7: { QString _r = _t->getMessage((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 8: { QString _r = _t->getTime((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 9: { QString _r = _t->getTextColor((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 10: _t->clearConsole(); break;
        case 11: { int _r = _t->countMessages();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 12: _t->debug(); break;
        case 13: _t->log((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4]))); break;
        case 14: _t->log((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3]))); break;
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
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Console::refreshConsole)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Console::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Console::consoleDebug)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Console::*)(QString , QString , QString , QString , QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Console::sendToConsole)) {
                *result = 3;
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
        if (_id < 15)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 15;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 15)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 15;
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
void Console::refreshConsole()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Console::consoleDebug(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Console::sendToConsole(QString _t1, QString _t2, QString _t3, QString _t4, QString _t5)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t5))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
