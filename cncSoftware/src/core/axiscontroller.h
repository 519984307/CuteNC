#ifndef AXISCONTROLLER_H
#define AXISCONTROLLER_H

#include <QObject>
#include <QRegularExpression>
#include <QDebug>
#include <QtConcurrent>

class AxisController : public QObject
{
    Q_OBJECT
public:
    /**
      Constructor.
      Creates a AxisController handler.
      @param parent Parent object.
    */
    explicit AxisController(QObject* parent = nullptr);

    /** Destructor */
    virtual ~AxisController();
    /** Closes the AxisController */
    void close();
    /** Start the AxisController */
    void startUp();


    /** Calculates travel time */
    static void calculateTravelTime(AxisController *parent, QStringList command, QString motionType);

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

    /** Draws onto 2D viewer current gcode path */
    void draw2D();

    /** Executes G command that has been send to the console via user input */
    void executeGCommand(const QString command);
    /** Executes M command that has been send to the console via user input */
    void executeMCommand(const QString command, const QString type);
    /** Executes command that has been send to the console via user input */
    void executeCommand(QStringList commands, QString motionType = "", bool isExecuting = false);

    bool startReading = false;
public slots:
    /** Sends next command from buffer to comport after previous one finished*/
    void sendNextCommand();
private:
    double xPosition = 0;
    double yPosition = 0;
    double zPosition = 0;
    double aPosition = 0;
    double bPosition = 0;
    double cPosition = 0;

signals:
    /**
     Gets current positions
    */
    void signal_Refresh();

    void signal_WaitingForNextCommand();

    void signal_DrawLine(double from_x, double from_y, double to_x, double to_y);


    void signal_MoveX(double lineSize);
    void signal_MoveY(double lineSize);
    void signal_MoveUp(double lineSize);
    void signal_MoveDown(double lineSize);

    void signal_Drawing(QStringList cmd, QString type);
};



#endif // AXISCONTROLLER_H
