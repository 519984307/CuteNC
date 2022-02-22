/****************************************************************************
** Meta object code from reading C++ file 'comport.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../cncSoftware/src/core/comport.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'comport.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Comport_t {
    QByteArrayData data[24];
    char stringdata0[324];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Comport_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Comport_t qt_meta_stringdata_Comport = {
    {
QT_MOC_LITERAL(0, 0, 7), // "Comport"
QT_MOC_LITERAL(1, 8, 15), // "receivedCommand"
QT_MOC_LITERAL(2, 24, 0), // ""
QT_MOC_LITERAL(3, 25, 4), // "data"
QT_MOC_LITERAL(4, 30, 26), // "signal_ReadyForNextCommand"
QT_MOC_LITERAL(5, 57, 15), // "signal_OpenPort"
QT_MOC_LITERAL(6, 73, 16), // "signal_ClosePort"
QT_MOC_LITERAL(7, 90, 15), // "signal_GetPorts"
QT_MOC_LITERAL(8, 106, 17), // "signal_ReceivedOk"
QT_MOC_LITERAL(9, 124, 9), // "writeData"
QT_MOC_LITERAL(10, 134, 8), // "readData"
QT_MOC_LITERAL(11, 143, 11), // "handleError"
QT_MOC_LITERAL(12, 155, 28), // "QSerialPort::SerialPortError"
QT_MOC_LITERAL(13, 184, 5), // "error"
QT_MOC_LITERAL(14, 190, 14), // "openSerialPort"
QT_MOC_LITERAL(15, 205, 10), // "serialPort"
QT_MOC_LITERAL(16, 216, 15), // "closeSerialPort"
QT_MOC_LITERAL(17, 232, 17), // "getAvailablePorts"
QT_MOC_LITERAL(18, 250, 5), // "debug"
QT_MOC_LITERAL(19, 256, 22), // "numberOfAvailablePorts"
QT_MOC_LITERAL(20, 279, 11), // "getPortName"
QT_MOC_LITERAL(21, 291, 8), // "position"
QT_MOC_LITERAL(22, 300, 15), // "connectionError"
QT_MOC_LITERAL(23, 316, 7) // "message"

    },
    "Comport\0receivedCommand\0\0data\0"
    "signal_ReadyForNextCommand\0signal_OpenPort\0"
    "signal_ClosePort\0signal_GetPorts\0"
    "signal_ReceivedOk\0writeData\0readData\0"
    "handleError\0QSerialPort::SerialPortError\0"
    "error\0openSerialPort\0serialPort\0"
    "closeSerialPort\0getAvailablePorts\0"
    "debug\0numberOfAvailablePorts\0getPortName\0"
    "position\0connectionError\0message"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Comport[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      16,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       6,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   94,    2, 0x06 /* Public */,
       4,    0,   97,    2, 0x06 /* Public */,
       5,    0,   98,    2, 0x06 /* Public */,
       6,    0,   99,    2, 0x06 /* Public */,
       7,    0,  100,    2, 0x06 /* Public */,
       8,    0,  101,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       9,    1,  102,    2, 0x08 /* Private */,
      10,    0,  105,    2, 0x08 /* Private */,
      11,    1,  106,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
      14,    1,  109,    2, 0x02 /* Public */,
      16,    0,  112,    2, 0x02 /* Public */,
      17,    0,  113,    2, 0x02 /* Public */,
      18,    0,  114,    2, 0x02 /* Public */,
      19,    0,  115,    2, 0x02 /* Public */,
      20,    1,  116,    2, 0x02 /* Public */,
      22,    1,  119,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QByteArray,    3,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::QByteArray,    3,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 12,   13,

 // methods: parameters
    QMetaType::Void, QMetaType::QString,   15,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   21,
    QMetaType::Void, QMetaType::QString,   23,

       0        // eod
};

void Comport::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Comport *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->receivedCommand((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 1: _t->signal_ReadyForNextCommand(); break;
        case 2: _t->signal_OpenPort(); break;
        case 3: _t->signal_ClosePort(); break;
        case 4: _t->signal_GetPorts(); break;
        case 5: _t->signal_ReceivedOk(); break;
        case 6: _t->writeData((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 7: _t->readData(); break;
        case 8: _t->handleError((*reinterpret_cast< QSerialPort::SerialPortError(*)>(_a[1]))); break;
        case 9: _t->openSerialPort((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 10: _t->closeSerialPort(); break;
        case 11: _t->getAvailablePorts(); break;
        case 12: _t->debug(); break;
        case 13: { int _r = _t->numberOfAvailablePorts();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 14: { QString _r = _t->getPortName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 15: _t->connectionError((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Comport::*)(const QByteArray & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Comport::receivedCommand)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Comport::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Comport::signal_ReadyForNextCommand)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Comport::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Comport::signal_OpenPort)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Comport::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Comport::signal_ClosePort)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (Comport::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Comport::signal_GetPorts)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (Comport::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Comport::signal_ReceivedOk)) {
                *result = 5;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject Comport::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_Comport.data,
    qt_meta_data_Comport,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *Comport::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Comport::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Comport.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Comport::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 16)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 16;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 16)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 16;
    }
    return _id;
}

// SIGNAL 0
void Comport::receivedCommand(const QByteArray & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Comport::signal_ReadyForNextCommand()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Comport::signal_OpenPort()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void Comport::signal_ClosePort()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void Comport::signal_GetPorts()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void Comport::signal_ReceivedOk()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
