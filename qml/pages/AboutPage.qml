import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: app.name + ' ' + app.version
            }

            SectionHeader { text: qsTr("What's RGB WiFi?") }
            TextLabel { labelText: qsTr("Control your RGB ledstrip over WiFi with an ESP8266 WiFi module.") }

            SectionHeader { text: qsTr("Licensing") }
            TextLabel { labelText: qsTr("This application is released under GPLv3. The source code and the license is available in the Github repo of RGBWiFi.") }

            SectionHeader { text: qsTr("Developer & source code") }
            GlasButton { link: "https://github.com/modulebaan"; iconSource: "../resources/images/icon-github.png"; iconText: "Dylan Van Assche" }
            GlasButton { link: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=XTDV5P8JQTHT4"; iconSource: "../resources/images/icon-paypal.png"; iconText: "Donate with Paypal" }
            GlasButton { link: "https://github.com/modulebaan/harbour-rgbwifi"; iconSource: "../resources/images/icon-code.png"; iconText: "source code" }

            SectionHeader { text: qsTr("Powered by") }
            GlasButton { link: "http://fontawesome.io/"; iconSource: "../resources/images/icon-fontawesome.png"; iconText: "FontAwesome icons" }
        }
    }
}
