/****************************************************************************
** Meta object code from reading C++ file 'comport.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../src/core/comport.h"
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
    QByteArrayData data[28];
    char stringdata0[409];
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
QT_MOC_LITERAL(9, 124, 28), // "signal_ConnectedToSerialPort"
QT_MOC_LITERAL(10, 153, 33), // "signal_DisconnectedFromSerial..."
QT_MOC_LITERAL(11, 187, 9), // "writeData"
QT_MOC_LITERAL(12, 197, 8), // "readData"
QT_MOC_LITERAL(13, 206, 11), // "handleError"
QT_MOC_LITERAL(14, 218, 28), // "QSerialPort::SerialPortError"
QT_MOC_LITERAL(15, 247, 5), // "error"
QT_MOC_LITERAL(16, 253, 11), // "isConnected"
QT_MOC_LITERAL(17, 265, 14), // "openSerialPort"
QT_MOC_LITERAL(18, 280, 10), // "serialPort"
QT_MOC_LITERAL(19, 291, 15), // "closeSerialPort"
QT_MOC_LITERAL(20, 307, 9), // "reconnect"
QT_MOC_LITERAL(21, 317, 17), // "getAvailablePorts"
QT_MOC_LITERAL(22, 335, 5), // "debug"
QT_MOC_LITERAL(23, 341, 22), // "numberOfAvailablePorts"
QT_MOC_LITERAL(24, 364, 11), // "getPortName"
QT_MOC_LITERAL(25, 376, 8), // "position"
QT_MOC_LITERAL(26, 385, 15), // "connectionError"
QT_MOC_LITERAL(27, 401, 7) // "message"

    },
    "Comport\0receivedCommand\0\0data\0"
    "signal_ReadyForNextCommand\0signal_OpenPort\0"
    "signal_ClosePort\0signal_GetPorts\0"
    "signal_ReceivedOk\0signal_ConnectedToSerialPort\0"
    "signal_DisconnectedFromSerialPort\0"
    "writeData\0readData\0handleError\0"
    "QSerialPort::SerialPortError\0error\0"
    "isConnected\0openSerialPort\0serialPort\0"
    "closeSerialPort\0reconnect\0getAvailablePorts\0"
    "debug\0numberOfAvailablePorts\0getPortName\0"
    "position\0connectionError\0message"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Comport[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      20,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       8,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,  114,    2, 0x06 /* Public */,
       4,    0,  117,    2, 0x06 /* Public */,
       5,    0,  118,    2, 0x06 /* Public */,
       6,    0,  119,    2, 0x06 /* Public */,
       7,    0,  120,    2, 0x06 /* Public */,
       8,    0,  121,    2, 0x06 /* Public */,
       9,    0,  122,    2, 0x06 /* Public */,
      10,    0,  123,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      11,    1,  124,    2, 0x08 /* Private */,
      12,    0,  127,    2, 0x08 /* Private */,
      13,    1,  128,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
      16,    0,  131,    2, 0x02 /* Public */,
      17,    1,  132,    2, 0x02 /* Public */,
      19,    0,  135,    2, 0x02 /* Public */,
      20,    0,  136,    2, 0x02 /* Public */,
      21,    0,  137,    2, 0x02 /* Public */,
      22,    0,  138,    2, 0x02 /* Public */,
      23,    0,  139,    2, 0x02 /* Public */,
      24,    1,  140,    2, 0x02 /* Public */,
      26,    1,  143,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QByteArray,    3,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::QByteArray,    3,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 14,   15,

 // methods: parameters
    QMetaType::Bool,
    QMetaType::Void, QMetaType::QString,   18,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   25,
    QMetaType::Void, QMetaType::QString,   27,

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
        case 6: _t->signal_ConnectedToSerialPort(); break;
        case 7: _t->signal_DisconnectedFromSerialPort(); break;
        case 8: _t->writeData((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 9: _t->readData(); break;
        case 10: _t->handleError((*reinterpret_cast< QSerialPort::SerialPortError(*)>(_a[1]))); break;
        case 11: { bool _r = _t->isConnected();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 12: _t->openSerialPort((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 13: _t->closeSerialPort(); break;
        case 14: _t->reconnect(); break;
        case 15: _t->getAvailablePorts(); break;
        case 16: _t->debug(); break;
        case 17: { int _r = _t->numberOfAvailablePorts();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 18: { QString _r = _t->getPortName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 19: _t->connectionError((*reinterpret_cast< QString(*)>(_a[1]))); break;
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
        {
            using _t = void (Comport::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Comport::signal_ConnectedToSerialPort)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (Comport::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Comport::signal_DisconnectedFromSerialPort)) {
                *result = 7;
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
        if (_id < 20)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 20;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 20)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 20;
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

// SIGNAL 6
void Comport::signal_ConnectedToSerialPort()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void Comport::signal_DisconnectedFromSerialPort()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
