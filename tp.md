# Plusieurs moyens pour casser Linux

**#1: Fork Bomb**

```
nano .bashrc
:(){ :|: & };:
```
.bashrc est un fichier caché qui est exécuté à chaque fois qu'un utilisateur se connecte. Ainsi, si on rentre une commande dans ce fichier, la commande sera exécutée lorsqu'un terminal est ouvert.

Pour casser la VM, on peut donc éditer .bashrc avec nano puis insérer une bombe fourchette, écrite :(){ :|: & };:

Cette commande lance un processus qui à son tour lance deux processus. Ensuite, ces deux processus lancent chacun **simultanément** deux processus. Puis, les quatre processus lancent à leur tour deux processus. Cela se repète jusqu'à ce que la RAM de la machine ne peut plus tolérer tous ces processus qui se déroulent en même temps et la machine ne peut plus fonctionner.

Après ceci, on peut relancer la machine mais dès qu'on ouvre un terminal, la bombe aura le même effet.

**#2: Supprimer tout**

```
sudo rm -rf / --no-preserve-root
```
Si on tape cette commande, puis on rentre son mot de passe, cela supprime le fichier "linux". C'est-à-dire que les commandes comme "cd" ou "ls" ne vont plus marcher.
Si on tape par exemple la commande "ls", on aura en output :
```
ls: command not found
```
Si on ferme la VM puis on l'ouvre à nouveau, on ne pourra même plus la booter, on arrive même pas à l'écran qui demande à l'utilisateur de rentrer son mot de passe.

**#3: Casual Rickroll**

En utilisant la commande "alias" on peut faire de sorte que lorsque l'utilisateur tape une commande, une commande différente est exécutée.
On peut donc mettre en place des rickroll avec cette commande:
```
alias pwd='gio open https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley'
```
Puis on retape cette commande mais on fait des alias pour "cd", "ls", "mkdir", "man", "mv", etc.
Ceci fait, lorsque l'utilisateur tapera une de ces commandes basiques, Firefox s'ouvrira et la chanson de Rick Astley sera déclenchée.

**#4: Instant Rickroll**

```
nano .bashrc
```
puis taper n'importe où
```
echo 'echo https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley 0.1 >> ~/.bashrc' >> ~/.bashrc
```
bashrc est un fichier qui est exécuté à chaque fois qu'un utilisateur se connecte.
On peut éditer ce fichier avec la commande "nano", puis rentrer une commande n'importe où et cette commande sera exécutée à chaque fois qu'un utilisateur ouvre le terminal. Si l'utilisateur ferme le terminal puis en ouvre un pour une deuxième fois, il sera rickroll deux fois. S'il essaye une troisième fois, il sera rickroll trois fois, etc.

**#5: Forever Rick**

```
cmd="gio open https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley"; for i in {1..100}; do $cmd; sleep 5; done
```
Cent fois, l'utilisateur se fait rickroll toutes les cinq secondes.
Note: on peut mettre d'autres commandes à la place de "gio open". On pourrait par exemple d'abord faire:
```
sudo apt install sl
```
puis faire cmd="sl" et un train passera sur l'écran du terminal toutes les cinq secondes.

**#6: Remplir le disque dur**

```
yes 'no more space for you' > .no-more-space &
```
Avec cette commande, le disque dur est rempli par un fichier caché ".no-more-space" qui contient beaucoup de fois la phrase "no more space for you".
Ensuite, si l'utilisateur essaye de faire "mkdir", ça sera impossible.
Aussi, si on fait "cat .no-more-space", cela fera chauffer la VM.

**#7: Tout est noir**

```
systemctl isolate multi-user.target
```
Avec cette commande, tout l'écran de la VM devient noir et on ne peut plus voir ce que l'on fait.

**#8: Rendre la VM impossible à booter**

```
sudo dd if=/dev/zero of=/dev/sda
```
Avec cette commande, on remplace certaines structures essentielles pour boot la machine par des zéros. Lorsqu'on essaye d'ouvrir la machine à nouveau, elle ne boot pas.








