#ifndef FILEPARSER_H
#define FILEPARSER_H

#include <QObject>

class Fileparser : public QObject
{
    Q_OBJECT
public:
    explicit Fileparser(QObject *parent = nullptr);
    void loadWidgets();
    QString getFileRawContent(QString path, QString filename);

    void createNecessaryFiles();
signals:
    void refresh();
};


#endif // FILEPARSER_H
