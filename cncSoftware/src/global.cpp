#include "global.h"

HttpSessionStore* sessionStore;
StaticFileController* staticFileController;
Json* json;
using namespace CuteNC_AxisController;
AxisController* axisController;

const char* getCuteNCVersion()
{
    return "0.6.0 Pre-alpha";
}



