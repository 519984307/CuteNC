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
struct qt_meta_stringdata_CuteNC__Backend_t {
    QByteArrayData data[57];
    char stringdata0[746];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_CuteNC__Backend_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_CuteNC__Backend_t qt_meta_stringdata_CuteNC__Backend = {
    {
QT_MOC_LITERAL(0, 0, 15), // "CuteNC::Backend"
QT_MOC_LITERAL(1, 16, 19), // "signal_SaveSettings"
QT_MOC_LITERAL(2, 36, 0), // ""
QT_MOC_LITERAL(3, 37, 19), // "signal_LoadSettings"
QT_MOC_LITERAL(4, 57, 21), // "signal_RefreshWidgets"
QT_MOC_LITERAL(5, 79, 16), // "signal_GetThemes"
QT_MOC_LITERAL(6, 96, 12), // "signal_Ready"
QT_MOC_LITERAL(7, 109, 26), // "signal_ReadyForNextCommand"
QT_MOC_LITERAL(8, 136, 25), // "signal_DoneRunningProgram"
QT_MOC_LITERAL(9, 162, 15), // "signal_OpenFile"
QT_MOC_LITERAL(10, 178, 11), // "fileContent"
QT_MOC_LITERAL(11, 190, 15), // "signal_SaveFile"
QT_MOC_LITERAL(12, 206, 19), // "signal_DrawFromFile"
QT_MOC_LITERAL(13, 226, 21), // "appendPortsToComboBox"
QT_MOC_LITERAL(14, 248, 11), // "debugSignal"
QT_MOC_LITERAL(15, 260, 4), // "text"
QT_MOC_LITERAL(16, 265, 16), // "showNotification"
QT_MOC_LITERAL(17, 282, 6), // "v_type"
QT_MOC_LITERAL(18, 289, 9), // "v_message"
QT_MOC_LITERAL(19, 299, 10), // "handleQuit"
QT_MOC_LITERAL(20, 310, 16), // "incrementOkCount"
QT_MOC_LITERAL(21, 327, 15), // "sendNextSegment"
QT_MOC_LITERAL(22, 343, 4), // "done"
QT_MOC_LITERAL(23, 348, 5), // "debug"
QT_MOC_LITERAL(24, 354, 7), // "startUp"
QT_MOC_LITERAL(25, 362, 11), // "getFilePath"
QT_MOC_LITERAL(26, 374, 8), // "fileName"
QT_MOC_LITERAL(27, 383, 11), // "getJsonFile"
QT_MOC_LITERAL(28, 395, 15), // "commandReceived"
QT_MOC_LITERAL(29, 411, 7), // "command"
QT_MOC_LITERAL(30, 419, 6), // "source"
QT_MOC_LITERAL(31, 426, 9), // "getMacros"
QT_MOC_LITERAL(32, 436, 8), // "setTheme"
QT_MOC_LITERAL(33, 445, 9), // "themeName"
QT_MOC_LITERAL(34, 455, 12), // "getThemeName"
QT_MOC_LITERAL(35, 468, 8), // "position"
QT_MOC_LITERAL(36, 477, 8), // "setUnits"
QT_MOC_LITERAL(37, 486, 5), // "units"
QT_MOC_LITERAL(38, 492, 16), // "getSelectedUnits"
QT_MOC_LITERAL(39, 509, 11), // "setLanguage"
QT_MOC_LITERAL(40, 521, 4), // "lang"
QT_MOC_LITERAL(41, 526, 19), // "getSelectedLanguage"
QT_MOC_LITERAL(42, 546, 14), // "numberOfThemes"
QT_MOC_LITERAL(43, 561, 21), // "refreshWidgetsInvoker"
QT_MOC_LITERAL(44, 583, 5), // "setup"
QT_MOC_LITERAL(45, 589, 16), // "getSelectedTheme"
QT_MOC_LITERAL(46, 606, 18), // "determineFontColor"
QT_MOC_LITERAL(47, 625, 5), // "color"
QT_MOC_LITERAL(48, 631, 8), // "openFile"
QT_MOC_LITERAL(49, 640, 8), // "filePath"
QT_MOC_LITERAL(50, 649, 8), // "saveFile"
QT_MOC_LITERAL(51, 658, 9), // "setupFile"
QT_MOC_LITERAL(52, 668, 12), // "getGcodeFile"
QT_MOC_LITERAL(53, 681, 16), // "startParsingFile"
QT_MOC_LITERAL(54, 698, 13), // "emergencyStop"
QT_MOC_LITERAL(55, 712, 24), // "getFileToBeSavedContents"
QT_MOC_LITERAL(56, 737, 8) // "contents"

    },
    "CuteNC::Backend\0signal_SaveSettings\0"
    "\0signal_LoadSettings\0signal_RefreshWidgets\0"
    "signal_GetThemes\0signal_Ready\0"
    "signal_ReadyForNextCommand\0"
    "signal_DoneRunningProgram\0signal_OpenFile\0"
    "fileContent\0signal_SaveFile\0"
    "signal_DrawFromFile\0appendPortsToComboBox\0"
    "debugSignal\0text\0showNotification\0"
    "v_type\0v_message\0handleQuit\0"
    "incrementOkCount\0sendNextSegment\0done\0"
    "debug\0startUp\0getFilePath\0fileName\0"
    "getJsonFile\0commandReceived\0command\0"
    "source\0getMacros\0setTheme\0themeName\0"
    "getThemeName\0position\0setUnits\0units\0"
    "getSelectedUnits\0setLanguage\0lang\0"
    "getSelectedLanguage\0numberOfThemes\0"
    "refreshWidgetsInvoker\0setup\0"
    "getSelectedTheme\0determineFontColor\0"
    "color\0openFile\0filePath\0saveFile\0"
    "setupFile\0getGcodeFile\0startParsingFile\0"
    "emergencyStop\0getFileToBeSavedContents\0"
    "contents"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_CuteNC__Backend[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      42,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      13,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,  224,    2, 0x06 /* Public */,
       3,    0,  225,    2, 0x06 /* Public */,
       4,    0,  226,    2, 0x06 /* Public */,
       5,    0,  227,    2, 0x06 /* Public */,
       6,    0,  228,    2, 0x06 /* Public */,
       7,    0,  229,    2, 0x06 /* Public */,
       8,    0,  230,    2, 0x06 /* Public */,
       9,    1,  231,    2, 0x06 /* Public */,
      11,    0,  234,    2, 0x06 /* Public */,
      12,    1,  235,    2, 0x06 /* Public */,
      13,    0,  238,    2, 0x06 /* Public */,
      14,    1,  239,    2, 0x06 /* Public */,
      16,    2,  242,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      19,    0,  247,    2, 0x0a /* Public */,
      20,    0,  248,    2, 0x0a /* Public */,
      21,    1,  249,    2, 0x0a /* Public */,
      21,    0,  252,    2, 0x2a /* Public | MethodCloned */,

 // methods: name, argc, parameters, tag, flags
      23,    0,  253,    2, 0x02 /* Public */,
      24,    0,  254,    2, 0x02 /* Public */,
      25,    1,  255,    2, 0x02 /* Public */,
      27,    1,  258,    2, 0x02 /* Public */,
      28,    2,  261,    2, 0x02 /* Public */,
      28,    1,  266,    2, 0x22 /* Public | MethodCloned */,
      31,    0,  269,    2, 0x02 /* Public */,
      32,    1,  270,    2, 0x02 /* Public */,
      34,    1,  273,    2, 0x02 /* Public */,
      36,    1,  276,    2, 0x02 /* Public */,
      38,    0,  279,    2, 0x02 /* Public */,
      39,    1,  280,    2, 0x02 /* Public */,
      41,    0,  283,    2, 0x02 /* Public */,
      42,    0,  284,    2, 0x02 /* Public */,
      43,    0,  285,    2, 0x02 /* Public */,
      44,    0,  286,    2, 0x02 /* Public */,
      45,    0,  287,    2, 0x02 /* Public */,
      46,    1,  288,    2, 0x02 /* Public */,
      48,    1,  291,    2, 0x02 /* Public */,
      50,    1,  294,    2, 0x02 /* Public */,
      51,    1,  297,    2, 0x02 /* Public */,
      52,    0,  300,    2, 0x02 /* Public */,
      53,    0,  301,    2, 0x02 /* Public */,
      54,    0,  302,    2, 0x02 /* Public */,
      55,    1,  303,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   10,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   10,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   15,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   17,   18,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,   22,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString, QMetaType::QString,   26,
    QMetaType::QString, QMetaType::QString,   26,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   29,   30,
    QMetaType::Void, QMetaType::QString,   29,
    QMetaType::QStringList,
    QMetaType::Void, QMetaType::QString,   33,
    QMetaType::QString, QMetaType::Int,   35,
    QMetaType::Void, QMetaType::Bool,   37,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::QString,   40,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Bool, QMetaType::QString,   47,
    QMetaType::Void, QMetaType::QString,   49,
    QMetaType::Void, QMetaType::QString,   49,
    QMetaType::Void, QMetaType::QString,   10,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   56,

       0        // eod
};

void CuteNC::Backend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Backend *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->signal_SaveSettings(); break;
        case 1: _t->signal_LoadSettings(); break;
        case 2: _t->signal_RefreshWidgets(); break;
        case 3: _t->signal_GetThemes(); break;
        case 4: _t->signal_Ready(); break;
        case 5: _t->signal_ReadyForNextCommand(); break;
        case 6: _t->signal_DoneRunningProgram(); break;
        case 7: _t->signal_OpenFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 8: _t->signal_SaveFile(); break;
        case 9: _t->signal_DrawFromFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 10: _t->appendPortsToComboBox(); break;
        case 11: _t->debugSignal((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 12: _t->showNotification((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 13: _t->handleQuit(); break;
        case 14: _t->incrementOkCount(); break;
        case 15: _t->sendNextSegment((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 16: _t->sendNextSegment(); break;
        case 17: _t->debug(); break;
        case 18: _t->startUp(); break;
        case 19: { QString _r = _t->getFilePath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 20: { QString _r = _t->getJsonFile((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 21: _t->commandReceived((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 22: _t->commandReceived((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 23: { QStringList _r = _t->getMacros();
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = std::move(_r); }  break;
        case 24: _t->setTheme((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 25: { QString _r = _t->getThemeName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 26: _t->setUnits((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 27: { bool _r = _t->getSelectedUnits();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 28: _t->setLanguage((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 29: { QString _r = _t->getSelectedLanguage();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 30: { int _r = _t->numberOfThemes();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 31: _t->refreshWidgetsInvoker(); break;
        case 32: _t->setup(); break;
        case 33: { QString _r = _t->getSelectedTheme();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 34: { bool _r = _t->determineFontColor((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 35: _t->openFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 36: _t->saveFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 37: _t->setupFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 38: { QString _r = _t->getGcodeFile();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 39: _t->startParsingFile(); break;
        case 40: _t->emergencyStop(); break;
        case 41: _t->getFileToBeSavedContents((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_SaveSettings)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_LoadSettings)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_RefreshWidgets)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_GetThemes)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_Ready)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_ReadyForNextCommand)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_DoneRunningProgram)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_OpenFile)) {
                *result = 7;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_SaveFile)) {
                *result = 8;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_DrawFromFile)) {
                *result = 9;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::appendPortsToComboBox)) {
                *result = 10;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::debugSignal)) {
                *result = 11;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QString , QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::showNotification)) {
                *result = 12;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject CuteNC::Backend::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CuteNC__Backend.data,
    qt_meta_data_CuteNC__Backend,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *CuteNC::Backend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *CuteNC::Backend::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CuteNC__Backend.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int CuteNC::Backend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 42)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 42;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 42)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 42;
    }
    return _id;
}

// SIGNAL 0
void CuteNC::Backend::signal_SaveSettings()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void CuteNC::Backend::signal_LoadSettings()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void CuteNC::Backend::signal_RefreshWidgets()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void CuteNC::Backend::signal_GetThemes()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void CuteNC::Backend::signal_Ready()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void CuteNC::Backend::signal_ReadyForNextCommand()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void CuteNC::Backend::signal_DoneRunningProgram()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void CuteNC::Backend::signal_OpenFile(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void CuteNC::Backend::signal_SaveFile()
{
    QMetaObject::activate(this, &staticMetaObject, 8, nullptr);
}

// SIGNAL 9
void CuteNC::Backend::signal_DrawFromFile(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}

// SIGNAL 10
void CuteNC::Backend::appendPortsToComboBox()
{
    QMetaObject::activate(this, &staticMetaObject, 10, nullptr);
}

// SIGNAL 11
void CuteNC::Backend::debugSignal(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 11, _a);
}

// SIGNAL 12
void CuteNC::Backend::showNotification(QString _t1, QString _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 12, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
