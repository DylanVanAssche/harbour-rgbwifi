# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-rgbwifi

CONFIG += sailfishapp

QT += network \
    gui \
    core

# Disable debug and warning messages while releasing for security reasons
CONFIG(release, debug|release):DEFINES += QT_NO_DEBUG_OUTPUT \
    QT_NO_WARNING_OUTPUT

SOURCES += src/harbour-rgbwifi.cpp \
    src/api.cpp \
    src/logger.cpp \
    src/os.cpp

DISTFILES += qml/harbour-rgbwifi.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-rgbwifi.changes.in \
    rpm/harbour-rgbwifi.changes.run.in \
    rpm/harbour-rgbwifi.spec \
    rpm/harbour-rgbwifi.yaml \
    translations/*.ts \
    harbour-rgbwifi.desktop \
    qml/pages/TextLabel.qml \
    qml/pages/SettingsPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/GlasButton.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-rgbwifi-de.ts

HEADERS += \
    src/api.h \
    src/logger.h \
    src/os.h
