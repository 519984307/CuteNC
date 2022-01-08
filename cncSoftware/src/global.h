#ifndef GLOBAL_H
#define GLOBAL_H

#include <QtGlobal>

#include "src/websocket/websocket.h"
#include "src/core/fileparser.h"
#include "src/core/keymapper.h"
#include "src/core/json.h"

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


extern KeyMapper keyMapper;

extern FileParser fileparser;

using namespace CuteNC;
extern Json* json;

using namespace stefanfrings;
extern HttpSessionStore* sessionStore;
extern StaticFileController* staticFileController;

#endif
