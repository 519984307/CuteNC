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
        src/core/keymapper.cpp \
        src/gcode/line-numbers.cpp \
        src/gcode/textcharformat.cpp \
        src/main.cpp \
        src/global.cpp \
        src/core/fileparser.cpp \
        src/core/json.cpp \
        src/core/widgets.cpp \
        src/core/backend.cpp \
        src/gcode/syntaxhighlighter.cpp \
        src/websocket/websocket.cpp \
        src/console/console.cpp \
        src/serialport/serial.cpp

HEADERS += \
    src/core/keymapper.h \
    src/gcode/line-numbers.h \
    src/gcode/textcharformat.h \
    src/global.h \
    src/console/console.h \
    src/core/backend.h \
    src/core/fileparser.h \
    src/core/json.h \
    src/core/widgets.h \
    src/gcode/syntaxhighlighter.h \
    src/serialport/serial.h \
    src/websocket/websocket.h

RESOURCES += \
    qml.qrc

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
    .gitattributes \
    .qmake.stash \
    data/fontello/LICENSE.txt \
    data/fontello/README.txt \
    data/fontello/config.json \
    data/fontello/css/animation.css \
    data/fontello/css/fontello-codes.css \
    data/fontello/css/fontello-embedded.css \
    data/fontello/css/fontello-ie7-codes.css \
    data/fontello/css/fontello-ie7.css \
    data/fontello/css/fontello.css \
    data/fontello/demo.html \
    data/fontello/font/fontello.eot \
    data/fontello/font/fontello.svg \
    data/fontello/font/fontello.ttf \
    data/fontello/font/fontello.woff \
    data/fontello/font/fontello.woff2 \
    data/fonts/FontAwesomeRegular.otf \
    data/fonts/FontAwesomeSolid.otf \
    data/fonts/NotoSans.ttf \
    data/fonts/Roboto-Regular.ttf \
    data/fonts/RobotoMono.ttf \
    data/fonts/fontello.ttf \
    data/fonts/Consolas.ttf \
    data/images/githublogo/GitHub-Mark-120px-plus.png \
    data/images/githublogo/GitHub-Mark-32px.png \
    data/images/githublogo/GitHub-Mark-64px.png \
    data/images/githublogo/GitHub-Mark-Light-120px-plus.png \
    data/images/githublogo/GitHub-Mark-Light-32px.png \
    data/images/githublogo/GitHub-Mark-Light-64px.png \
    data/images/githublogo/GitHub_Logo.png \
    data/images/githublogo/GitHub_Logo_White.png \
    data/images/githublogo/githublogo.svg \
    data/images/githublogo/logo.png \
    data/images/logo/logo1.svg \
    data/images/logo/logo2.svg \
    data/images/logo/logo3.svg \
    data/images/logo/logo4.png \
    data/images/logo/logo4.svg \
    data/images/logo/logo5.svg \
    data/webconfig.ini \
    json/radioButtonSettings.json \
    qml/ConnectionWidget/ConnectButton.qml \
    qml/ConnectionWidget/ConnectionWidget.qml \
    qml/ConnectionWidget/SerialPortComboBox.qml \
    qml/EditorWidgetComponent.qml \
    qml/EditorWidgetEmpty.qml \
    qml/EditorWidgetTemplate.qml \
    qml/GCodeEditor/GcodeEditor.qml \
    qml/GCodeMacros/GCodeMacros.qml \
    qml/GCodeMacros/GCodeMacrosPopupWindow.qml \
    qml/GCodeViewer/GcodeViewer3D.qml \
    qml/GCodeViewer/GcodeViewerGrid.qml \
    qml/JogWidget/JogWidget.qml \
    qml/JogWidget/MoveXYZBtn.qml \
    qml/SerialConsoleWidget/SerialConsole.qml \
    qml/SerialConsoleWidget/SerialConsoleLine.qml \
    qml/TemplateWidget.qml \
    qml/TopMenu.qml \
    qml/buttons/ImageButton.qml \
    qml/buttons/ImageLabelButton.qml \
    qml/buttons/LeftMenuButton.qml \
    qml/buttons/TopBarButton.qml \
    qml/buttons/radio/MyRadioButton.qml \
    qml/buttons/radio/MyRadioGroup.qml \
    qml/components/CircularProgressBar.qml \
    qml/components/CustomButton.qml \
    qml/components/CustomTextField.qml \
    qml/components/CuteNCButton.qml \
    qml/components/CuteNCConsole.qml \
    qml/components/CuteNCDragDropBox.qml \
    qml/components/CuteNCGCodeTextEditor.qml \
    qml/components/CuteNCGrid.qml \
    qml/components/CuteNCNotification.qml \
    qml/components/CuteNCTextInput.qml \
    qml/editor.qml \
    qml/elements/DropBoxWithLabel.qml \
    qml/main.qml \
    qml/pages/about.qml \
    qml/pages/editor.qml \
    qml/pages/home.qml \
    qml/pages/settings.qml \
    qml/splashscreen.qml \
    qml/style.qml \
    qml/util.qml

include(include/QtWebApp/httpserver/httpserver.pri)


OTHER_FILES += data/webconfig.ini
