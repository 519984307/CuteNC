#ifndef VISUALIZER2D_H
#define VISUALIZER2D_H

#include <QQuickItem>
#include <QPainter>
#include <QQuickPaintedItem>

class Visualizer2D : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(bool rightAligned READ isRightAligned WRITE setRightAligned NOTIFY rightAlignedChanged)
    Q_PROPERTY(bool initial READ isInitial WRITE setInitial NOTIFY initialChanged)
    Q_PROPERTY(bool line READ requestLine WRITE setRequestLine NOTIFY requestLineChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)


    Q_PROPERTY(float fromX READ fromX WRITE setFromX NOTIFY fromXChanged)
    Q_PROPERTY(float fromY READ fromY WRITE setFromY NOTIFY fromYChanged)
    Q_PROPERTY(float toX READ toX WRITE setToX NOTIFY toXChanged)
    Q_PROPERTY(float toY READ toY WRITE setToY NOTIFY toYChanged)

    Q_PROPERTY(QList<QList<QStringList>> command READ command WRITE setCommand NOTIFY commandChanged)

   // Q_PROPERTY(float color READ color WRITE setColor NOTIFY colorChanged)
    //Q_PROPERTY(float color READ color WRITE setColor NOTIFY colorChanged)

    QML_ELEMENT

    public:
        Visualizer2D(QQuickItem *parent = 0);

        Q_INVOKABLE void paint(QPainter *painter);
        Q_INVOKABLE void parseFile(QList<QList<QList<QStringList>>> fileContents);
        //Q_INVOKABLE void init(QPainter *painter);
        void drawFromFile();
        int scale = 1;

        bool isRightAligned();
        void setRightAligned(bool rightAligned);

        bool isInitial();
        bool requestLine() const
        {
            return this->line;
        }
        QList<QList<QStringList>> command() const{
            return m_command;
        }
        void setInitial(bool initial);
        QColor color() const
        {
            return m_color;
        }

        float fromX() const
        {
            return m_fromX;
        }
        float fromY() const
        {
            return m_fromY;
        }
        float toX() const
        {
            return m_toX;
        }
        float toY() const
        {
            return m_toY;
        }

        Q_INVOKABLE void requestPaint(){
            update();
        }
    public slots:
    void setRequestLine(bool line){
        this->line = line;
        emit requestLineChanged();
    }
    void setColor(QColor color)
    {
        m_color = color;
        emit colorChanged(m_color);
        update();
    }

    void setFromX(float fromX)
    {
        m_fromX = fromX;
        emit fromXChanged(m_fromX);
    }
    void setFromY(float fromY)
    {
        m_fromY = fromY;
        emit fromYChanged(m_fromY);
    }
    void setToX(float toX)
    {
        m_toX = toX;
        emit toXChanged(m_toX);
    }
    void setToY(float toY)
    {
        m_toY = toY;
        emit toYChanged(m_toY);
    }
    void setCommand(QList<QList<QStringList>> command)
    {
        m_command = command;
        emit commandChanged(m_command);
        this->line = true;
    }

    private:
        bool rightAligned;
        bool initial = true;
        bool line = false;
        QColor m_color;
        float m_fromX = 0;
        float m_fromY = 0;
        float m_toX = 0;
        float m_toY = 0;
        QPainter *m_painter;
        QList<QList<QStringList>> m_command;
    signals:
        void rightAlignedChanged();
        void initialChanged();
        void requestLineChanged();
        void colorChanged(QColor color);

        void fromXChanged(float fromX);
        void fromYChanged(float fromY);
        void toXChanged(float toX);
        void toYChanged(float toY);

        void commandChanged(QList<QList<QStringList>> command);

};

#endif // VISUALIZER2D_H
