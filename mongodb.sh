cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y

systemctl enable mongod
systemctl start mongod

#modify local host from 127.0.0.1 to 0.0.0.0 using shell
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

systemctl restart mongod