#ifndef API_H
#define API_H

#include <QtGlobal>
#include <QtCore/QObject>
#include <QtCore/QCoreApplication>
#include <QtCore/QFile>
#include <QtCore/QJsonDocument>
#include <QtCore/QJsonObject>
#include <QtCore/QTimer>
#include <QtCore/QUrl>
#include <QtCore/QUrlQuery>
#include <QtGui/QColor>
#include <QtNetwork/QNetworkAccessManager>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtNetwork/QNetworkConfigurationManager>

class API: public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool lightState READ lightState NOTIFY lightStateChanged)
    Q_PROPERTY(QColor lightValue READ lightValue NOTIFY lightValueChanged)
    Q_PROPERTY(bool busy READ busy NOTIFY busyChanged)

    public:
        explicit API();
        Q_INVOKABLE void setLight(QColor color, QString ipAddress);
        Q_INVOKABLE void getLight(QString ipAddress);
        QColor lightValue();
        bool lightState();
        bool busy();

    signals:
        void lightStateChanged();
        void lightValueChanged();
        void busyChanged();

    private slots:
        void lightFinished(QNetworkReply *reply);
        void sslErrors(QNetworkReply*,QList<QSslError>);
        void encrypted(QNetworkReply *reply);
        void networkAccessible(QNetworkAccessManager::NetworkAccessibility accessible);

    private:
        QNetworkAccessManager *QNAM;
        QString useragent;
        QTimer timer;
        QColor m_lightValue;
        bool m_lightState;
        bool m_busy;
};

#endif // API_H
