/****************************************************************************
** Meta object code from reading C++ file 'serial.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../cncSoftware/src/serialport/serial.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'serial.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Comport_t {
    QByteArrayData data[19];
    char stringdata0[229];
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
QT_MOC_LITERAL(4, 30, 9), // "writeData"
QT_MOC_LITERAL(5, 40, 8), // "readData"
QT_MOC_LITERAL(6, 49, 11), // "handleError"
QT_MOC_LITERAL(7, 61, 28), // "QSerialPort::SerialPortError"
QT_MOC_LITERAL(8, 90, 5), // "error"
QT_MOC_LITERAL(9, 96, 14), // "openSerialPort"
QT_MOC_LITERAL(10, 111, 10), // "serialPort"
QT_MOC_LITERAL(11, 122, 15), // "closeSerialPort"
QT_MOC_LITERAL(12, 138, 17), // "getAvailablePorts"
QT_MOC_LITERAL(13, 156, 5), // "debug"
QT_MOC_LITERAL(14, 162, 21), // "numberOfAvaiablePorts"
QT_MOC_LITERAL(15, 184, 11), // "getPortName"
QT_MOC_LITERAL(16, 196, 8), // "position"
QT_MOC_LITERAL(17, 205, 15), // "connectionError"
QT_MOC_LITERAL(18, 221, 7) // "message"

    },
    "Comport\0receivedCommand\0\0data\0writeData\0"
    "readData\0handleError\0QSerialPort::SerialPortError\0"
    "error\0openSerialPort\0serialPort\0"
    "closeSerialPort\0getAvailablePorts\0"
    "debug\0numberOfAvaiablePorts\0getPortName\0"
    "position\0connectionError\0message"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Comport[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      11,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   69,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       4,    1,   72,    2, 0x08 /* Private */,
       5,    0,   75,    2, 0x08 /* Private */,
       6,    1,   76,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
       9,    1,   79,    2, 0x02 /* Public */,
      11,    0,   82,    2, 0x02 /* Public */,
      12,    0,   83,    2, 0x02 /* Public */,
      13,    0,   84,    2, 0x02 /* Public */,
      14,    0,   85,    2, 0x02 /* Public */,
      15,    1,   86,    2, 0x02 /* Public */,
      17,    1,   89,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QByteArray,    3,

 // slots: parameters
    QMetaType::Void, QMetaType::QByteArray,    3,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 7,    8,

 // methods: parameters
    QMetaType::Void, QMetaType::QString,   10,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::QString, QMetaType::Int,   16,
    QMetaType::Void, QMetaType::QString,   18,

       0        // eod
};

void Comport::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Comport *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->receivedCommand((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 1: _t->writeData((*reinterpret_cast< const QByteArray(*)>(_a[1]))); break;
        case 2: _t->readData(); break;
        case 3: _t->handleError((*reinterpret_cast< QSerialPort::SerialPortError(*)>(_a[1]))); break;
        case 4: _t->openSerialPort((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: _t->closeSerialPort(); break;
        case 6: _t->getAvailablePorts(); break;
        case 7: _t->debug(); break;
        case 8: { int _r = _t->numberOfAvaiablePorts();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 9: { QString _r = _t->getPortName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 10: _t->connectionError((*reinterpret_cast< QString(*)>(_a[1]))); break;
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
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 11)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 11;
    }
    return _id;
}

// SIGNAL 0
void Comport::receivedCommand(const QByteArray & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
