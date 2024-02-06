echo -e "************\e[36m Set correct Nodejs version **********\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo -e "************\e[36m Install Nodejs **********\e[0m"
dnf install nodejs -y

echo -e "************\e[36m Add functional user ********\e[0m"
useradd roboshop

echo -e "************\e[36m Create app directory ********\e[0m"
mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "************\e[36m Unzip the code ********\e[0m"
cd /app
unzip /tmp/catalogue.zip
echo -e "************\e[36m Install dependencies ********\e[0m"
npm install

echo -e "************\e[36m Copy Catalogue service ********\e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

echo -e "************\e[36m Start Catalogue service ********\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

echo -e "************\e[36m Copy mongodb repo ********\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "************\e[36m Install mongodb ********\e[0m"
dnf install mongodb-org-shell -y

echo -e "************\e[36m Load Mongo Schema ********\e[0m"
mongo --host mongodb-dev.skdevops.online </app/schema/catalogue.js

echo -e "************\e[36m Restart the catalogue service ********\e[0m"
systemctl restart catalogue
