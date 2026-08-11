#!/bin/bash
set -e # エラーが発生した時点でスクリプトを停止

DIR="$(pwd)"

# 必須パッケージの事前インストール
dnf install -y unzip fontconfig

# PostgreSQL14
cp $DIR/src/pgdg-redhat-repo-latest.noarch.rpm /usr/local/src/.
cd /usr/local/src
dnf install -y pgdg-redhat-repo-latest.noarch.rpm
dnf install -y postgresql14-server
/usr/pgsql-14/bin/postgresql-14-setup initdb
systemctl enable --now postgresql-14

sudo -u postgres psql -c "alter user postgres with password 'password'"

CONF_PATH="/var/lib/pgsql/14/data/postgresql.conf"
HBA_PATH="/var/lib/pgsql/14/data/pg_hba.conf"

cp -p "$CONF_PATH" "${CONF_PATH}.org"
sed -i -e "s/^#listen_addresses = 'localhost'/listen_addresses = '*'/g" "$CONF_PATH"
sed -i -e "s/^#port = 5432/port = 5432/g" "$CONF_PATH"
sed -i -e "s/^log_filename = 'postgresql-%a.log'/log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'/g" "$CONF_PATH"

cp -p "$HBA_PATH" "${HBA_PATH}.org"
sed -i -e "s/^host    all             all             127.0.0.1\/32            scram-sha-256/host    all             all             127.0.0.1\/32            password/g" "$HBA_PATH"

systemctl restart postgresql-14

# --データベース作成
sudo -u postgres psql < "$DIR/src/dump/CREATE_DATABASE.sql"
PGPASSWORD=VABucOeXYEeW psql -h 127.0.0.1 -U prjuser log_projects2 < "$DIR/src/dump/log_projects2.ddl"
PGPASSWORD=VABucOeXYEeW psql -h 127.0.0.1 -U prjuser log_projects2 < "$DIR/src/dump/log_projects2_master.dump"

# JDK17
cd /usr/local/src
wget https://download.oracle.com/java/17/archive/jdk-17.0.12_linux-x64_bin.tar.gz
cd /usr/local/
tar xvfz /usr/local/src/jdk-17.0.12_linux-x64_bin.tar.gz
ln -sfn jdk-17.0.12 java

# Tomcat9
cp "$DIR/src/apache-tomcat-9.0.120.tar.gz" /usr/local/src/
cd /usr/local
tar xvfz /usr/local/src/apache-tomcat-9.0.120.tar.gz
ln -sfn apache-tomcat-9.0.120 tomcat

useradd -M tomcat || true
chown -R tomcat:tomcat /usr/local/tomcat /usr/local/apache-tomcat-9.0.120

cp "$DIR/src/conf/tomcat.service" /etc/systemd/system/
chmod 644 /etc/systemd/system/tomcat.service
systemctl daemon-reload
systemctl enable --now tomcat

# 環境変数
if ! grep -q "JAVA_HOME=/usr/local/java" /etc/profile; then
  echo -e '\nexport PATH=${PATH}:/usr/local/java/bin' >> /etc/profile
  echo -e 'export JAVA_HOME=/usr/local/java' >> /etc/profile
  echo -e 'export CATALINA_HOME=/usr/local/tomcat' >> /etc/profile
fi

# Nginx
dnf -y install nginx
systemctl enable --now nginx
firewall-cmd --add-service=http --permanent
firewall-cmd --reload

# Tomcat連携
cp -p /etc/nginx/nginx.conf /etc/nginx/nginx.conf.org
cp "$DIR/src/conf/logprojects.conf" /etc/nginx/default.d/
systemctl restart nginx
setsebool -P httpd_can_network_connect 1

# 日本語フォントインストール
cp "$DIR/src/IPAfont00303.zip" /usr/local/src/
cd /usr/local/src
unzip -o IPAfont00303.zip
mv -f IPAfont00303 /usr/share/fonts/
fc-cache -fv

# LogProjects デプロイ
systemctl stop tomcat
rm -rf /usr/local/tomcat/work/Catalina/localhost/*
rm -rf /usr/local/tomcat/webapps/LogProjects2*
cp "$DIR/src/LogProjects2.war" /usr/local/tomcat/webapps/
chown tomcat:tomcat /usr/local/tomcat/webapps/LogProjects2.war
systemctl start tomcat

echo "--------------------------------------"
echo "LogProjects2 installation is complete."
echo "--------------------------------------"
