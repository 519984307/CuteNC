#ifndef GLOBAL_H
#define GLOBAL_H

#include <QtGlobal>

#include "../src/websocket/websocket.h"

#include "httpsessionstore.h"
#include "staticfilecontroller.h"


// This is specific to Windows dll's
#if defined(Q_OS_WIN)
    #if defined(QTWEBAPPLIB_EXPORT)
        #define DECLSPEC Q_DECL_EXPORT
    #elif defined(QTWEBAPPLIB_IMPORT)
        #define DECLSPEC Q_DECL_IMPORT
    #endif
#endif
#if !defined(DECLSPEC)
    #define DECLSPEC
#endif

/** Get the application version */
DECLSPEC const char* getCuteNCVersion();

#if __cplusplus < 201103L
    #define nullptr 0
#endif

using namespace stefanfrings;
extern HttpSessionStore* sessionStore;
extern StaticFileController* staticFileController;

#endif
