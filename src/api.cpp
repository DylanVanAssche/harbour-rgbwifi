#include "api.h"
#include "os.h"

/*!
    \qmltype API
    \inqmlmodule harbour.rgbwifi
    \brief Provides the interface with the hardware API

    The API accepts a QColor as input and sends it over HTTP to the ESP8266 module which controls the RGB ledstrip.
    The ESP8266 will reply with a HTTP 200 OK status code when succeeded.
*/
API::API()
{
    // Initiate a new QNetworkAccessManager
    QNAM = new QNetworkAccessManager(this);
    QNetworkConfigurationManager QNAM_config;
    QNAM->setConfiguration(QNAM_config.defaultConfiguration());

    // Connect QNetworkAccessManager signals
    connect(QNAM, SIGNAL(networkAccessibleChanged(QNetworkAccessManager::NetworkAccessibility)), this, SLOT(networkAccessible(QNetworkAccessManager::NetworkAccessibility)));
    connect(QNAM, SIGNAL(sslErrors(QNetworkReply*,QList<QSslError>)), this, SLOT(sslErrors(QNetworkReply*,QList<QSslError>)));
    connect(QNAM, SIGNAL(encrypted(QNetworkReply*)), this, SLOT(encrypted(QNetworkReply*)));
    connect(QNAM, SIGNAL(finished(QNetworkReply*)), this, SLOT(lightFinished(QNetworkReply*)));

    // Create User-Agent
    OS sfos;
    useragent = QString("%1/%2 (%3)").arg(sfos.appName(), sfos.appVersion(), sfos.release());
}

void API::setLight(QColor color, QString ipAddress) {

    // Set busy state
    m_busy = true;
    emit busyChanged();

    QString url = "http://%1/light?red=%2&green=%3&blue=%4&dimmer=%5";
    qInfo() << url.arg(ipAddress, QString::number(color.red()*4), QString::number(color.green()*4), QString::number(color.blue()*4), QString::number(color.alpha()*4));

    // Range 0 - 1023 while QT colors 0 - 255
    QNetworkRequest request(url.arg(ipAddress, QString::number(color.red()*4), QString::number(color.green()*4), QString::number(color.blue()*4), QString::number(qRound(color.alpha()/2.55))));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setHeader(QNetworkRequest::UserAgentHeader, useragent);
    QNAM->get(request);
}

void API::getLight(QString ipAddress) {

    // Set busy state
    m_busy = true;
    emit busyChanged();

    QString url = "http://%1/light";

    QNetworkRequest request(url.arg(ipAddress));
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setHeader(QNetworkRequest::UserAgentHeader, useragent);
    QNAM->get(request);
}

void API::lightFinished (QNetworkReply *reply)
{
    if(reply->error())
    {
        qCritical() << reply->errorString();
    }
    else
    {
        qDebug() << "Content-Header:" << reply->header(QNetworkRequest::ContentTypeHeader).toString();
        qDebug() << "Content-Length:" << reply->header(QNetworkRequest::ContentLengthHeader).toULongLong() << "bytes";
        qDebug() << "HTTP code:" << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
        qDebug() << "HTTP reason:" << reply->attribute(QNetworkRequest::HttpReasonPhraseAttribute).toString();

        // Get the data from the request
        QString replyData = (QString)reply->readAll();

        // Parse JSON response
        QJsonDocument jsonData = QJsonDocument::fromJson(replyData.toUtf8());
        QJsonObject jsonObject = jsonData.object();

        // Alert QML
        m_lightState = (jsonObject["red"].toInt() > 0) || (jsonObject["green"].toInt() > 0) || (jsonObject["blue"].toInt() > 0) || (jsonObject["dimmer"].toInt() > 0);
        m_lightValue = QColor(jsonObject["red"].toInt()/4, jsonObject["green"].toInt()/4, jsonObject["blue"].toInt()/4, qRound(jsonObject["dimmer"].toInt()*2.55));
        emit lightValueChanged();
        emit lightStateChanged();
    }

    reply->deleteLater();
    m_busy = false;
    emit busyChanged();
}

void API::sslErrors(QNetworkReply* reply, QList<QSslError> sslError) {
    qCritical() << "SSL error occured:" << reply->errorString() << sslError;
}

void API::encrypted(QNetworkReply*) {
    qDebug() << "Using HTTPS";
}

void API::networkAccessible(QNetworkAccessManager::NetworkAccessibility state) {
    QString networkStatus = "Network status: %1";
    qInfo() << networkStatus.arg(state);
}

QColor API::lightValue() {
    return m_lightValue;
}

bool API::lightState() {
    return m_lightState;
}

bool API::busy() {
    return m_busy;
}
