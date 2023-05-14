# Files Backup Before Apache TomCat Update
#Back up the following files:
#C:\Program Files\Apache Software Foundation\[ Tomcat folder ]\.keystore
#C:\Program Files\Apache Software Foundation\[ Tomcat folder ]\conf\server.xml
#C:\Program Files\Apache Software Foundation\[ Tomcat folder ]\webapps\era\WEB-INF\classes\sk\eset\era\g2webconsole\server\modules\config\EraWebServerConfig.properties
#If you are using a custom SSL certificate store in the Tomcat folder, also back up that certificate.




cd C:"\Program Files\Apache Software Foundation\"apache-tomcat-9.0.64\
cp .keystore C:\BACKUPs\ESET\ 

cd C:"\Program Files\Apache Software Foundation\"apache-tomcat-9.0.64\conf\
cp server.xml C:\BACKUPs\ESET\

cd C:"\Program Files\Apache Software Foundation\"apache-tomcat-9.0.64\webapps\era\WEB-INF\classes\sk\eset\era\g2webconsole\server\modules\config\
cp EraWebServerConfig.properties C:\BACKUPs\ESET\

dir C:\BACKUPs\ESET\