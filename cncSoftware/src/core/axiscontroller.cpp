#include "axiscontroller.h"

using namespace CuteNC_AxisController;

AxisController::AxisController(QObject *parent)
    : QObject{parent}
{

}

AxisController::~AxisController(){
    close();
    qDebug("Backend: destroyed");
}

void AxisController::close() {
    qDebug("AxisController: closed");

}

double AxisController::getAxisPosition(int axis){
    //1-X 2-Y 3-Z 4-A 5-B 6-C
    switch(axis){
    case 1:
        return 0.0000;
        break;
    case 2:
        return 0.0000;
        break;
    case 3:
        return 0.0000;
        break;
    case 4:
        return 0.0000;
        break;
    case 5:
        return 0.0000;
        break;
    case 6:
        return 0.0000;
        break;
    }
}
