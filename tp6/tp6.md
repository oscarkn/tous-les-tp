# TP6 : Stockage et sauvegarde

**Partie 1 : Préparation de la machine backup.tp6.linux**

I. Ajout de disque

Ajouter un disque dur de 5Go à la VM backup.tp6.linux

Un lsblk avant l'ajout du nouveau disque dur

```
[oscar@backup ~]$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda           8:0    0    8G  0 disk
├─sda1        8:1    0    1G  0 part /boot
└─sda2        8:2    0    7G  0 part
  ├─rl-root 253:0    0  6.2G  0 lvm  /
  └─rl-swap 253:1    0  820M  0 lvm  [SWAP]
sr0          11:0    1 1024M  0 rom
```
Un lsblk après l'ajout du nouveau disque dur

```
[oscar@backup ~]$ lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda           8:0    0    8G  0 disk
├─sda1        8:1    0    1G  0 part /boot
└─sda2        8:2    0    7G  0 part
  ├─rl-root 253:0    0  6.2G  0 lvm  /
  └─rl-swap 253:1    0  820M  0 lvm  [SWAP]
sdb           8:16   0    5G  0 disk
sr0          11:0    1 1024M  0 rom
```

II. Partitioning

Partitionner le disque à l'aide de LVM

Créer un physical volume (PV) : le nouveau disque ajouté à la VM

```
[oscar@backup ~]$ sudo pvcreate /dev/sdb
[sudo] password for oscar:
  Physical volume "/dev/sdb" successfully created.
```
Vérification: le PV a bien été crée
```
[oscar@backup ~]$ sudo pvdisplay
  --- Physical volume ---
  PV Name               /dev/sda2
  VG Name               rl
  PV Size               <7.00 GiB / not usable 3.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              1791
  Free PE               0
  Allocated PE          1791
  PV UUID               9U7if7-K8Jf-jFyH-crG2-b6P9-xB0o-MZvel9

  "/dev/sdb" is a new physical volume of "5.00 GiB"
  --- NEW Physical volume ---
  PV Name               /dev/sdb
  VG Name
  PV Size               5.00 GiB
  Allocatable           NO
  PE Size               0
  Total PE              0
  Free PE               0
  Allocated PE          0
  PV UUID               PEN57J-1jns-yfho-d8WR-t2dR-IgKS-2gs91s
```
Créer un nouveau volume group (VG)
```
[oscar@backup ~]$ sudo vgcreate backup /dev/sdb
  Volume group "backup" successfully created
```
Vérification: le nouveau VG a bien été crée et il contient le PV créé à l'étape précédente
```
[oscar@backup ~]$ sudo vgs
  VG     #PV #LV #SN Attr   VSize  VFree
  backup   1   0   0 wz--n- <5.00g <5.00g
  rl       1   2   0 wz--n- <7.00g     0
```
```
[oscar@backup ~]$ sudo vgdisplay
  --- Volume group ---
  VG Name               backup
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <5.00 GiB
  PE Size               4.00 MiB
  Total PE              1279
  Alloc PE / Size       0 / 0
  Free  PE / Size       1279 / <5.00 GiB
  VG UUID               0rezvi-tvYp-0Aio-GsL9-EZiA-V2Ey-vQLL3Y

  --- Volume group ---
  VG Name               rl
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  3
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                2
  Open LV               2
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <7.00 GiB
  PE Size               4.00 MiB
  Total PE              1791
  Alloc PE / Size       1791 / <7.00 GiB
  Free  PE / Size       0 / 0
  VG UUID               Mi388N-Y4V3-CrcZ-3YSP-OJE9-F0JG-hddQW2
```
Créer un nouveau logical volume (LV)

Elle est dans dans le VG backup et elle occupe tout l'espace libre. Vérification:

```
[oscar@backup ~]$ sudo lvs
  LV          VG     Attr       LSize   Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  backup_data backup -wi-a-----  <5.00g
  root        rl     -wi-ao----  <6.20g
  swap        rl     -wi-ao---- 820.00m
```
```
[oscar@backup ~]$ sudo lvdisplay
  --- Logical volume ---
  LV Path                /dev/backup/backup_data
  LV Name                backup_data
  VG Name                backup
  LV UUID                vczUy7-S3XV-elDx-P0vf-CyQJ-0Ex1-v3TvZH
  LV Write Access        read/write
  LV Creation host, time backup.tp6.linux, 2021-12-01 11:40:37 +0100
  LV Status              available
  # open                 0
  LV Size                <5.00 GiB
  Current LE             1279
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:2

  --- Logical volume ---
  LV Path                /dev/rl/swap
  LV Name                swap
  VG Name                rl
  LV UUID                Z0kkbS-Ytin-gTdt-uKUy-xngc-YcDb-LMtS0m
  LV Write Access        read/write
  LV Creation host, time localhost, 2021-11-23 15:19:25 +0100
  LV Status              available
  # open                 2
  LV Size                820.00 MiB
  Current LE             205
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:1

  --- Logical volume ---
  LV Path                /dev/rl/root
  LV Name                root
  VG Name                rl
  LV UUID                1xb9aF-Cb3M-sFWu-q86e-HGtv-LWop-HWuw4H
  LV Write Access        read/write
  LV Creation host, time localhost, 2021-11-23 15:19:25 +0100
  LV Status              available
  # open                 1
  LV Size                <6.20 GiB
  Current LE             1586
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:0
```
Formater la partition

On formate la partition en ext4

```
[oscar@backup ~]$ sudo mkfs /dev/backup/backup_data --type ext4
[sudo] password for oscar:
mke2fs 1.45.6 (20-Mar-2020)
Creating filesystem with 1309696 4k blocks and 327680 inodes
Filesystem UUID: 71b3130f-e5f0-4dec-a559-93afa37ae2ba
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done
```

Vérification:
```
[oscar@backup ~]$ lsblk -f
sdb                  LVM2_member       PEN57J-1jns-yfho-d8WR-t2dR-IgKS-2gs91s
└─backup-backup_data ext4              71b3130f-e5f0-4dec-a559-93afa37ae2ba
```

Monter la partition

Montage de la partition avec la commande mount

On crée le dossier /backup dans /

```
[oscar@backup /]$ pwd
/
[oscar@backup /]$ sudo mkdir /backup
```
Montage de la partition
```
[oscar@backup /]$ mount /dev/backup/backup_data /backup
```
Preuve que la partition a été montée
```
[oscar@backup /]$ df -h /backup/
Filesystem                      Size  Used Avail Use% Mounted on
/dev/mapper/backup-backup_data  4.9G   20M  4.6G   1% /backup
```
Avant de pouvoir lire et écrire sur cette partition, il faut changer les droits:
```
[oscar@backup /]$ sudo chown oscar: /backup
[oscar@backup /]$ sudo chmod 766 /backup
```
On peut maintenant lire et écrire:
```
[oscar@backup /]$ ls -l /
total 24
drwxrw-rw-.   3 oscar oscar 4096 Dec  1 13:17 backup
```
Définir un montage automatique de la partition

On modifie le fichier /etc/fstab
```
[oscar@backup /]$ sudo nano /etc/fstab
```

On insère la ligne suivante:

```
UUID=71b3130f-e5f0-4dec-a559-93afa37ae2ba       /backup ext4
```
(On précise l'ID du disque, où faire le montage et le type de File System)

Pour tester, on unmount:

```
[oscar@backup /]$ sudo umount /backup
```
Puis, on redémarre la VM et on affiche le contenu de /backup et on voit que le montage a été fait automatiquement.
```
[oscar@backup ~]$ ls /backup/
lost+found
```

**Partie 2 : Setup du serveur NFS sur backup.tp6.linux**

Préparer les dossiers à partager

On crée deux sous-dossiers dans l'espace de stockage dédié

```
[oscar@backup backup]$ mkdir web.tp6.linux
[oscar@backup backup]$ mkdir db.tp6.linux
[oscar@backup backup]$ ls
db.tp6.linux  lost+found  testfile  web.tp6.linux
```
On installe le paquet nfs-utils
```
[oscar@backup ~]$ sudo dnf install nfs-utils
Complete!
```

Conf du serveur NFS

On modifie le fichier /etc/idmapd.conf
```
[oscar@backup ~]$ sudo nano /etc/exports
```
On insère:

```
/backup/web.tp6.linux/ 10.5.1.11/24(rw,no_root_squash)
/backup/db.tp6.linux/ 10.5.1.12/24(rw,no_root_squash)
```
L'option "rw" signifie que seulement les utilisateurs de l'IP précisée ont accès en lecture/écriture au dossier précisé


L'option "no_root_squash" donne au super-utilisateur en connexion distante tous les privilèges de son statut. 
Attention, ceci n'est pas idéal pour la sécurité.

On démarre le service

```
[oscar@backup ~]$ [oscar@backup ~]$ systemctl start nfs-server
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-units ====
Authentication is required to start 'nfs-server.service'.
Authenticating as: oscar
Password:
==== AUTHENTICATION COMPLETE ====
[oscar@backup ~]$ systemctl status nfs-server
● nfs-server.service - NFS server and services
   Loaded: loaded (/usr/lib/systemd/system/nfs-server.service; disabled; vendor preset: disabled)
   Active: active (exited) since Wed 2021-12-01 17:27:49 CET; 15s ago
[oscar@backup ~]$ systemctl enable nfs-server
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-unit-files ====
Authentication is required to manage system service or unit files.
Authenticating as: oscar
Password:
==== AUTHENTICATION COMPLETE ====
Created symlink /etc/systemd/system/multi-user.target.wants/nfs-server.service → /usr/lib/systemd/system/nfs-server.service.
==== AUTHENTICATING FOR org.freedesktop.systemd1.reload-daemon ====
Authentication is required to reload the systemd state.
Authenticating as: oscar
Password:
==== AUTHENTICATION COMPLETE ====
```

On gère le Firewall:

On ouvre le port 2049/tcp

```
[oscar@backup ~]$ sudo firewall-cmd --add-port=2049/tcp --permanent
success
[oscar@backup ~]$ sudo firewall-cmd --reload
success
```
La machine écoute sur ce port
```
[oscar@backup ~]$ sudo ss -ltnp
State  Recv-Q Send-Q Local Address:Port   Peer Address:Port Process
LISTEN 0      64           0.0.0.0:2049        0.0.0.0:*
```


**Partie 3 : Setup des clients NFS : web.tp6.linux et db.tp6.linux**

Installation sur web.tp6.linux

```
[oscar@web ~]$ sudo dnf install nfs-utils
Complete!
```

Configuration

On crée un dossier /srv/backup dans lequel sera accessible le dossier partagé

```
[oscar@web ~]$ cd /srv
[oscar@web srv]$ sudo mkdir backup
[oscar@web srv]$ ls
backup
```
On modifie le fichier /etc/idmapd.conf
```
[oscar@web srv]$ sudo nano /etc/idmapd.conf
```
```
[General]
#Verbosity = 0
# The following should be set to the local NFSv4 domain name
# The default is the host's DNS domain name.
Domain = tp6.linux
```
On monte la partition NFS /backup/web.tp6.linux/
```
[oscar@web srv]$ sudo mount -t nfs 10.5.1.13:/backup/web.tp6.linux/ /srv/backup
```
Preuve avec une commande df -h que la partition est bien montée
```
[oscar@web srv]$ df -h /srv/backup
Filesystem                       Size  Used Avail Use% Mounted on
10.5.1.13:/backup/web.tp6.linux  4.9G   20M  4.6G   1% /srv/backup
```

Preuve qu'on peut lire et écrire des données sur cette partition

```
[oscar@web srv]$ sudo chown oscar: /srv/backup
[oscar@web srv]$ sudo chmod 766 /srv/backup
[oscar@web srv]$ ls -l
total 4
drwxrw-rw-. 2 oscar oscar 4096 Dec  1 16:45 backup
```

**Définir un montage automatique de la partition**

On modifie le fichier /etc/fstab

```
 sudo nano /etc/fstab
```
On rajoute cette ligne à la fin:
```
10.5.1.13:/backup/web.tp6.linux /srv/backup     nfs     defaults        0 0
```
On unmount /backup/web.tp6.linux/
```
sudo umount 10.5.1.13:/backup/web.tp6.linux/
```
On redémarre la VM web, puis on se reconnecte.
```
[oscar@web ~]$ sudo reboot
PS C:\Users\oscar> ssh oscar@10.5.1.11
```
En effet, /backup/web.tp6.linux/ a été mounté automatiquement.
```
[oscar@web ~]$ df -h
Filesystem                       Size  Used Avail Use% Mounted on
10.5.1.13:/backup/web.tp6.linux  4.9G   20M  4.6G   1% /srv/backup
```

**On répète ces opérations sur db.tp6.linux**

Preuve avec une commande df -h que la partition est bien montée
```
[oscar@db srv]$ df -h /srv/backup
Filesystem                      Size  Used Avail Use% Mounted on
10.5.1.13:/backup/db.tp6.linux  4.9G   20M  4.6G   1% /srv/backup
```

Preuve qu'on peut lire et écrire des données sur cette partition

```
10.5.1.13:/backup/db.tp6.linux  4.9G   20M  4.6G   1% /srv/backup
[oscar@db srv]$ sudo chown oscar: /srv/backup
[oscar@db srv]$ sudo chmod 766 /srv/backup
[oscar@db srv]$ ls -l
total 4
drwxrw-rw-. 2 oscar oscar 4096 Dec  1 16:45 backup
```
Preuve que le fichier /etc/fstab fonctionne. Après un reboot, le dossier a bien été mounté
```
[oscar@db ~]$ df -h
Filesystem                      Size  Used Avail Use% Mounted on
10.5.1.13:/backup/db.tp6.linux  4.9G   20M  4.6G   1% /srv/backup
```

**Partie 4 : Scripts de sauvegarde**

I. Sauvegarde Web

Ecrire un script qui sauvegarde les données de NextCloud

