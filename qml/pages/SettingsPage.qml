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

Page {
    id: page

    Component.onDestruction: settings.ipAddress = ipAddress.text

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: settingsColumn.height

        Column {
            id: settingsColumn
            width: page.width
            spacing: Theme.paddingLarge

            PageHeader { title: qsTr("Settings") }

            TextField {
                id: ipAddress
                width: parent.width
                label: qsTr("IP address"); placeholderText: label
                text: settings.ipAddress
            }
        }
    }
}
