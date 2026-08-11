#!/bin/bash
set -e # エラー発生時に即時停止

DIR="$(pwd)"

# 必須パッケージの事前導入
apt update && apt install -y curl ca-certificates gnupg lsb-release unzip fontconfig

# PostgreSQL 14 (リポジトリ追加の現代的かつ安全な手法)
install -d /etc/apt/keyrings
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg
echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

apt update
apt install -y postgresql-14

sudo -u postgres psql -c "alter user postgres with password 'password'"

CONF_PATH="/etc/postgresql/14/main/postgresql.conf"
HBA_PATH="/etc/postgresql/14/main/pg_hba.conf"

cp -p "$CONF_PATH" "${CONF_PATH}.org"
sed -i -e "s/^#listen_addresses = 'localhost'/listen_addresses = '*'/g" "$CONF_PATH"

cp -p "$HBA_PATH" "${HBA_PATH}.org"
sed -i -e "s/^host    all             all             127.0.0.1\/32            scram-sha-256/host    all             all             127.0.0.1\/32            password/g" "$HBA_PATH"

systemctl restart postgresql

# -- データベース作成
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
apt install -y nginx

# Tomcat連携
cp -p /etc/nginx/nginx.conf /etc/nginx/nginx.conf.org
sed -i -e "s/include \/etc\/nginx\/sites-enabled\//# include \/etc\/nginx\/sites-enabled\//g" /etc/nginx/nginx.conf

cp -p /etc/nginx/sites-available/default /etc/nginx/conf.d/tomcat.conf
sed -i -e "s/\#		try_files \$uri \$uri\/ =404;/\#		try_files \$uri \$uri\/ =504;/g" /etc/nginx/conf.d/tomcat.conf
sed -i -e "s/root \/var\/www\/html/# root \/var\/www\/html/g" /etc/nginx/conf.d/tomcat.conf
sed -i -e "s/displaying a 404\./displaying a 404\.\n		root \/var\/www\/html;/g" /etc/nginx/conf.d/tomcat.conf
sed -i -e "s/try_files \$uri \$uri\/ =404;/try_files \$uri \$uri\/ =404;\n	}\n        location \/LogProjects2 {\n            access_log \/var\/log\/nginx\/tomcat_access.log;\n            error_log  \/var\/log\/nginx\/tomcat_error.log;\n            proxy_pass http:\/\/localhost:8080\/LogProjects2;/g" /etc/nginx/conf.d/tomcat.conf
sed -i -e "s/\#		try_files \$uri \$uri\/ =504;/\#		try_files \$uri \$uri\/ =404;/g" /etc/nginx/conf.d/tomcat.conf

systemctl restart nginx

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
