/****************************************************************************
** Meta object code from reading C++ file 'backend.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../cncSoftware/src/core/backend.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'backend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Backend_t {
    QByteArrayData data[20];
    char stringdata0[215];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Backend_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Backend_t qt_meta_stringdata_Backend = {
    {
QT_MOC_LITERAL(0, 0, 7), // "Backend"
QT_MOC_LITERAL(1, 8, 21), // "appendPortsToComboBox"
QT_MOC_LITERAL(2, 30, 0), // ""
QT_MOC_LITERAL(3, 31, 9), // "getThemes"
QT_MOC_LITERAL(4, 41, 11), // "debugSingal"
QT_MOC_LITERAL(5, 53, 4), // "text"
QT_MOC_LITERAL(6, 58, 14), // "refreshWidgets"
QT_MOC_LITERAL(7, 73, 7), // "startUp"
QT_MOC_LITERAL(8, 81, 5), // "debug"
QT_MOC_LITERAL(9, 87, 15), // "commandReceived"
QT_MOC_LITERAL(10, 103, 7), // "command"
QT_MOC_LITERAL(11, 111, 11), // "getJSONFile"
QT_MOC_LITERAL(12, 123, 4), // "path"
QT_MOC_LITERAL(13, 128, 8), // "filename"
QT_MOC_LITERAL(14, 137, 8), // "setTheme"
QT_MOC_LITERAL(15, 146, 9), // "themeName"
QT_MOC_LITERAL(16, 156, 12), // "getThemeName"
QT_MOC_LITERAL(17, 169, 8), // "position"
QT_MOC_LITERAL(18, 178, 14), // "numberOfThemes"
QT_MOC_LITERAL(19, 193, 21) // "refreshWidgetsInvoker"

    },
    "Backend\0appendPortsToComboBox\0\0getThemes\0"
    "debugSingal\0text\0refreshWidgets\0startUp\0"
    "debug\0commandReceived\0command\0getJSONFile\0"
    "path\0filename\0setTheme\0themeName\0"
    "getThemeName\0position\0numberOfThemes\0"
    "refreshWidgetsInvoker"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Backend[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      12,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   74,    2, 0x06 /* Public */,
       3,    0,   75,    2, 0x06 /* Public */,
       4,    1,   76,    2, 0x06 /* Public */,
       6,    0,   79,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       7,    0,   80,    2, 0x02 /* Public */,
       8,    0,   81,    2, 0x02 /* Public */,
       9,    1,   82,    2, 0x02 /* Public */,
      11,    2,   85,    2, 0x02 /* Public */,
      14,    1,   90,    2, 0x02 /* Public */,
      16,    1,   93,    2, 0x02 /* Public */,
      18,    0,   96,    2, 0x02 /* Public */,
      19,    0,   97,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    5,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   10,
    QMetaType::QString, QMetaType::QString, QMetaType::QString,   12,   13,
    QMetaType::Void, QMetaType::QString,   15,
    QMetaType::QString, QMetaType::Int,   17,
    QMetaType::Int,
    QMetaType::Void,

       0        // eod
};

void Backend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Backend *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->appendPortsToComboBox(); break;
        case 1: _t->getThemes(); break;
        case 2: _t->debugSingal((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->refreshWidgets(); break;
        case 4: _t->startUp(); break;
        case 5: _t->debug(); break;
        case 6: _t->commandReceived((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 7: { QString _r = _t->getJSONFile((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 8: _t->setTheme((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: { QString _r = _t->getThemeName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 10: { int _r = _t->numberOfThemes();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 11: _t->refreshWidgetsInvoker(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::appendPortsToComboBox)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::getThemes)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::debugSingal)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::refreshWidgets)) {
                *result = 3;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject Backend::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_Backend.data,
    qt_meta_data_Backend,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *Backend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Backend::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Backend.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Backend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 12)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 12)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 12;
    }
    return _id;
}

// SIGNAL 0
void Backend::appendPortsToComboBox()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void Backend::getThemes()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Backend::debugSingal(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Backend::refreshWidgets()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
