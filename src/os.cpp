#include "os.h"

/* Meta data about the OS
 * This meta data includes:
 *      - release name
 *      - version
 *      - device
 *      - network status (DBus)
 *      - notifications
 *      - XDG_CACHE_HOME
 *      - XDG_CONFIG_HOME
 *      - XDG_DATA_HOME
 */
OS::OS()
{
    QList<QPair<QString, QString> > dataList;
    QPair<QString, QString> pair;

    QStringList querrySFOSList;
    querrySFOSList << "VERSION_ID" << "PRETTY_NAME";
    dataList = extractFileData("/etc/os-release", querrySFOSList);

    for(int i=0; i<dataList.count(); i++) {
        if(dataList.at(i).first == "VERSION_ID") {
            m_version = dataList.at(i).second;
        }
        else if(dataList.at(i).first == "PRETTY_NAME") {
            m_release = dataList.at(i).second;
        }
    }

    QStringList querryHWList;
    querryHWList << "NAME";
    m_device = extractFileData("/etc/hw-release", querryHWList).at(0).second;
}

/* Reads a file and search for the querries in the querryList using recursion.
 * The Unicode type is automatically detected by QTextStream.
 * When found, the result is appended as a QPair to a QList.
 */
QList<QPair<QString, QString>> OS::extractFileData(QString location, QStringList querryList) {
    QFile file(location);
    QList<QPair<QString, QString>> dataList;
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream content(&file);
    content.setAutoDetectUnicode(true);

    while (true) {
        QString line = content.readLine();

        if(line.isNull()) {
            break;
        }
        else {
            foreach(QString querry, querryList) {
                if(line.indexOf(querry) >= 0) {
                    QString data = line.split('=', QString::SkipEmptyParts).at(1);
                    data.remove('"'); // Clean up
                    dataList.append(qMakePair(querry, data));
                    break;
                }
            }
        }
    }

    file.close();
    return dataList;
}

/* Return the current SFOS release */
QString OS::release() {
    return m_release;
}

/* Return the current SFOS version ID */
QString OS::version() {
    return m_version;
}

/* Return the current device name */
QString OS::device() {
    return m_device;
}

/* Return the application name */
QString OS::appName() {
    return qApp->applicationName();
}

/* Return the application name prettified */
QString OS::appNamePretty() {
    QString pretty = qApp->applicationName().remove("harbour-");
    pretty = pretty[0].toUpper() + pretty.right(pretty.length()-1);
    return pretty;
}

/* Return the application version */
QString OS::appVersion() {
    return qApp->applicationVersion();
}

/* Return the device pixel ratio */
qreal OS::devicepixelratio() {
    return qApp->devicePixelRatio();
}

/* Return the application cache location
 * In Sailfish OS this dir is returned as /home/nemo/.cache/<APPNAME>/<APPNAME>
 * This duplicate is removed using removeDuplicates() from the QStringList class.
 */
QString OS::cacheLocation() {
    QStringList cache;
    cache = QStandardPaths::standardLocations(QStandardPaths::CacheLocation).at(0).split("/");
    cache.removeDuplicates();
    return cache.join("/");
}

/* Return the application data location
 * In Sailfish OS this dir is returned as /home/nemo/.local/share/<APPNAME>/<APPNAME>
 * This duplicate is removed using removeDuplicates() from the QStringList class.
 */
QString OS::dataLocation() {
    QStringList data;
    data = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation).at(0).split("/");
    data.removeDuplicates();
    return data.join("/");
}

/* Return the application configuration location
 * In Sailfish OS this dir is returned as /home/nemo/.config/<APPNAME>/<APPNAME>
 * This duplicate is removed using removeDuplicates() from the QStringList class.
 */
QString OS::configLocation() {
    QStringList config;
    config = QStandardPaths::standardLocations(QStandardPaths::AppConfigLocation).at(0).split("/");
    config.removeDuplicates();
    return config.join("/");
}

QString OS::logLocation() {
    return cacheLocation() + "/logging";
}

QString OS::logFile() {
    return "log.txt";
}
