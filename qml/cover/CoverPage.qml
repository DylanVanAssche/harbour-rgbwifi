import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    CoverPlaceholder {
        id: label
        anchors.centerIn: parent
        text: app.name
    }

    CoverActionList {
        id: actions

        CoverAction {
            iconSource: "image://theme/icon-cover-location"
            onTriggered:
            {
                app.ledstrip_state = !app.ledstrip_state;
            }
        }
    }
}


