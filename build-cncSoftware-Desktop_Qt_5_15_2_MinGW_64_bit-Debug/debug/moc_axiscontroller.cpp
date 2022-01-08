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
    QByteArrayData data[11];
    char stringdata0[154];
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
QT_MOC_LITERAL(4, 60, 15), // "sendNextCommand"
QT_MOC_LITERAL(5, 76, 12), // "getXPosition"
QT_MOC_LITERAL(6, 89, 12), // "getYPosition"
QT_MOC_LITERAL(7, 102, 12), // "getZPosition"
QT_MOC_LITERAL(8, 115, 12), // "getAPosition"
QT_MOC_LITERAL(9, 128, 12), // "getBPosition"
QT_MOC_LITERAL(10, 141, 12) // "getCPosition"

    },
    "AxisController\0signal_Refresh\0\0"
    "signal_WaitingForNextCommand\0"
    "sendNextCommand\0getXPosition\0getYPosition\0"
    "getZPosition\0getAPosition\0getBPosition\0"
    "getCPosition"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_AxisController[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       9,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   59,    2, 0x06 /* Public */,
       3,    0,   60,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       4,    0,   61,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
       5,    0,   62,    2, 0x02 /* Public */,
       6,    0,   63,    2, 0x02 /* Public */,
       7,    0,   64,    2, 0x02 /* Public */,
       8,    0,   65,    2, 0x02 /* Public */,
       9,    0,   66,    2, 0x02 /* Public */,
      10,    0,   67,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

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
        case 2: _t->sendNextCommand(); break;
        case 3: { double _r = _t->getXPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 4: { double _r = _t->getYPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 5: { double _r = _t->getZPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 6: { double _r = _t->getAPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 7: { double _r = _t->getBPosition();
            if (_a[0]) *reinterpret_cast< double*>(_a[0]) = std::move(_r); }  break;
        case 8: { double _r = _t->getCPosition();
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
        if (_id < 9)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 9;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 9)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 9;
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
QT_WARNING_POP
QT_END_MOC_NAMESPACE
