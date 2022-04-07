#include <QtTest>
#include <QDebug>
//#include <QCoreApplication>

// add necessary includes here
#include "backend.h"

class UnitTest : public QObject
{
    Q_OBJECT

public:
    UnitTest();
    ~UnitTest();

private slots:
    void test_backend_gcodeFile();
    void test_backend_fontColor();
    void test_backend_theme();
};


UnitTest::UnitTest()
{

}

UnitTest::~UnitTest()
{

}
void UnitTest::test_backend_gcodeFile()
{
    Backend backend;
    QString fileContents = "test file contents\nline1";
    backend.setupFile(fileContents);
    QCOMPARE(backend.getGcodeFile(),fileContents);
}
void UnitTest::test_backend_fontColor()
{
    Backend backend;
    QCOMPARE(backend.determineFontColor("#000000"),true);
    QCOMPARE(backend.determineFontColor("#ffffff"),false);
}

void UnitTest::test_backend_theme()
{
    Backend backend;

    backend.setTheme("lightTheme");
    QCOMPARE(backend.selectedThemeName, "lightTheme.json");
}


QTEST_MAIN(UnitTest)

#include "tst_unittest.moc"
