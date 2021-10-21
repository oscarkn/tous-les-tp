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



