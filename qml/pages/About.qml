import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: columnPage.height

        Column {
            id: columnPage
            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: app.name + ' ' + app.version
            }

            SectionHeader { text: qsTr("What's RGB WiFi?") }

            Label {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Theme.horizontalPageMargin
                    rightMargin: Theme.horizontalPageMargin
                }
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WordWrap
                text: qsTr("Control your RGB ledstrip over WiFi with an ESP8266 WiFi module. The application is opensource GPLv3 software and based on PyOtherSide.")
            }

            SectionHeader { text: qsTr("Source code") }

            Label {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Theme.horizontalPageMargin
                    rightMargin: Theme.horizontalPageMargin
                }
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WordWrap
                text: qsTr("You can find the source code of this app and the Arduino code for the ESP8266 on Github.")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Source code")
                onClicked:
                {
                    Qt.openUrlExternally("https://github.com/modulebaan/harbour-rgbwifi")
                }
            }

            SectionHeader { text: qsTr("Developed by") }

            Label {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Theme.horizontalPageMargin
                }
                font.pixelSize: Theme.fontSizeMedium
                wrapMode: Text.WordWrap
                text: qsTr("Dylan Van Assche (modulebaan)")
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Modulebaan.tk")
                onClicked:
                {
                    Qt.openUrlExternally("http://modulebaan.tk/sailfish-os/my-apps/")
                }
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Donate with Paypal")
                onClicked: {
                    Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=XTDV5P8JQTHT4")
                }
            }

            // Spacer
            Item {
                height: 20
                width: parent.width
            }
        }
    }
}
