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
    QByteArrayData data[25];
    char stringdata0[277];
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
QT_MOC_LITERAL(4, 41, 11), // "debugSignal"
QT_MOC_LITERAL(5, 53, 4), // "text"
QT_MOC_LITERAL(6, 58, 14), // "refreshWidgets"
QT_MOC_LITERAL(7, 73, 16), // "showNotification"
QT_MOC_LITERAL(8, 90, 6), // "v_type"
QT_MOC_LITERAL(9, 97, 9), // "v_message"
QT_MOC_LITERAL(10, 107, 10), // "handleQuit"
QT_MOC_LITERAL(11, 118, 7), // "startUp"
QT_MOC_LITERAL(12, 126, 5), // "debug"
QT_MOC_LITERAL(13, 132, 15), // "commandReceived"
QT_MOC_LITERAL(14, 148, 7), // "command"
QT_MOC_LITERAL(15, 156, 11), // "getJSONFile"
QT_MOC_LITERAL(16, 168, 4), // "path"
QT_MOC_LITERAL(17, 173, 8), // "filename"
QT_MOC_LITERAL(18, 182, 8), // "setTheme"
QT_MOC_LITERAL(19, 191, 9), // "themeName"
QT_MOC_LITERAL(20, 201, 12), // "getThemeName"
QT_MOC_LITERAL(21, 214, 8), // "position"
QT_MOC_LITERAL(22, 223, 14), // "numberOfThemes"
QT_MOC_LITERAL(23, 238, 21), // "refreshWidgetsInvoker"
QT_MOC_LITERAL(24, 260, 16) // "getSelectedTheme"

    },
    "Backend\0appendPortsToComboBox\0\0getThemes\0"
    "debugSignal\0text\0refreshWidgets\0"
    "showNotification\0v_type\0v_message\0"
    "handleQuit\0startUp\0debug\0commandReceived\0"
    "command\0getJSONFile\0path\0filename\0"
    "setTheme\0themeName\0getThemeName\0"
    "position\0numberOfThemes\0refreshWidgetsInvoker\0"
    "getSelectedTheme"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Backend[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      15,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   89,    2, 0x06 /* Public */,
       3,    0,   90,    2, 0x06 /* Public */,
       4,    1,   91,    2, 0x06 /* Public */,
       6,    0,   94,    2, 0x06 /* Public */,
       7,    2,   95,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      10,    0,  100,    2, 0x0a /* Public */,

 // methods: name, argc, parameters, tag, flags
      11,    0,  101,    2, 0x02 /* Public */,
      12,    0,  102,    2, 0x02 /* Public */,
      13,    1,  103,    2, 0x02 /* Public */,
      15,    2,  106,    2, 0x02 /* Public */,
      18,    1,  111,    2, 0x02 /* Public */,
      20,    1,  114,    2, 0x02 /* Public */,
      22,    0,  117,    2, 0x02 /* Public */,
      23,    0,  118,    2, 0x02 /* Public */,
      24,    0,  119,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    5,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    8,    9,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   14,
    QMetaType::QString, QMetaType::QString, QMetaType::QString,   16,   17,
    QMetaType::Void, QMetaType::QString,   19,
    QMetaType::QString, QMetaType::Int,   21,
    QMetaType::Int,
    QMetaType::Void,
    QMetaType::QString,

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
        case 2: _t->debugSignal((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->refreshWidgets(); break;
        case 4: _t->showNotification((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 5: _t->handleQuit(); break;
        case 6: _t->startUp(); break;
        case 7: _t->debug(); break;
        case 8: _t->commandReceived((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: { QString _r = _t->getJSONFile((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 10: _t->setTheme((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 11: { QString _r = _t->getThemeName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 12: { int _r = _t->numberOfThemes();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 13: _t->refreshWidgetsInvoker(); break;
        case 14: { QString _r = _t->getSelectedTheme();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
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
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::debugSignal)) {
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
        {
            using _t = void (Backend::*)(QString , QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::showNotification)) {
                *result = 4;
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
void Backend::debugSignal(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void Backend::refreshWidgets()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void Backend::showNotification(QString _t1, QString _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
