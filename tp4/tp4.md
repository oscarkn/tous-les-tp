Contenu fichier de conf

```
TYPE=Ethernet
BOOTPROTO=static
NAME=enp0s8
DEVICE=enp0s8
ONBOOT=yes
IPADDR=10.250.1.56
NETMASK=255.255.255.0
```

Résultat d'un ip a:

```
[oscar@localhost ~]$ ip a
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:ea:76:76 brd ff:ff:ff:ff:ff:ff
    inet 10.250.1.56/24 brd 10.250.1.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:feea:7676/64 scope link
       valid_lft forever preferred_lft forever
```
Le service ssh est actif sur la VM

```
[oscar@localhost ~]$ systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2021-11-23 16:38:27 CET; 22min ago[oscar@localhost ~]$ systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2021-11-23 16:38:27 CET; 22min ago
```
La clé publique (le cadenas) sur votre PC (un cat du fichier)

```
PS C:\Users\oscar\.ssh> cat .\id_rsa
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
```
un cat du fichier authorized_keys concerné sur la VM
```

[oscar@localhost .ssh]$ cat authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5ymcp0cCwTdeb+tZl+Os70QbVfdgi88UcfEkl+n91s3G4T2QlP2KmOpBjr98/Q0RfZqwMCUZFY8yZDO2gGcq5oAp1vEi/0zmV/Abpb9xcnLDZrasnWHHtcoRwjoj/59HZhLjTbgrbimVJiFNmYldQrOe9PxcyGsdWxLapWLdL69bJo+v7j41fm8FvGY/ay0NvlultguC2RC4CRIAhPfxwitIk2pkMBpEr83UrwY4hgsgF23qVuwcfydEkotDb4OJyc6p/N0DkrLbKdYH1GoxTx3k+7vfICOr1V0PBGr1LvmzKq1eNjhapGIUsA1havzwk8s1QnspLPfVsJsMd8uIOp6X4TkJaO7BXopomxLezPx8myXR5N/vtFEJETq8yaGXmVg/UuhKBsDa9puwqvt7aawxImgfqkKU2TL2EW4jp3enBM8BehQhLatAlXTk7+9vorAH2Y1WQQ6Q57tMG7NDL15ts2fHTOvbgz2kR6M6glg1gtXw7oA2Q3ZUGivCZxI3foiORraHvSfgJpwTbjtxinoswyTh9jWmcoDrZhp2X1xNP4bCqknT+Dfp/XR8oDSGaY7surIwqpm9d2DL6JgNBYp1Ku4bImBr0rBPnkkBJBmIvSntlQsZFxOreh/1J+dD/FhmOxXliO7nxjwN5IKzHJvSlXiQ/Q1axTtvlCymxfQ== oscar@DESKTOP-VK3DE57
```

une connexion sans aucun mot de passe demandé

```
PS C:\Users\oscar> ssh oscar@10.250.1.56
Activate the web console with: systemctl enable --now cockpit.socket

Last login: Tue Nov 23 16:43:03 2021 from 10.250.1.1
```
Preuve accès Internet avec une commande ping

```
[oscar@localhost .ssh]$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=113 time=28.9 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=113 time=29.1 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=113 time=27.3 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=113 time=27.5 ms
64 bytes from 8.8.8.8: icmp_seq=5 ttl=113 time=27.6 ms
64 bytes from 8.8.8.8: icmp_seq=6 ttl=113 time=28.5 ms
64 bytes from 8.8.8.8: icmp_seq=7 ttl=113 time=31.3 ms
^C
--- 8.8.8.8 ping statistics ---
7 packets transmitted, 7 received, 0% packet loss, time 6016ms
rtt min/avg/max/mdev = 27.340/28.596/31.301/1.288 ms
```

Preuve résolution de nom avec un ping vers un nom de domaine

```
[oscar@localhost .ssh]$ ping ynov.com
PING ynov.com (92.243.16.143) 56(84) bytes of data.
64 bytes from xvm-16-143.dc0.ghst.net (92.243.16.143): icmp_seq=1 ttl=51 time=23.5 ms
64 bytes from xvm-16-143.dc0.ghst.net (92.243.16.143): icmp_seq=2 ttl=51 time=26.3 ms
64 bytes from xvm-16-143.dc0.ghst.net (92.243.16.143): icmp_seq=3 ttl=51 time=36.7 ms
64 bytes from xvm-16-143.dc0.ghst.net (92.243.16.143): icmp_seq=4 ttl=51 time=25.0 ms
64 bytes from xvm-16-143.dc0.ghst.net (92.243.16.143): icmp_seq=5 ttl=51 time=25.7 ms
^C
--- ynov.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4006ms
rtt min/avg/max/mdev = 23.543/27.454/36.675/4.706 ms
```
Nommage de la machine
```
[oscar@localhost ~]$ [oscar@localhost ~]$ cat /etc/hostname
node1.tp4.linux
```
```
[oscar@node1 ~]$ hostname
node1.tp4.linux
```

**III. Mettre en place un service**

2. Install

```
[oscar@node1 ~]$ sudo dnf install nginx

Complete!
```
Status de nginx:
```
[oscar@node1 ~]$ sudo systemctl status nginx
 Active: active (running) since Tue 2021-11-23 17:59:40 CET; 11min ago
 ```
3. Analyse

Le processus du service NGINX tourne sous l'utilisateur root.
```
[oscar@node1 ~]$ ps -ef | grep nginx
root        4044       1  0 17:59 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx       4045    4044  0 17:59 ?        00:00:00 nginx: worker process
oscar       4117    1446  0 18:12 pts/0    00:00:00 grep --color=auto nginx
```
nginx écoute derrière le port 80
```
[oscar@node1 ~]$ sudo ss -ltnp
State       Recv-Q      Send-Q            Local Address:Port             Peer Address:Port      Process
LISTEN      0           128                     0.0.0.0:80                    0.0.0.0:*          users:(("nginx",pid=4045,fd=8),("nginx",pid=4044,fd=8))
```
On trouve dans quel dossier se trouve la racine web
```
[oscar@node1 ~]$ cd /etc/nginx/
[oscar@node1 nginx]$ ls
conf.d        fastcgi.conf.default    koi-utf     mime.types.default  scgi_params          uwsgi_params.default
default.d     fastcgi_params          koi-win     nginx.conf          scgi_params.default  win-utf
fastcgi.conf  fastcgi_params.default  mime.types  nginx.conf.default  uwsgi_params
```
On cherche le "root document" donc on utilise la commande grep pour chercher le mot "root".
```
[oscar@node1 nginx]$ grep "root" -R /etc/nginx/nginx.conf
        root         /usr/share/nginx/html;
```
Inspection des fichiers de la racine web. On voit qu'ils sont bien accessibles en lecture par l'utilisateur qui lance le processus.
```
[oscar@node1 nginx]$ cd /usr/share/nginx/html
[oscar@node1 html]$ ls -al
total 20
drwxr-xr-x. 2 root root   99 Nov 23 17:58 .
drwxr-xr-x. 4 root root   33 Nov 23 17:58 ..
-rw-r--r--. 1 root root 3332 Jun 10 11:09 404.html
-rw-r--r--. 1 root root 3404 Jun 10 11:09 50x.html
-rw-r--r--. 1 root root 3429 Jun 10 11:09 index.html
-rw-r--r--. 1 root root  368 Jun 10 11:09 nginx-logo.png
-rw-r--r--. 1 root root 1800 Jun 10 11:09 poweredby.png
```
4. Visite du service web

Configuration du firewall pour autoriser le trafic vers le service NGINX.
```
[oscar@node1 html]$ sudo firewall-cmd --add-port=80/tcp --permanent
[sudo] password for oscar:
success
[oscar@node1 html]$ sudo firewall-cmd --reload
success
```
Le service fonctionne bien
```

PS C:\Users\oscar> curl http://10.250.1.56:80


StatusCode        : 200
StatusDescription : OK
Content           : <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

                    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
                      <head>
                        <title>Test Page for the Nginx...
RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Accept-Ranges: bytes
                    Content-Length: 3429
                    Content-Type: text/html
                    Date: Wed, 24 Nov 2021 16:27:36 GMT
                    ETag: "60c1d6af-d65"
                    Last-Modified: Thu, 10 Jun 2021...
Forms             : {}
Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 3429], [Content-Type, text/html]...}
Images            : {@{innerHTML=; innerText=; outerHTML=<IMG alt="[ Powered by nginx ]" src="nginx-logo.png" width=121 height=32>; outerText=; tagName=IMG; alt=[ Powered by nginx ]; src=nginx-logo.png; width=121; height=32},
                    @{innerHTML=; innerText=; outerHTML=<IMG alt="[ Powered by Rocky Linux ]" src="poweredby.png" width=88 height=31>; outerText=; tagName=IMG; alt=[ Powered by Rocky Linux ]; src=poweredby.png; width=88; height=31}}
InputFields       : {}
Links             : {@{innerHTML=Rocky Linux website; innerText=Rocky Linux website; outerHTML=<A href="https://www.rockylinux.org/">Rocky Linux website</A>; outerText=Rocky Linux website; tagName=A; href=https://www.rockylinux.org/},
                    @{innerHTML=available on the Rocky Linux website; innerText=available on the Rocky Linux website; outerHTML=<A href="https://www.rockylinux.org/">available on the Rocky Linux website</A>; outerText=available on the
                    Rocky Linux website; tagName=A; href=https://www.rockylinux.org/}, @{innerHTML=<IMG alt="[ Powered by nginx ]" src="nginx-logo.png" width=121 height=32>; innerText=; outerHTML=<A href="http://nginx.net/"><IMG alt="[
                    Powered by nginx ]" src="nginx-logo.png" width=121 height=32></A>; outerText=; tagName=A; href=http://nginx.net/}, @{innerHTML=<IMG alt="[ Powered by Rocky Linux ]" src="poweredby.png" width=88 height=31>;
                    innerText=; outerHTML=<A href="http://www.rockylinux.org/"><IMG alt="[ Powered by Rocky Linux ]" src="poweredby.png" width=88 height=31></A>; outerText=; tagName=A; href=http://www.rockylinux.org/}}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 3429
```

5. Modif de la conf du serveur web

On change le port d'écoute de 80 à 8080
```
sudo nano /etc/nginx/nginx.conf
 server {
        listen       8080 default_server;
        listen       [::]:8080 default_server;
```
Le port a bien été changé:
```
[oscar@node1 html]$ sudo ss -ltnp
State                 Recv-Q                Send-Q                               Local Address:Port                                 Peer Address:Port                Process
LISTEN                0                     128                                        0.0.0.0:8080                                      0.0.0.0:*                    users:(("nginx",pid=1656,
```
On ferme l'ancien port dans le firewall, et on ajoute le port 8080.
```
[oscar@node1 html]$ sudo firewall-cmd --remove-port=80/tcp --permanent
success
[oscar@node1 html]$ sudo firewall-cmd --add-port=8080/tcp --permanent
success
[oscar@node1 html]$ sudo firewall-cmd --reload
success
```
On peut désormais visiter le port 8080
```
 PS C:\Users\oscar> curl http://10.250.1.56:8080                                                                         

StatusCode        : 200
StatusDescription : OK
Content           : <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

                    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
                      <head>
                        <title>Test Page for the Nginx...
RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Accept-Ranges: bytes
                    Content-Length: 3429
                    Content-Type: text/html
                    Date: Wed, 24 Nov 2021 16:46:58 GMT
                    ETag: "60c1d6af-d65"
                    Last-Modified: Thu, 10 Jun 2021...
Forms             : {}
Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 3429], [Content-Type,
                    text/html]...}
Images            : {@{innerHTML=; innerText=; outerHTML=<IMG alt="[ Powered by nginx ]" src="nginx-logo.png"
                    width=121 height=32>; outerText=; tagName=IMG; alt=[ Powered by nginx ]; src=nginx-logo.png;
                    width=121; height=32}, @{innerHTML=; innerText=; outerHTML=<IMG alt="[ Powered by Rocky Linux ]"
                    src="poweredby.png" width=88 height=31>; outerText=; tagName=IMG; alt=[ Powered by Rocky Linux ];
                    src=poweredby.png; width=88; height=31}}
InputFields       : {}
Links             : {@{innerHTML=Rocky Linux website; innerText=Rocky Linux website; outerHTML=<A
                    href="https://www.rockylinux.org/">Rocky Linux website</A>; outerText=Rocky Linux website;
                    tagName=A; href=https://www.rockylinux.org/}, @{innerHTML=available on the Rocky Linux website;
                    innerText=available on the Rocky Linux website; outerHTML=<A
                    href="https://www.rockylinux.org/">available on the Rocky Linux website</A>; outerText=available
                    on the Rocky Linux website; tagName=A; href=https://www.rockylinux.org/}, @{innerHTML=<IMG alt="[
                    Powered by nginx ]" src="nginx-logo.png" width=121 height=32>; innerText=; outerHTML=<A
                    href="http://nginx.net/"><IMG alt="[ Powered by nginx ]" src="nginx-logo.png" width=121
                    height=32></A>; outerText=; tagName=A; href=http://nginx.net/}, @{innerHTML=<IMG alt="[ Powered by
                    Rocky Linux ]" src="poweredby.png" width=88 height=31>; innerText=; outerHTML=<A
                    href="http://www.rockylinux.org/"><IMG alt="[ Powered by Rocky Linux ]" src="poweredby.png"
                    width=88 height=31></A>; outerText=; tagName=A; href=http://www.rockylinux.org/}}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 3429
```

Changer l'utilisateur qui lance le service

Création du nouvel utilisateur "web"
```
[oscar@node1 html]$ sudo useradd web -d /home/web -p hihi
```
On modifie le fichier de conf de NGINX pour définir le nouvel utilisateur en tant que celui qui lance le service

```
sudo nano /etc/nginx/nginx.conf
```
On remplace "root" par "web"
```
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user web;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
```
Nginx tourne bien sous l'utilisateur web
```
[oscar@node1 nginx]$ sudo ps aux| grep nginx
root        1993  0.0  0.2 119160  2164 ?        Ss   20:09   0:00 nginx: master process /usr/sbin/nginx
web         1994  0.0  0.9 151820  8028 ?        S    20:09   0:00 nginx: worker process
```

Changer l'emplacement de la racine Web

On édite le fichier nginx.conf

```
[oscar@node1 nginx]$ sudo nano nginx.conf
```
On cherche "root" puis on remplace l'ancienne racine web par la nouvelle (/var/www/super_site_web)
```
 server {
        listen       8080 default_server;
        listen       [::]:8080 default_server;
        server_name  _;
        root         /var/www/super_site_web;
```
On accède au nouveau site depuis le Terminal du PC:
```
PS C:\Users\oscar> curl http://10.250.1.56:8080


StatusCode        : 200
StatusDescription : OK
Content           : <h1>toto</h1>

RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Accept-Ranges: bytes
                    Content-Length: 14
                    Content-Type: text/html
                    Date: Wed, 24 Nov 2021 20:47:15 GMT
                    ETag: "619e981c-e"
                    Last-Modified: Wed, 24 Nov 2021 19:...
Forms             : {}
Headers           : {[Connection, keep-alive], [Accept-Ranges, bytes], [Content-Length, 14], [Content-Type,
                    text/html]...}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 14
```
