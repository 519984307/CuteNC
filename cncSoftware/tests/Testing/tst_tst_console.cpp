#include <QtQuickTest>
#include <QQmlEngine>
#include <QQmlContext>

// add necessary includes here

class tst_console : public QObject
{
    Q_OBJECT

public:
    tst_console();
    ~tst_console();

private slots:
    void test_case1();

};

tst_console::tst_console()
{

}

tst_console::~tst_console()
{

}

void tst_console::test_case1()
{

}

QUICK_TEST_MAIN_WITH_SETUP("test_console")

#include "tst_tst_console.moc"
