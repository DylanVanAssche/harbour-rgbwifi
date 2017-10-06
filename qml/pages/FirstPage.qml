/*
*   This file is part of RGBWiFi.
*
*   RGBWiFi is free software: you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation, either version 3 of the License, or
*   (at your option) any later version.
*
*   RGBWiFi is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with RGBWiFi.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import Harbour.RGBWiFi.API 1.0
import Harbour.RGBWiFi.SFOS 1.0

Page {
    id: page

    API {
        id: api
        Component.onCompleted: api.getLight(settings.ipAddress)
        onLightValueChanged: {
            red.value = lightValue.r
            green.value = lightValue.g
            blue.value = lightValue.b
            dimmer.value = lightValue.a
        }
    }

    SFOS {
        id: sfos
    }

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }

            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }
        contentHeight: column.height

        Column {
            id: column
            width: page.width

            PageHeader {
                title: sfos.appNamePretty

                BusyIndicator {
                    id: busy
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.horizontalPageMargin
                    anchors.verticalCenter: parent.verticalCenter
                    size: BusyIndicatorSize.Small
                    running: api.busy
                }
            }

            TextSwitch {
                id: toggle
                text: checked? qsTr("ON"): qsTr("OFF")
                description: qsTr("Switch the RGB ledstrip ON/OFF")
                enabled: !api.busy
                checked: dimmer.value > 0 && (red.value > 0 || green.value > 0 || blue.value > 0)
                onClicked: {
                    if(checked) {
                         api.setLight(settings.lastColor, settings.ipAddress)
                    }
                    else {
                        settings.lastColor = Qt.rgba(red.value, green.value, blue.value, dimmer.value)
                        api.setLight(Qt.black, settings.ipAddress)
                    }
                }
            }

            Slider {
                id: dimmer
                width: parent.width
                value: 0
                visible: toggle.checked
                enabled: !api.busy
                stepSize: 0.01
                valueText: (value * 100).toFixed(0)  + " %"
                label: qsTr("Dimmer")
                onReleased: api.setLight(Qt.rgba(red.value, green.value, blue.value, dimmer.value), settings.ipAddress)
            }

            Slider {
                id: red
                width: parent.width
                value: 0
                visible: toggle.checked
                enabled: !api.busy
                stepSize: 0.01
                valueText: (value*100).toFixed(0)  + " %"
                label: qsTr("Red")
                onReleased: api.setLight(Qt.rgba(red.value, green.value, blue.value, dimmer.value), settings.ipAddress)
            }

            Slider {
                id: green
                width: parent.width
                value: 0
                visible: toggle.checked
                enabled: !api.busy
                stepSize: 0.01
                valueText: (value*100).toFixed(0)  + " %"
                label: qsTr("Green")
                onReleased: api.setLight(Qt.rgba(red.value, green.value, blue.value, dimmer.value), settings.ipAddress)
            }

            Slider {
                id: blue
                width: parent.width
                value: 0
                visible: toggle.checked
                enabled: !api.busy
                stepSize: 0.01
                valueText: (value*100).toFixed(0)  + " %"
                label: qsTr("Blue")
                onReleased: api.setLight(Qt.rgba(red.value, green.value, blue.value, dimmer.value), settings.ipAddress)
            }

            Row {
                visible: toggle.checked
                width: parent.width
                height: width/4

                Rectangle {
                    color: "red"
                    width: parent.width/3
                    height: parent.height

                    MouseArea {
                        anchors.fill: parent
                        enabled: !api.busy
                        onClicked: api.setLight(Qt.rgba(1,0,0,1), settings.ipAddress)
                    }
                }

                Rectangle {
                    color: "green"
                    width: parent.width/3
                    height: parent.height

                    MouseArea {
                        anchors.fill: parent
                        enabled: !api.busy
                        onClicked: api.setLight(Qt.rgba(0,1,0,1), settings.ipAddress)
                    }
                }

                Rectangle {
                    color: "blue"
                    width: parent.width/3
                    height: parent.height

                    MouseArea {
                        anchors.fill: parent
                        enabled: !api.busy
                        onClicked: api.setLight(Qt.rgba(0,0,1,1), settings.ipAddress)
                    }
                }
            }

            Row {
                visible: toggle.checked
                width: parent.width
                height: width/4

                Rectangle {
                    color: "yellow"
                    width: parent.width/2
                    height: parent.height

                    MouseArea {
                        anchors.fill: parent
                        enabled: !api.busy
                        onClicked: api.setLight(Qt.rgba(1,1,0,1), settings.ipAddress)
                    }
                }

                Rectangle {
                    color: "white"
                    width: parent.width/2
                    height: parent.height

                    MouseArea {
                        anchors.fill: parent
                        enabled: !api.busy
                        onClicked: api.setLight(Qt.rgba(1,1,1,1), settings.ipAddress)
                    }
                }
            }
        }
    }
}
