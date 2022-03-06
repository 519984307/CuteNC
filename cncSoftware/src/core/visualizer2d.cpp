#include "visualizer2d.h"
#include "QDebug"
#include <QObject>
#include <QRegularExpression>
#include <QDebug>
#include <QtConcurrent>
Visualizer2D::Visualizer2D(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , rightAligned(false)
{
}
class GcodeCommand{
public:
    int line;
    QString type;
    QList<QStringList> commands;
};
QList<GcodeCommand> listOfCommands;
void Visualizer2D::parseFile(QList<QList<QList<QStringList>>> fileContents){
    listOfCommands.empty();
    for(int i = 0; i < fileContents.length(); i++){
        GcodeCommand gcmd;
        gcmd.line = i+1;
        gcmd.type = fileContents[i][1][0][0];
        gcmd.commands = fileContents[i][0];
        listOfCommands.append(gcmd);
    }
    drawFromFile();
}
void Visualizer2D::drawFromFile(){
    bool ok;
    foreach(GcodeCommand cmd,listOfCommands){
        qDebug() << cmd.type << " cmds " << cmd.commands;
        QString movementType = cmd.type;
        QList<QStringList> coords = cmd.commands;
        if(movementType == "G0" || movementType == "G1" || movementType == "G01" || movementType == "G00")
        {
            this->setRequestLine(true);
        }
        else if(movementType == "G2" || movementType == "G3"){
            if(movementType == "G2"){
                // this->requestArc(true);
                //canvas.arcClockwise = true;
            }
            if(movementType == "G3"){
                // canvas.isArc = true;
                // canvas.arcClockwise = false;
            }

            //canvas.isLine = false;
        }

        for(int j = 0; j < coords.length(); j++){
            qDebug() <<"coords "  <<coords[j];
            QStringList axes = coords[j];

            QString axis = axes[0];
            QString coords = axes[1];
            qDebug() << "axis " << axis;
            if(axis == "X"){
                QString temp = (QString)coords;
                float tmpF = temp.toFloat(&ok);
                this->setToX(tmpF);
                 qDebug() << "to X " << tmpF <<" " << coords;

            }

            if(axis == "Y"){
                QString temp = (QString)coords;
                float tmpF = temp.toFloat(&ok);
                this->setToY(-tmpF);
                qDebug() << "to Y " << -tmpF <<" " << coords;

            }
            update();
            QFuture<void> future1 = QtConcurrent::run(update);  // Thread 1
        }

    }
}
//                        if(axis[0] == "Z"){
//                            QString temp = (QString)axis[1];
//                            float tmpF = temp.toFloat(&ok);
//                            this->setToZ(tmpF);

//                        }
//                        if(axis[0] == "I"){
//                            QString temp = (QString)axis[1];
//                            float tmpF = temp.toFloat(&ok);
//                            this->setToX(tmpF);

//                        }

//                        if(axis[0] == "J"){
//                            QString temp = (QString)axis[1];
//                            float tmpF = temp.toFloat(&ok);
//                            this->setToX(tmpF);

//                        }

//                        if(axis[0] == "R"){
//                            QString temp = (QString)axis[1];
//                            float tmpF = temp.toFloat(&ok);
//                            this->setToX(tmpF);

//                        }
//                        case "X":

//                            break;
//                        case "Y":
//                           // canvas.newLineY=-axis[1]*scaleEverything;
//                            break;
//                        case "Z":
//                            //nothing
//                            break;
//                        case "I":
//                          //  canvas.arcStartX = canvas.lastLineX - (axis[1]*scaleEverything);
//                            break;
//                        case "J":
//                          //  canvas.arcStartY = -(canvas.lastLineY - (axis[1]*scaleEverything));
//                            break;
//                        }

void Visualizer2D::paint(QPainter *painter)
{
    painter->setRenderHint(QPainter::LosslessImageRendering);
    qDebug() << "paint";
    if(this->isInitial()){
        qDebug() << "initial";
        QBrush brush(QColor("#CCCCCC"));

        painter->setBrush(brush);
        painter->setPen(QPen(Qt::white,3));


        QSizeF itemSize = size();
        qDebug()<<"item size " << itemSize;
        int nrows=200;
        int ncols=200;
        int wgrid=10;

        this->setFromX(itemSize.width()/2);
        this->setFromY(itemSize.height()/2);

        for(int i=0; i <= nrows; i++){
            painter->drawLine(0,wgrid*i,itemSize.width(),wgrid*i);
        }

        for(int j=0; j <= ncols; j++){
            painter->drawLine(wgrid*j,0,wgrid*j,itemSize.height());
        }

        this->setInitial(false);
    }

    if(this->requestLine()){
        QSizeF itemSize = size();
        qDebug() << itemSize;
        painter->setPen(QPen(Qt::cyan,5));
        qDebug() << "line from / to " << this->fromX() <<" " <<this->fromY()<<" " <<this->toX()<<" " <<this->toY();
        painter->drawLine(this->fromX(), this->fromY(), this->toX(),this->toY());
        this->setFromX(this->toX());
        this->setFromY(this->toY());




        this->setRequestLine(false);
    }

}

bool Visualizer2D::isRightAligned(){
    return this->rightAligned;
}
void Visualizer2D::setRightAligned(bool rightAligned){
    this->rightAligned = rightAligned;
}

bool Visualizer2D::isInitial(){
    return this->initial;
}
void Visualizer2D::setInitial(bool initial){
    this->initial = initial;
}
