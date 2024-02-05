echo -e "************\e[36m Copy mongo repo **********\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
echo -e "************\e[36m Install mongodb **********\e[0m"
dnf install mongodb-org -y

echo -e "************\e[36m enable and start mongodb **********\e[0m"
systemctl enable mongod
systemctl start mongod

echo -e "************\e[36m enable ip to listen from all hosts **********\e[0m"
#modify local host from 127.0.0.1 to 0.0.0.0 using shell
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf
echo -e "************\e[36m Restart mongodb **********\e[0m"
systemctl restart mongod