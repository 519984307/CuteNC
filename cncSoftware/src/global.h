#ifndef GLOBAL_H
#define GLOBAL_H
#include "src/core/backend.h"
#include "src/console/console.h"
#include "src/serialport/serial.h"
#include "src/websocket/websocket.h"
#include "src/core/fileparser.h"
#include "src/core/keymapper.h"
#include "src/core/json.h"

#include "httpsessionstore.h"
#include "staticfilecontroller.h"

/** Get the application version number */
DECLSPEC const char* getCuteNCVersion();

extern Backend backend;
extern Console console;
extern Comport comport;

extern KeyMapper keyMapper;

extern FileParser fileparser;

using namespace CuteNC;
extern Json* json;



using namespace stefanfrings;
extern HttpSessionStore* sessionStore;
extern StaticFileController* staticFileController;


#endif
