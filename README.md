# プロジェクト管理システム LogProjects インストール手順

プロジェクト管理システム **「LogProjects」** のインストール手順書です。  
Linux OS (AlmaLinux 10.2、Ubuntu 24.04) にて、自動インストールスクリプトを提供しています。
シェルスクリプトを実行することで、Linux環境上に必要なミドルウェアの構築からデータベース初期化、Webアプリケーションのデプロイまでを自動で行います。
他のOSについての手順は、自動インストールスクリプトの内容をご確認ください。
   > 💡 **注意**: ミドルウェアインストール時には、インターネットへ接続設定が必要です。

---

## 📋 必要なソフトウェア

LogProjects実行環境構築に必要なソフトウェアは以下の通りです。

| | コンポーネント | バージョン / 詳細 | 備考 |
| :---: | :--- | :--- | :--- |
| 💻 | **OS** | Java, Tomcatが実行可能なOS | AlmaLinux 10.2、Ubuntu 24.04 にて動作確認済み |
| ☕ | **JDK** | Java SE Development Kit 17.0.12 | Java実行環境 |
| 🐱 | **Application Server**| Apache Tomcat 9.0.120 | Javaサーブレットコンテナ |
| 🌐 | **Web Server** | Nginx | Javaサーブレットコンテナリバースプロキシ連携 |
| 🔤 | **フォント** | IPAフォント (IPAfont00303) | 画像の日本語表示用フォント |
| 🐘 | **Database** | PostgreSQL 14 | LogProjects用のDBMS |
| 📦 | **Application** | LogProjects2.war | LogProjectsアプリケーション |

---

## 🚀 インストール手順

LogProjects実行環境を構築する手順は以下の通りです。

### 1. Java (JDK) および Tomcat の準備
* **Java**: SE Development Kit 17 をインストールします。
* **Tomcat**: Apache Tomcat 9 をインストールします。

### 2. Nginx (Web Server) の設定 ※任意
* 80ポートでアクセス可能にする場合は、Nginxをインストールし、LogProjectsへのリバースプロキシ設定を行ってください。
* 8080ポートで直接実行する場合は、Nginxのインストールは不要です。

### 3. 日本語フォントの配置
* **Linux OS の場合**: 画像や帳票などの日本語表示用に IPAフォント（IPAfont00303）をインストールします。
* **Windows OS の場合**: インストール不要です。

### 4. PostgreSQL (データベース) の構築・初期化
1. **PostgreSQL 14** をインストールし、ネットワークからのアクセス権許可設定（`pg_hba.conf` や `listen_addresses`）を行ってください。
   > 💡 **補足**: DB接続設定用のユーザ情報は、`LogProjects2.war` 内の `web.xml` を参照してください。
2. インストール後、`dump` フォルダ内の以下のSQLを順に実行してデータベースを初期化します。
   - `CREATE_DATABASE.sql`
   - `logprojects2.ddl`
   - `logprojects2_master.dump`

### 5. アプリケーションのデプロイ
* `LogProjects2.war` を Tomcat インストールディレクトリ配下の `webapps` フォルダへ配置します。

### 6. サービスの起動とアクセス確認
1. 対象の各サービスを起動します。
   - **PostgreSQL**
   - **Tomcat**
   - **Nginx** (※80ポート利用時)
2. Webブラウザから以下のURLへアクセスし、ログイン画面等が表示されることを確認します。
   - **80ポート (Nginx使用)**: `http://<IPアドレス>/LogProject2/`
   - **8080ポート (Tomcat直結)**: `http://<IPアドレス>:8080/LogProject2/`

---

## 📁 シェルスクリプト実行用ディレクトリ構造

シェルスクリプトを実行する場合は、以下のファイル群が `src/` ディレクトリ内に配置されている必要があります。

```text
.
├── install_AlmaLinux10.sh                  # インストール実行スクリプト(AlmaLinux 10.2用)
├── install_Ubuntu24.sh                     # インストール実行スクリプト(Ubuntu 24.04用)
└── src/
    ├── pgdg-redhat-repo-latest.noarch.rpm  # PostgreSQLリポジトリRPM
    ├── apache-tomcat-9.0.120.tar.gz        # Tomcat 9 アーカイブ
    ├── IPAfont00303.zip                    # IPAフォントアーカイブ
    ├── LogProjects2.war                    # アプリケーションWARファイル
    ├── conf/
    │   ├── tomcat.service                  # Systemdサービス定義ファイル
    │   └── logprojects.conf                # Nginx用仮想ホスト/プロキシ設定
    └── dump/
        ├── CREATE_DATABASE.sql             # DB・ユーザ作成用SQL
        ├── logprojects2.ddl                # スキーマ定義SQL
        └── logprojects2_master.dump        # 初期マスターデータSQL