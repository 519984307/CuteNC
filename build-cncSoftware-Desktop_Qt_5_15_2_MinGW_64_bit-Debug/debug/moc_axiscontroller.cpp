/****************************************************************************
** Meta object code from reading C++ file 'axiscontroller.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../cncSoftware/src/core/axiscontroller.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'axiscontroller.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_AxisController_t {
    QByteArrayData data[24];
    char stringdata0[283];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_AxisController_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_AxisController_t qt_meta_stringdata_AxisController = {
    {
QT_MOC_LITERAL(0, 0, 14), // "AxisController"
QT_MOC_LITERAL(1, 15, 14), // "signal_Refresh"
QT_MOC_LITERAL(2, 30, 0), // ""
QT_MOC_LITERAL(3, 31, 28), // "signal_WaitingForNextCommand"
QT_MOC_LITERAL(4, 60, 15), // "signal_DrawLine"
QT_MOC_LITERAL(5, 76, 6), // "from_x"
QT_MOC_LITERAL(6, 83, 6), // "from_y"
QT_MOC_LITERAL(7, 90, 4), // "to_x"
QT_MOC_LITERAL(8, 95, 4), // "to_y"
QT_MOC_LITERAL(9, 100, 12), // "signal_MoveX"
QT_MOC_LITERAL(10, 113, 8), // "lineSize"
QT_MOC_LITERAL(11, 122, 12), // "signal_MoveY"
QT_MOC_LITERAL(12, 135, 13), // "signal_MoveUp"
QT_MOC_LITERAL(13, 149, 15), // "signal_MoveDown"
QT_MOC_LITERAL(14, 165, 14), // "signal_Drawing"
QT_MOC_LITERAL(15, 180, 3), // "cmd"
QT_MOC_LITERAL(16, 184, 4), // "type"
QT_MOC_LITERAL(17, 189, 15), // "sendNextCommand"
QT_MOC_LITERAL(18, 205, 12), // "getXPosition"
QT_MOC_LITERAL(19, 218, 12), // "getYPosition"
QT_MOC_LITERAL(20, 231, 12), // "getZPosition"
QT_MOC_LITERAL(21, 244, 12), // "getAPosition"
QT_MOC_LITERAL(22, 257, 12), // "getBPosition"
QT_MOC_LITERAL(23, 270, 12) // "getCPosition"

    },
    "AxisController\0signal_Refresh\0\0"
    "signal_WaitingForNextCommand\0"
    "signal_DrawLine\0from_x\0from_y\0to_x\0"
    "to_y\0signal_MoveX\0lineSize\0signal_MoveY\0"
    "signal_MoveUp\0signal_MoveDown\0"
    "signal_Drawing\0cmd\0type\0sendNextCommand\0"
    "getXPosition\0getYPosition\0getZPosition\0"
    "getAPosition\0getBPosition\0getCPosition"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_AxisController[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      15,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       8,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   89,    2, 0x06 /* Public */,
       3,    0,   90,    2, 0x06 /* Public */,
       4,    4,   91,    2, 0x06 /* Public */,
       9,    1,  100,    2, 0x06 /* Public */,
      11,    1,  103,    2, 0x06 /* Public */,
      12,    1,  106,    2, 0x06 /* Public */,
      13,    1,  109,    2, 0x06 /* Public */,
      14,    2,  112,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      17,    0,  117,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      18,    0,  118,    2, 0x02 /* Public */,
      19,    0,  119,    2, 0x02 /* Public */,
      20,    0,  120,    2, 0x02 /* Public */,
      21,    0,  121,    2, 0x02 /* Public */,
      22,    0,  122,    2, 0x02 /* Public */,
      23,    0,  123,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::Double,    5,    6,    7,    8,
    QMetaType::Void, QMetaType::Double,   10,
    QMetaType::Void, QMetaType::Double,   10,
    QMetaType::Void, QMetaType::Double,   10,
    QMetaType::Void, QMetaType::Double,   10,
    QMetaType::Void, QMetaType::QStringList, QMetaType::QString,   15,   16,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Double,
    QMetaType::Double,
    QMetaType::Double,
    QMetaType::Double,
    QMetaType::Double,
    QMetaType::Double,

       0        // eod
};

void AxisController::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<AxisController *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->signal_Refresh(); break;
        case 1: _t->signal_WaitingForNextCommand(); break;
        case 2: _t->signal_DrawLine((*reinterpret_cast< double(*)>(_a[1])),(*reinterpret_cast< double(*)>(_a[2])),(*reinterpret_cast< double(*)>(_a[3])),(*reinterpret_cast< double(*)>(_a[4]))); break;
        case 3: _t->signal_MoveX((*reinterpret_cast< double(*)>(_a[1]))); break;
        case 4: _t->signal_MoveY((*reinterpret_cast< double(*)>(_a[1]))); break;
        case 5: _t->signal_MoveUp((*reinterpret_cast< double(*)>(_a[1]))); break;
        case 6: _t->signal_MoveDown((*reinterpret_cast< double(*)>(_a[1]))); break;
        case 7: _t->signal_Drawing((*reinterpret_cast< QStringList(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 8: _t->sendNextCommand(); break;
        case 9: { double _r = _t->getXPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 10: { double _r = _t->getYPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 11: { double _r = _t->getZPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 12: { double _r = _t->getAPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 13: { double _r = _t->getBPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 14: { double _r = _t->getCPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (AxisController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AxisController::signal_Refresh)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (AxisController::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AxisController::signal_WaitingForNextCommand)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (AxisController::*)(double , double , double , double );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AxisController::signal_DrawLine)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (AxisController::*)(double );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AxisController::signal_MoveX)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (AxisController::*)(double );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AxisController::signal_MoveY)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (AxisController::*)(double );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AxisController::signal_MoveUp)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (AxisController::*)(double );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AxisController::signal_MoveDown)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (AxisController::*)(QStringList , QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&AxisController::signal_Drawing)) {
                *result = 7;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject AxisController::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_AxisController.data,
    qt_meta_data_AxisController,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *AxisController::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *AxisController::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_AxisController.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int AxisController::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
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
void AxisController::signal_Refresh()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void AxisController::signal_WaitingForNextCommand()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void AxisController::signal_DrawLine(double _t1, double _t2, double _t3, double _t4)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void AxisController::signal_MoveX(double _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void AxisController::signal_MoveY(double _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}

// SIGNAL 5
void AxisController::signal_MoveUp(double _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 5, _a);
}

// SIGNAL 6
void AxisController::signal_MoveDown(double _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void AxisController::signal_Drawing(QStringList _t1, QString _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
