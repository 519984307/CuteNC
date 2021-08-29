QT += quick
QT += core
QT += quickcontrols2
QT += serialport
QT += concurrent
QT += network
CONFIG += c++11
CONFIG += static
QT += gui #openGL
QT += widgets #filedialog

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/core/json.cpp \
        src/core/widgets.cpp \
        src/websocket/websocket.cpp \
        main.cpp \
        src/console/console.cpp \
        src/core/backend.cpp \
        src/serialport/serial.cpp

HEADERS += \
    global.h \
    src/console/console.h \
    src/core/backend.h \
    src/core/json.h \
    src/core/widgets.h \
    src/serialport/serial.h \
    src/websocket/websocket.h

RESOURCES += \
    qml.qrc
    debug/qmake_qmake_qm_files.qrc \

TRANSLATIONS += \
    cncSoftware_en_001.ts
CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =
QT_QUICK_CONTROLS_CONF: "qtquickcontrols2.conf"
# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    json/radioButtonSettings.json \
    qml/ConnectionWidget/ConnectButton.qml \
    qml/ConnectionWidget/ConnectionWidget.qml \
    qml/ConnectionWidget/SerialPortComboBox.qml \
    qml/EditorWidgetTemplate.qml \
    qml/GCodeEditor/GcodeEditor.qml \
    qml/GCodeViewer/GcodeViewer3D.qml \
    qml/GCodeViewer/GcodeViewerGrid.qml \
    qml/JogWidget/JogWidget.qml \
    qml/JogWidget/MoveXYZBtn.qml \
    qml/SerialConsoleWidget/SerialConsole.qml \
    qml/SerialConsoleWidget/SerialConsoleLine.qml \
    qml/SerialConsoleWidget/console.qml \
    qml/SerialConsoleWidget/consoleLog.qml \
    qml/TemplateWidget.qml \
    qml/buttons/ImageButton.qml \
    qml/buttons/ImageLabelButton.qml \
    qml/buttons/LeftMenuButton.qml \
    qml/buttons/TopBarButton.qml \
    qml/buttons/radio/MyRadioButton.qml \
    qml/buttons/radio/MyRadioGroup.qml \
    qml/components/CircularProgressBar.qml \
    qml/components/CustomButton.qml \
    qml/components/CustomTextField.qml \
    qml/elements/DropBoxWithLabel.qml \
    qml/pages/editor.qml \
    qml/pages/home.qml \
    qml/pages/settings.qml

