# vagrant-digitalocean-openresty
Vagrantをインターフェイスとし、OpenRestyの実行環境をDigitalOcean上に立ち上げます。

## 使い方
### 設定

`sync_folder` がrsyncによってインスタンス上の`/vagrant`へ転送されます。
また以下のファイルがプロビジョニング時に所定のフォルダに配置されます。

- `sync_folder/nginx.conf` -> `/home/vagrant/app/conf/nginx.conf`
  - 存在しない場合は `sync_folder/nginx.conf.example` がコピーされます
- `sync_folder/nginx.conf` -> `/home/vagrant/app/conf/nginx.conf`
  - 存在しない場合は `sync_folder/nginx.example` がコピーされます


プロビジョニングを実行する前に`.env`ファイルを作成する必要があります。
このファイルにはDigitalOceanに接続するための設定を記載してください。詳しくは [`.env.example`](/.env.example) を参照。

### プロビジョニング

```sh
# Vagrant ENV Plugin がインストールされていない場合
vagrant plugin install vagrant-env
# DigitalOcean Vagrant Provider がインストールされていない場合
vagrant plugin install vagrant-digitalocean

./init.sh
```

`/home/vagrant/app`が`-p`オプションに設定されnginxが起動します。

### 接続

``` sh
vagrant ssh openresty
```

