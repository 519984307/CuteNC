/****************************************************************************
** Meta object code from reading C++ file 'backend.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../src/core/backend.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#include <QtCore/QList>
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
    QByteArrayData data[61];
    char stringdata0[786];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_CuteNC__Backend_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_CuteNC__Backend_t qt_meta_stringdata_CuteNC__Backend = {
    {
QT_MOC_LITERAL(0, 0, 15), // "CuteNC::Backend"
QT_MOC_LITERAL(1, 16, 19), // "signal_ReloadMacros"
QT_MOC_LITERAL(2, 36, 0), // ""
QT_MOC_LITERAL(3, 37, 19), // "signal_SaveSettings"
QT_MOC_LITERAL(4, 57, 19), // "signal_LoadSettings"
QT_MOC_LITERAL(5, 77, 21), // "signal_RefreshWidgets"
QT_MOC_LITERAL(6, 99, 16), // "signal_GetThemes"
QT_MOC_LITERAL(7, 116, 12), // "signal_Ready"
QT_MOC_LITERAL(8, 129, 26), // "signal_ReadyForNextCommand"
QT_MOC_LITERAL(9, 156, 25), // "signal_DoneRunningProgram"
QT_MOC_LITERAL(10, 182, 15), // "signal_OpenFile"
QT_MOC_LITERAL(11, 198, 11), // "fileContent"
QT_MOC_LITERAL(12, 210, 15), // "signal_SaveFile"
QT_MOC_LITERAL(13, 226, 19), // "signal_DrawFromFile"
QT_MOC_LITERAL(14, 246, 21), // "appendPortsToComboBox"
QT_MOC_LITERAL(15, 268, 11), // "debugSignal"
QT_MOC_LITERAL(16, 280, 4), // "text"
QT_MOC_LITERAL(17, 285, 16), // "showNotification"
QT_MOC_LITERAL(18, 302, 6), // "v_type"
QT_MOC_LITERAL(19, 309, 9), // "v_message"
QT_MOC_LITERAL(20, 319, 10), // "handleQuit"
QT_MOC_LITERAL(21, 330, 16), // "incrementOkCount"
QT_MOC_LITERAL(22, 347, 15), // "sendNextSegment"
QT_MOC_LITERAL(23, 363, 4), // "done"
QT_MOC_LITERAL(24, 368, 5), // "debug"
QT_MOC_LITERAL(25, 374, 7), // "startUp"
QT_MOC_LITERAL(26, 382, 11), // "getFilePath"
QT_MOC_LITERAL(27, 394, 8), // "fileName"
QT_MOC_LITERAL(28, 403, 11), // "getJsonFile"
QT_MOC_LITERAL(29, 415, 11), // "createMacro"
QT_MOC_LITERAL(30, 427, 9), // "macroName"
QT_MOC_LITERAL(31, 437, 14), // "QList<QString>"
QT_MOC_LITERAL(32, 452, 4), // "data"
QT_MOC_LITERAL(33, 457, 9), // "getMacros"
QT_MOC_LITERAL(34, 467, 15), // "commandReceived"
QT_MOC_LITERAL(35, 483, 7), // "command"
QT_MOC_LITERAL(36, 491, 6), // "source"
QT_MOC_LITERAL(37, 498, 8), // "setTheme"
QT_MOC_LITERAL(38, 507, 9), // "themeName"
QT_MOC_LITERAL(39, 517, 12), // "getThemeName"
QT_MOC_LITERAL(40, 530, 8), // "position"
QT_MOC_LITERAL(41, 539, 8), // "setUnits"
QT_MOC_LITERAL(42, 548, 5), // "units"
QT_MOC_LITERAL(43, 554, 16), // "getSelectedUnits"
QT_MOC_LITERAL(44, 571, 11), // "setLanguage"
QT_MOC_LITERAL(45, 583, 4), // "lang"
QT_MOC_LITERAL(46, 588, 19), // "getSelectedLanguage"
QT_MOC_LITERAL(47, 608, 14), // "numberOfThemes"
QT_MOC_LITERAL(48, 623, 5), // "setup"
QT_MOC_LITERAL(49, 629, 16), // "getSelectedTheme"
QT_MOC_LITERAL(50, 646, 18), // "determineFontColor"
QT_MOC_LITERAL(51, 665, 5), // "color"
QT_MOC_LITERAL(52, 671, 8), // "openFile"
QT_MOC_LITERAL(53, 680, 8), // "filePath"
QT_MOC_LITERAL(54, 689, 8), // "saveFile"
QT_MOC_LITERAL(55, 698, 9), // "setupFile"
QT_MOC_LITERAL(56, 708, 12), // "getGcodeFile"
QT_MOC_LITERAL(57, 721, 16), // "startParsingFile"
QT_MOC_LITERAL(58, 738, 13), // "emergencyStop"
QT_MOC_LITERAL(59, 752, 24), // "getFileToBeSavedContents"
QT_MOC_LITERAL(60, 777, 8) // "contents"

    },
    "CuteNC::Backend\0signal_ReloadMacros\0"
    "\0signal_SaveSettings\0signal_LoadSettings\0"
    "signal_RefreshWidgets\0signal_GetThemes\0"
    "signal_Ready\0signal_ReadyForNextCommand\0"
    "signal_DoneRunningProgram\0signal_OpenFile\0"
    "fileContent\0signal_SaveFile\0"
    "signal_DrawFromFile\0appendPortsToComboBox\0"
    "debugSignal\0text\0showNotification\0"
    "v_type\0v_message\0handleQuit\0"
    "incrementOkCount\0sendNextSegment\0done\0"
    "debug\0startUp\0getFilePath\0fileName\0"
    "getJsonFile\0createMacro\0macroName\0"
    "QList<QString>\0data\0getMacros\0"
    "commandReceived\0command\0source\0setTheme\0"
    "themeName\0getThemeName\0position\0"
    "setUnits\0units\0getSelectedUnits\0"
    "setLanguage\0lang\0getSelectedLanguage\0"
    "numberOfThemes\0setup\0getSelectedTheme\0"
    "determineFontColor\0color\0openFile\0"
    "filePath\0saveFile\0setupFile\0getGcodeFile\0"
    "startParsingFile\0emergencyStop\0"
    "getFileToBeSavedContents\0contents"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_CuteNC__Backend[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      43,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      14,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,  229,    2, 0x06 /* Public */,
       3,    0,  230,    2, 0x06 /* Public */,
       4,    0,  231,    2, 0x06 /* Public */,
       5,    0,  232,    2, 0x06 /* Public */,
       6,    0,  233,    2, 0x06 /* Public */,
       7,    0,  234,    2, 0x06 /* Public */,
       8,    0,  235,    2, 0x06 /* Public */,
       9,    0,  236,    2, 0x06 /* Public */,
      10,    1,  237,    2, 0x06 /* Public */,
      12,    0,  240,    2, 0x06 /* Public */,
      13,    1,  241,    2, 0x06 /* Public */,
      14,    0,  244,    2, 0x06 /* Public */,
      15,    1,  245,    2, 0x06 /* Public */,
      17,    2,  248,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      20,    0,  253,    2, 0x0a /* Public */,
      21,    0,  254,    2, 0x0a /* Public */,
      22,    1,  255,    2, 0x0a /* Public */,
      22,    0,  258,    2, 0x2a /* Public | MethodCloned */,

 // methods: name, argc, parameters, tag, flags
      24,    0,  259,    2, 0x02 /* Public */,
      25,    0,  260,    2, 0x02 /* Public */,
      26,    1,  261,    2, 0x02 /* Public */,
      28,    1,  264,    2, 0x02 /* Public */,
      29,    2,  267,    2, 0x02 /* Public */,
      33,    0,  272,    2, 0x02 /* Public */,
      34,    2,  273,    2, 0x02 /* Public */,
      34,    1,  278,    2, 0x22 /* Public | MethodCloned */,
      37,    1,  281,    2, 0x02 /* Public */,
      39,    1,  284,    2, 0x02 /* Public */,
      41,    1,  287,    2, 0x02 /* Public */,
      43,    0,  290,    2, 0x02 /* Public */,
      44,    1,  291,    2, 0x02 /* Public */,
      46,    0,  294,    2, 0x02 /* Public */,
      47,    0,  295,    2, 0x02 /* Public */,
      48,    0,  296,    2, 0x02 /* Public */,
      49,    0,  297,    2, 0x02 /* Public */,
      50,    1,  298,    2, 0x02 /* Public */,
      52,    1,  301,    2, 0x02 /* Public */,
      54,    1,  304,    2, 0x02 /* Public */,
      55,    1,  307,    2, 0x02 /* Public */,
      56,    0,  310,    2, 0x02 /* Public */,
      57,    0,  311,    2, 0x02 /* Public */,
      58,    0,  312,    2, 0x02 /* Public */,
      59,    1,  313,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   11,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   11,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   16,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   18,   19,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,   23,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::QString, QMetaType::QString,   27,
    QMetaType::QString, QMetaType::QString,   27,
    QMetaType::Void, QMetaType::QString, 0x80000000 | 31,   30,   32,
    QMetaType::QStringList,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,   35,   36,
    QMetaType::Void, QMetaType::QString,   35,
    QMetaType::Void, QMetaType::QString,   38,
    QMetaType::QString, QMetaType::Int,   40,
    QMetaType::Void, QMetaType::Bool,   42,
    QMetaType::Bool,
    QMetaType::Void, QMetaType::QString,   45,
    QMetaType::QString,
    QMetaType::Int,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Bool, QMetaType::QString,   51,
    QMetaType::Void, QMetaType::QString,   53,
    QMetaType::Void, QMetaType::QString,   53,
    QMetaType::Void, QMetaType::QString,   11,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   60,

       0        // eod
};

void CuteNC::Backend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Backend *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->signal_ReloadMacros(); break;
        case 1: _t->signal_SaveSettings(); break;
        case 2: _t->signal_LoadSettings(); break;
        case 3: _t->signal_RefreshWidgets(); break;
        case 4: _t->signal_GetThemes(); break;
        case 5: _t->signal_Ready(); break;
        case 6: _t->signal_ReadyForNextCommand(); break;
        case 7: _t->signal_DoneRunningProgram(); break;
        case 8: _t->signal_OpenFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->signal_SaveFile(); break;
        case 10: _t->signal_DrawFromFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 11: _t->appendPortsToComboBox(); break;
        case 12: _t->debugSignal((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 13: _t->showNotification((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 14: _t->handleQuit(); break;
        case 15: _t->incrementOkCount(); break;
        case 16: _t->sendNextSegment((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 17: _t->sendNextSegment(); break;
        case 18: _t->debug(); break;
        case 19: _t->startUp(); break;
        case 20: { QString _r = _t->getFilePath((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 21: { QString _r = _t->getJsonFile((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 22: _t->createMacro((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QList<QString>(*)>(_a[2]))); break;
        case 23: { QStringList _r = _t->getMacros();
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = std::move(_r); }  break;
        case 24: _t->commandReceived((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 25: _t->commandReceived((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 26: _t->setTheme((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 27: { QString _r = _t->getThemeName((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 28: _t->setUnits((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 29: { bool _r = _t->getSelectedUnits();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 30: _t->setLanguage((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 31: { QString _r = _t->getSelectedLanguage();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 32: { int _r = _t->numberOfThemes();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 33: _t->setup(); break;
        case 34: { QString _r = _t->getSelectedTheme();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 35: { bool _r = _t->determineFontColor((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 36: _t->openFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 37: _t->saveFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 38: _t->setupFile((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 39: { QString _r = _t->getGcodeFile();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 40: _t->startParsingFile(); break;
        case 41: _t->emergencyStop(); break;
        case 42: _t->getFileToBeSavedContents((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 22:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 1:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QList<QString> >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_ReloadMacros)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_SaveSettings)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_LoadSettings)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_RefreshWidgets)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_GetThemes)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_Ready)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_ReadyForNextCommand)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_DoneRunningProgram)) {
                *result = 7;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_OpenFile)) {
                *result = 8;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_SaveFile)) {
                *result = 9;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::signal_DrawFromFile)) {
                *result = 10;
                return;
            }
        }
        {
            using _t = void (Backend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::appendPortsToComboBox)) {
                *result = 11;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::debugSignal)) {
                *result = 12;
                return;
            }
        }
        {
            using _t = void (Backend::*)(QString , QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&Backend::showNotification)) {
                *result = 13;
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
        if (_id < 43)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 43;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 43)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 43;
    }
    return _id;
}

// SIGNAL 0
void CuteNC::Backend::signal_ReloadMacros()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void CuteNC::Backend::signal_SaveSettings()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void CuteNC::Backend::signal_LoadSettings()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void CuteNC::Backend::signal_RefreshWidgets()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void CuteNC::Backend::signal_GetThemes()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void CuteNC::Backend::signal_Ready()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void CuteNC::Backend::signal_ReadyForNextCommand()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void CuteNC::Backend::signal_DoneRunningProgram()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}

// SIGNAL 8
void CuteNC::Backend::signal_OpenFile(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 8, _a);
}

// SIGNAL 9
void CuteNC::Backend::signal_SaveFile()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}

// SIGNAL 10
void CuteNC::Backend::signal_DrawFromFile(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 10, _a);
}

// SIGNAL 11
void CuteNC::Backend::appendPortsToComboBox()
{
    QMetaObject::activate(this, &staticMetaObject, 11, nullptr);
}

// SIGNAL 12
void CuteNC::Backend::debugSignal(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 12, _a);
}

// SIGNAL 13
void CuteNC::Backend::showNotification(QString _t1, QString _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 13, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
