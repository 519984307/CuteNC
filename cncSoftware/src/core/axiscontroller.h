#ifndef AXISCONTROLLER_H
#define AXISCONTROLLER_H

#include <QObject>
#include <QRegularExpression>
#include <QDebug>
namespace CuteNC_AxisController{

class AxisController : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(AxisController)
public:
    /**
      Constructor.
      Creates a AxisController handler.
      @param parent Parent object.
    */
    AxisController(QObject* parent=nullptr);

    /** Destructor */
    virtual ~AxisController();

    /**
     Closes the AxisController
    */
    void close();



    /** Calculates travel time */
    void calculateTravelTime();

    /** Sets X axis position */
    void setXPosition(const double position);
    /** Sets Y axis position */
    void setYPosition(const double position);
    /** Sets Z axis position */
    void setZPosition(const double position);
    /** Sets A axis position */
    void setAPosition(const double position);
    /** Sets B axis position */
    void setBPosition(const double position);
    /** Sets C axis position */
    void setCPosition(const double position);

    /** Returns X axis position */
    Q_INVOKABLE double getXPosition() const;
    /** Returns Y axis position */
    Q_INVOKABLE double getYPosition() const;
    /** Returns Z axis position */
    Q_INVOKABLE double getZPosition() const;
    /** Returns A axis position */
    Q_INVOKABLE double getAPosition() const;
    /** Returns B axis position */
    Q_INVOKABLE double getBPosition() const;
    /** Returns C axis position */
    Q_INVOKABLE double getCPosition() const;

    /** Returns previous motion type eg. G01 */
    QString getPreviousMotionType() const;


    /** Executes G command that has been send to the console via user input */
    void executeGCommand(const QString command);
    /** Executes M command that has been send to the console via user input */
    void executeMCommand(const QString command);
    /** Executes command that has been send to the console via user input */
    void executeCommand(QString command, QString motionType = "");

private:

    double xPosition = 0;
    double yPosition = 0;
    double zPosition = 0;
    double aPosition = 0;
    double bPosition = 0;
    double cPosition = 0;

    QString previousMotionType = "";

signals:
    /**
     Gets current positions
    */
    void refresh();

};

}

#endif // AXISCONTROLLER_H
