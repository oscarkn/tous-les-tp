**I. Setup DB**

1. Install MariaDB

Installer MariaDB sur la machine db.tp5.linux
```
[oscar@localhost .ssh]$ sudo dnf install mariadb-server
Complete!
```
Lancement du service MariaDB
```
[oscar@localhost .ssh]$ systemctl start mariadb
==== AUTHENTICATION COMPLETE ====
```
Le service MariaDB est bien actif
```
[oscar@localhost .ssh]$ systemctl status mariadb
● mariadb.service - MariaDB 10.3 database server
   Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)
   Active: active (running) since Thu 2021-11-25 17:31:08 CET; 48s ago
```
La base de données écoute derrière le port 3306. 
```
[oscar@localhost .ssh]$ sudo ss -ltnp
State     Recv-Q    Send-Q        Local Address:Port         Peer Address:Port    Process
LISTEN    0         80                        *:3306                    *:*        users:(("mysqld",pid=4759,fd=21))
```
Les processus liés au service MariaDB
```
[oscar@localhost .ssh]$ sudo ps -ef | grep mariadb
oscar       4877    1596  0 17:42 pts/0    00:00:00 grep --color=auto mariadb
```
Changements dans la conf du firewall pour autoriser les connexions qui viendront de la machine web.tp5.linux
```
[oscar@localhost .ssh]$ sudo firewall-cmd --add-port=3306/tcp --permanent
success
```
Configuration élémentaire de la base
```
[oscar@localhost .ssh]$ mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n] Y
```
On crée un mot de pass pour root pour des raisons de sécurité. Quelqu'un de mal intentionné ne pourra pas exécuter des commandes sous l'identité de root car il aura besoin du mot de passe.
```
New password:
Re-enter new password:
Password updated successfully!
Reloading privilege tables..
 ... Success!
```

```
By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] Y
```
On enleve les utilisateurs anonymes car bien qu'ils existent pour réaliser des tests, quelqu'un pourrait se connecter avec un de ces utilisateurs puis trouver des vulnérabilités et les exploiter.

Next thing I know, all my data has been encrypted and I need to sell one of my kidneys to get it back! 🙈
```
 ... Success!
```
```
Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] Y
```
On ne veut pas que quelqu'un puisse se connecter à distance puis faire n'importe quoi sous l'identité de root.
```
 ... Success!
```
```
By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] Y
```
Comme avec les utilisateurs anonymes, l'intérêt de cette base de données "test" pourrait être détourné, donc on n'en veut pas.
```
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!
```

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.
```
Reload privilege tables now? [Y/n] Y
```
Oui, nos changements doivent être respectés, sinon c'était tout pour rien et on est vraiment pas en sécurité.
```
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
```

3. Test

Installation sur la machine web.tp5.linux de la commande mysql

```
[oscar@web ~]$ dnf provides mysql
Last metadata expiration check: 0:03:54 ago on Fri 26 Nov 2021 03:08:27 PM CET.
mysql-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64 : MySQL client programs and shared libraries
Repo        : appstream
Matched from:
Provide    : mysql = 8.0.26-1.module+el8.4.0+652+6de068a7
```
```
[oscar@web ~]$ sudo dnf install mysql-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64
Installed:
  mariadb-connector-c-config-3.1.11-2.el8_3.noarch               mysql-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64
  mysql-common-8.0.26-1.module+el8.4.0+652+6de068a7.x86_64

Complete!
```
Connexion à la base qui tourne sur db.tp5.linux
```
[oscar@web ~]$ mysql --port=3306 --host=10.5.1.12 --user=nextcloud --password nextcloud
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 21
Server version: 5.5.5-10.3.28-MariaDB MariaDB Server

Copyright (c) 2000, 2021, Oracle and/or its affiliates.
```
On fait un SHOW TABLES; pour voir si on a les droits de lecture et on constate que la base est actuellement vide.
```
mysql> SHOW TABLES;
Empty set (0.01 sec)
```

**II. Setup Web**

1. Install Apache

A. Apache

Installation d'Apache sur la machine web.tp5.linux

```
[oscar@web ~]$ sudo dnf install httpd
Complete!
```

Analyse du service Apache

On lance le service httpd et on l'active au démarrage
```
[oscar@web ~]$ sudo systemctl start httpd
[oscar@web ~]$ sudo systemctl enable httpd
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
```
On isole les processus liés au service httpd
```
[oscar@web ~]$ sudo ps -ef | grep httpd
root        2445       1  0 15:57 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      2446    2445  0 15:57 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      2447    2445  0 15:57 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      2448    2445  0 15:57 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      2449    2445  0 15:57 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
oscar       2705    1477  0 16:09 pts/0    00:00:00 grep --color=auto httpd
```
Apache écoute derrière le port 80 par défaut
```
[oscar@web ~]$ sudo ss -ltnp
State           Recv-Q          Send-Q                   Local Address:Port                   Peer Address:Port         Process
LISTEN          0               128                                  *:80                                *:*             users:(("httpd",pid=2449,fd=4),("httpd",pid=2448,fd=4),("httpd",pid=2447,fd=4),("httpd",pid=2445,fd=4))
```
Les processus Apache sont lancés sous l'utilisateur root 
```
[oscar@web ~]$ ps -ef | grep httpd
root        2445       1  0 15:57 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
```
Un premier test

On ouvre le port d'Apache dans le firewall
```
[oscar@web ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
[sudo] password for oscar:
success
[oscar@web ~]$ sudo firewall-cmd --reload
success
```
Depuis le PC, ainsi que sur un navigateur Web, on peut accéder à la page d'accueil par défaut d'Apache

```
PS C:\Users\oscar> curl 10.5.1.11
curl : HTTP Server Test Page
This page is used to test the proper operation of an HTTP server after it has been installed on a Rocky Linux system.
If you can read this page, it means that the software it working correctly.
Just visiting?
This website you are visiting is either experiencing problems or could be going through maintenance.
If you would like the let the administrators of this website know that you've seen this page instead of the page
you've expected, you should send them an email. In general, mail sent to the name "webmaster" and directed to the
website's domain should reach the appropriate person.
The most common email address to send to is: "webmaster@example.com"
Note:
The Rocky Linux distribution is a stable and reproduceable platform based on the sources of Red Hat Enterprise Linux
(RHEL). With this in mind, please understand that:
Neither the Rocky Linux Project nor the Rocky Enterprise Software Foundation have anything to do with this website or
its content.
The Rocky Linux Project nor the RESF have "hacked" this webserver: This test page is included with the distribution.
For more information about Rocky Linux, please visit the Rocky Linux website.
I am the admin, what do I do?
You may now add content to the webroot directory for your software.
For systems using the Apache Webserver: You can add content to the directory /var/www/html/. Until you do so, people
visiting your website will see this page. If you would like this page to not be shown, follow the instructions in:
/etc/httpd/conf.d/welcome.conf.
For systems using Nginx: You can add your content in a location of your choice and edit the root configuration
directive in /etc/nginx/nginx.conf.

Apache™ is a registered trademark of the Apache Software Foundation in the United States and/or other countries.
NGINX™ is a registered trademark of F5 Networks, Inc..
At line:1 char:1
+ curl 10.5.1.11
+ ~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidOperation: (System.Net.HttpWebRequest:HttpWebRequest) [Invoke-WebRequest], WebExc
   eption
    + FullyQualifiedErrorId : WebCmdletWebResponseException,Microsoft.PowerShell.Commands.InvokeWebRequestCommand
```

B. PHP

Installer PHP

```
sudo dnf install epel-release
sudo dnf update
sudo dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo dnf module enable php:remi-7.4
sudo dnf install zip unzip libxml2 openssl php74-php php74-php-ctype php74-php-curl php74-php-gd php74-php-iconv php74-php-json php74-php-libxml php74-php-mbstring php74-php-openssl php74-php-posix php74-php-session php74-php-xml php74-php-zip php74-php-zlib php74-php-pdo php74-php-mysqlnd php74-php-intl php74-php-bcmath php74-php-gmp

Complete!
```
Analyser la conf Apache

La ligne qui inclut tout ce qu'il y a dans le dossier de drop-in

```
[oscar@web conf]$ cat httpd.conf
IncludeOptional conf.d/*.conf
```

Créer un VirtualHost qui accueillera NextCloud
```
[oscar@web conf]$ cd /etc/httpd/
[oscar@web httpd]$ ls
conf  conf.d  conf.modules.d  logs  modules  run  state
[oscar@web httpd]$ cd conf.d
[oscar@web conf.d]$ ls
autoindex.conf  php74-php.conf  README  userdir.conf  welcome.conf
[oscar@web conf.d]$ sudo touch virtualhost.conf
```
On insère le contenu donné
```
[oscar@web conf.d]$ sudo nano virtualhost.conf
```
Puis
```
[oscar@web conf.d]$ sudo systemctl restart httpd
```
Configurer la racine web

On crée le dossier /var/www/nextcloud/html/
```
[oscar@web conf.d]$ cd /var/www
[oscar@web www]$ pwd
/var/www
[oscar@web www]$ sudo mkdir nextcloud
[oscar@web www]$ ls
cgi-bin  html  nextcloud
[oscar@web www]$ cd nextcloud/
[oscar@web nextcloud]$ sudo mkdir html
```
On fait appartenir le dossier et son contenu à l'utilisateur qui lance Apache
```
[oscar@web html]$ sudo chown apache /var/www/nextcloud/html/
```
Configurer PHP
```
[oscar@web html]$ sudo vi /etc/opt/remi/php74/php.ini
```
On a bien changé la timezone actuelle de la machine:
```
[oscar@web html]$ cat /etc/opt/remi/php74/php.ini | grep -n timezon
923:date.timezone = "Europe/Paris"
```

3. Install NextCloud

Récupérer Nextcloud

Extraire le contenu de NextCloud et déplacer tout le contenu dans la racine Web

```
[oscar@web ~]$ sudo unzip nextcloud-21.0.1.zip -d /var/www/nextcloud/html
```
On change les permissions des fichiers déplacés. 

"-R" pour que, récursivement, apache devienne vraiment le propriétaire de tous ces fichiers.
```
[oscar@web nextcloud]$ sudo chown apache:apache -R  /var/www/nextcloud/html/nextcloud/
```
Supprimer l'archive
```
[oscar@web ~]$ rm -rf nextcloud-21.0.1.zip
```

4. Test

On modifie le fichier hosts sur notre PC (Windows)

```
# Copyright (c) 1993-2009 Microsoft Corp.
#
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows.

...

# localhost name resolution is handled within DNS itself.
127.0.0.1       localhost
::1             localhost
192.168.56.101  oscar.test
10.5.1.11 web.tp5.linux
```

On teste l'accès à NextCloud et on finalise son installation

```
C:\Users\oscar> curl http://web.tp5.linux


StatusCode        : 200
StatusDescription : OK
Content           : <!DOCTYPE html>
                    <html class="ng-csp" data-placeholder-focus="false" lang="en" data-locale="en" >
                        <head
                     data-requesttoken="CO3MI7D2ihL/j7DPX6Zb78DFQAJuUpeujfed7sXxFRk=:QdWieuKi43jPzMS8N5U5t/CRCkRXZfr...
RawContent        : HTTP/1.1 200 OK
                    Pragma: no-cache
                    Content-Security-Policy: default-src 'none';base-uri 'none';manifest-src 'self';script-src
                    'self';style-src 'self' 'unsafe-inline';img-src 'self' data: blob:;font-sr...
Forms             : {}
Headers           : {[Pragma, no-cache], [Content-Security-Policy, default-src 'none';base-uri 'none';manifest-src
                    'self';script-src 'self';style-src 'self' 'unsafe-inline';img-src 'self' data: blob:;font-src
                    'self' data:;connect-src 'self';media-src 'self';frame-src 'self';frame-ancestors
                    'self';worker-src 'self' blob:;form-action 'self'], [Feature-Policy, autoplay 'self';camera
                    'none';fullscreen 'self';geolocation 'none';microphone 'none';payment 'none'], [X-Robots-Tag,
                    none]...}
Images            : {}
InputFields       : {@{innerHTML=; innerText=; outerHTML=<input id="initial-state-core-loginUsername" type="hidden"
                    value="IiI=">; outerText=; tagName=INPUT; id=initial-state-core-loginUsername; type=hidden;
                    value=IiI=}, @{innerHTML=; innerText=; outerHTML=<input id="initial-state-core-loginAutocomplete"
                    type="hidden" value="dHJ1ZQ==">; outerText=; tagName=INPUT;
                    id=initial-state-core-loginAutocomplete; type=hidden; value=dHJ1ZQ==}, @{innerHTML=; innerText=;
                    outerHTML=<input id="initial-state-core-loginThrottleDelay" type="hidden" value="MA==">;
                    outerText=; tagName=INPUT; id=initial-state-core-loginThrottleDelay; type=hidden; value=MA==},
                    @{innerHTML=; innerText=; outerHTML=<input id="initial-state-core-loginResetPasswordLink"
                    type="hidden" value="IiI=">; outerText=; tagName=INPUT;
                    id=initial-state-core-loginResetPasswordLink; type=hidden; value=IiI=}...}
Links             : {@{innerHTML=Nextcloud; innerText=Nextcloud; outerHTML=<a class="entity-name"
                    href="https://nextcloud.com" target="_blank" rel="noreferrer noopener">Nextcloud</a>;
                    outerText=Nextcloud; tagName=A; class=entity-name; href=https://nextcloud.com; target=_blank;
                    rel=noreferrer noopener}}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 9973
```





