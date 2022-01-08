import QtQml 2.2
import QtQuick 2.0

Item {
    Loader {
          id: mainWindowLoader
          active: false
          source: "qrc:/qml/mainWindow.qml"
          asynchronous: true
          onLoaded: {
              splashScreenLoader.item.visible = false;
              splashScreenLoader.source = "";
          }
      }

      Loader {
          id: splashScreenLoader
          source: "qrc:/qml/splashscreen.qml"
          onLoaded: {
              backend.setup();
              mainWindowLoader.active = true;
          }
      }
}
