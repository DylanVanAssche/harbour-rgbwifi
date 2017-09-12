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
import Harbour.RGBWiFi.SFOS 1.0

Page {
    id: page

    SFOS {
        id: sfos
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            width: page.width
            spacing: Theme.paddingLarge

            PageHeader { title: qsTr("%1 V%2").arg(sfos.appNamePretty).arg(sfos.appVersion)}

            SectionHeader { text: qsTr("What's %1?").arg(sfos.appNamePretty) }
            TextLabel { labelText: qsTr("Control your RGB ledstrip over WiFi with an ESP8266 WiFi module.") }

            SectionHeader { text: qsTr("Licensing") }
            TextLabel { labelText: qsTr("This application is released under GPLv3. The source code and the license is available in the Github repo of %1.").arg(app.name) }

            SectionHeader { text: qsTr("Developer & source code") }
            GlasButton { link: "https://github.com/modulebaan"; iconSource: "../resources/images/icon-github.png"; iconText: "Dylan Van Assche" }
            GlasButton { link: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=XTDV5P8JQTHT4"; iconSource: "../resources/images/icon-paypal.png"; iconText: qsTr("Donate with %1").arg("PayPal") }
            GlasButton { link: "https://github.com/modulebaan/harbour-rgbwifi"; iconSource: "../resources/images/icon-code.png"; iconText: "source code" }

            SectionHeader { text: qsTr("Powered by") }
            GlasButton { link: "http://fontawesome.io/"; iconSource: "../resources/images/icon-fontawesome.png"; iconText: "FontAwesome icons" }
        }
    }
}
