# LogFinder

Description : JSP based web application to format and parse structured logs for SDPON. It can also the sftp log fetch and do formatting.

1. Deploy the setup

# Install OpenJDK-8
# Install tomcat7
sudo apt-get update ; sudo apt-get install tomcat7

# Check the tomcat7 status
sudo service tomcat7 status

# Create the war file 'LogFinder.war' using eclipse aand copy to '/var/lib/tomcat7/webapps' directory

# Restart tomcat7
sudo service tomcat7 restart

# Access the url from browser (Mozilla)
Url: http://<ip-address>:8080/LogFinder/
