dnf module disable nodejs -y
dnf module enable nodejs:18 -y

dnf install nodejs -y
useradd roboshop
npm install
cp cart.service /etc/systemd/system/cart.service
mkdir /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip

systemctl daemon-reload
systemctl enable cart
systemctl start cart
#comment
#pull comment#



