#ifndef AXISCONTROLLER_H
#define AXISCONTROLLER_H

#include <QObject>

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

    /** Creates defined macro in ~/Macros/ folder
        @param macroName Marco name (name).json
        @param &data Macro contents
    */
    Q_INVOKABLE double getAxisPosition(int axis);
    /**
     Closes the AxisController
    */
    void close();

signals:
    /**
     Gets current positions
    */
    void refresh();

};

}

#endif // AXISCONTROLLER_H
