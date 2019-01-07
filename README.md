# Docker Services On Legacy

## Require

- Ubuntu 16.04
- git command
    ```shell
    sudo apt install -y git
    ```

## Install

- Install commands
    - docker
    - docker-compose
    - vim
    - unzip

```shell
git clone https://github.com/masamasa9841/DockerServicesOnLegacy.git 
cd DockerServicesOnLegacy
./install.sh
exit # For Reload
```

Server Login again

```shell
cd DockerServicesOnLegacy
```

## Usage

1. Create enviroment file
    - WordPress
        - wordpress/env/mysql.env
            ```text
            MYSQL_DATABASE=
            MYSQL_USER=
            MYSQL_PASSWORD=
            MYSQL_ROOT_PASSWORD=
            ```
        - wordpress/env/wordpress.env
            ```text
            VIRTUAL_HOST=
            VIRTUAL_PORT=8080
            LETSENCRYPT_HOST=
            LETSENCRYPT_EMAIL=
            WORDPRESS_DB_NAME=
            WORDPRESS_DB_USER=
            WORDPRESS_DB_PASSWORD=
            ```
    - Redmine
        - redmine/env/postgresslq.env
            ```text
            DB_USER=
            DB_PASS=
            DB_NAME=
            ```
        - redmine/env/redmine.env
            ```text
            VIRTUAL_HOST=
            LETSENCRYPT_HOST=
            LETSENCRYPT_EMAIL=

            TZ=Asia/Tokyo

            DB_ADAPTER=
            DB_HOST=
            DB_PORT=5432
            DB_USER=
            DB_PASS=
            DB_NAME=

            REDMINE_BACKUP_SCHEDULE=
            REDMINE_BACKUP_EXPIRY=
            REDMINE_BACKUP_TIME=
            ```
1. docker start
    ```shell
    docker-compose -f ./dockerApp/nginx-proxy/docker-compose.yml up -d
    docker-compose -f ./dockerApp/redmine/docker-compose.yml up -d
    docker-compose -f ./dockerApp/wordpress/docker-compose.yml up -d
    ```

## Volume

- wordpress
    ```text
    /srv/docker/wordpress
    ```
- Redmine
    ```text
    /srv/docker/redmine
    ```

### Update WordPress theme

```shell
mv -r {theme_folder} /srv/docker/wordpress/wp-content/themes/
```

Update Permission

```shell
sudo chown -R www-data /srv/docker/wordpress/wp-content/themes/
sudo chgrp -R www-data /srv/docker/wordPress/volumes/wp-content/themes/
```

### Restore Redmine

#### DB

```shell
docker stop redmine
docker cp {dumpfile} redmine-postgres:/
docker exec -it redmine-postgres bash
cd /
psql -U postgres -c "drop database redmine"
psql -U postgres -c "create database redmine"
psql -U redmine redmine < {dumpfile}
exit
docker start redmine
```

#### File

```shell
sudo mv {backup_file} /srv/docker/redmine/redmine/files/
cd /srv/docker/redmine/redmine/files
tar xvf {backup_file}
rm delete.me {backup_file}
```

### Basic Authentication

Basic Authentication command install

```shell
# Example
sudo apt-get install apache2-utils
htpasswd -c -b ./htpasswd unko morimori
```

### Referense

https://tech.quartetcom.co.jp/2017/04/11/multiple-ssl-apps-on-one-docker-host/

## LICENSE

This software is released under the MIT License, see [MIT LICENSE.](./LICENSE)
