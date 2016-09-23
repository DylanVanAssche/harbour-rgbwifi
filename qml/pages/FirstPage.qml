import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))
            }
        }
        contentHeight: column.height

        Column {
            id: column
            width: page.width

            PageHeader {
                title: app.name

                BusyIndicator {
                    id: busy
                    anchors.left: parent.left
                    anchors.leftMargin: Theme.horizontalPageMargin
                    anchors.verticalCenter: parent.verticalCenter
                    size: BusyIndicatorSize.Small
                    running: false
                }
            }

            TextSwitch {
                id: toggle
                text: qsTr("ON")
                checked: app.ledstrip_state
                description: qsTr("Switch the RGB ledstrip ON/OFF")
                onCheckedChanged: {
                    if(checked)
                    {
                        update.restart()
                        text = qsTr("ON")
                        busy.running = true
                    }
                    else
                    {
                        python.call('ledstrip.rgb',[0,0,0], function(red, green, blue) {});
                        text = qsTr("OFF")
                        busy.running = true
                    }
                }
            }

            Slider {
                id: red
                width: parent.width
                value: 1023
                visible: toggle.checked
                minimumValue: 0
                maximumValue: 1023
                stepSize: 1
                valueText: ((value/1023)*100).toFixed(0)  + " %"
                label: qsTr("Red")
                onValueChanged:
                {
                    update.restart();
                    busy.running = true
                }
            }

            Slider {
                id: green
                width: parent.width
                value: 1023
                visible: toggle.checked
                minimumValue: 0
                maximumValue: 1023
                stepSize: 1
                valueText: ((value/1023)*100).toFixed(0)  + " %"
                label: qsTr("Green")
                onValueChanged:
                {
                    update.restart();
                    busy.running = true
                }
            }

            Slider {
                id: blue
                width: parent.width
                value: 1023
                visible: toggle.checked
                minimumValue: 0
                maximumValue: 1023
                stepSize: 1
                valueText: ((value/1023)*100).toFixed(0)  + " %"
                label: qsTr("Blue")
                onValueChanged:
                {
                    update.restart();
                    busy.running = true
                }
            }

            Rectangle {
                width: parent.width
                height: Theme.paddingLarge
                color: "transparent"
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
                        onClicked:
                        {
                            update.stop()
                            python.call('ledstrip.rgb',[1023,0,0], function(red, green, blue) {});
                            busy.running = true
                        }
                    }
                }

                Rectangle {
                    color: "green"
                    width: parent.width/3
                    height: parent.height

                    MouseArea {
                        anchors.fill: parent
                        onClicked:
                        {
                            update.stop()
                            python.call('ledstrip.rgb',[0,1023,0], function(red, green, blue) {});
                            busy.running = true
                        }
                    }
                }

                Rectangle {
                    color: "blue"
                    width: parent.width/3
                    height: parent.height

                    MouseArea {
                        anchors.fill: parent
                        onClicked:
                        {
                            update.stop()
                            python.call('ledstrip.rgb',[0,0,1023], function(red, green, blue) {});
                            busy.running = true
                        }
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
                        onClicked:
                        {
                            update.stop()
                            python.call('ledstrip.rgb',[1023,816,0], function(red, green, blue) {});
                            busy.running = true
                        }
                    }
                }

                Rectangle {
                    color: "white"
                    width: parent.width/2
                    height: parent.height

                    MouseArea {
                        anchors.fill: parent
                        onClicked:
                        {
                            update.stop()
                            python.call('ledstrip.rgb',[1023,1023,1023], function(red, green, blue) {});
                            busy.running = true
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: update
        running: toggle.checked
        repeat: false
        interval: 500
        onTriggered:
        {
            python.call('ledstrip.rgb',[red.value,green.value,blue.value], function(red, green, blue) {});
        }
    }

    Python {
        id: python

        Component.onCompleted:
        {
            addImportPath(Qt.resolvedUrl('.'));
            importModule('ledstrip', function() {});

            setHandler('result', function(result)
            {
                console.log(result)
                busy.running = false;
            });
        }

        onError:
        {
            console.log('Python ERROR: ' + traceback);
            Clipboard.text = traceback
        }
    }
}


