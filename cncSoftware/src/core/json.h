#ifndef JSON_H
#define JSON_H


#include <QObject>

namespace CuteNC{


class Json : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(Json)
public:
    /**
      Constructor.
      Creates a json files handler.
      @param parent Parent object.
    */
    Json(QObject* parent=nullptr);

    /** Destructor */
    virtual ~Json();

    /** Creates defined macro in ~/Macros/ folder
        @param macroName Marco name (name).json
        @param &data Macro contents
    */
    Q_INVOKABLE void createMacro(QString macroName,const QList<QString> &data);
signals:
    void signal_ReloadMacros();
    void refresh();

};

}
#endif // JSON_H
