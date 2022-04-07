QT += testlib
QT += widgets #filedialog

QT += quick
QT += core
QT += quickcontrols2
QT += serialport
QT += concurrent
QT += network
CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES += tst_unittest.cpp \
    backend.cpp
HEADERS += \
    backend.h

#include(../../include/QtWebApp/httpserver/httpserver.pri)



# Enable very detailed debug messages when compiling the debug version
#CONFIG(debug, debug|release) {
#    DEFINES += SUPERVERBOSE
#}



