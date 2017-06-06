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

import QtQuick 2.2
import Sailfish.Silica 1.0

BackgroundItem {
    property string link
    property string iconSource
    property string iconText
    property real itemScale: 1.0
    
    width: parent.width
    height: Theme.itemSizeLarge*1.2*itemScale
    anchors { left: parent.left; right: parent.right }
    onClicked: Qt.openUrlExternally(link);
    enabled: link.length

    Row {
        anchors { left: parent.left; leftMargin: Theme.paddingLarge*itemScale; right: parent.right; rightMargin: Theme.paddingLarge*itemScale; verticalCenter: parent.verticalCenter }
        spacing: Theme.paddingMedium

        Image {
            width: Theme.iconSizeLarge
            height: width
            source: iconSource
            scale: itemScale
        }

        Label {
            anchors { verticalCenter: parent.verticalCenter }
            font.pixelSize: Theme.fontSizeLarge
            text: iconText
        }
    }
}
