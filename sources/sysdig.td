
# Système digital :<br/> De l'algorithme au circuit

<center>Elie Michel, d'après le cours de Jean Vuillemin</center><br/><br/>

Pour le début du cours, *cf* version papier.

## Théorie de l'information

 1. Théorie de Shannon
 2. Codage entropique
 3. Codes d'erreur

### Théorie de Shannon

Capacité du canal : $C$ bit/s  
Source d'entropie : $H$ Sh/cycle (Shannon par cycle)  
Débit de la source : $r$ cycle/s  
Bande passante : $B$ Sh/sec

// theoreme (De Shannon)
La communication sans erreur est possible si $C>B$ et impossible si $C&lt;B$.

#### Étapes de la communication de données

 * Compression
 * Ajout de code correcteur
 * Transmission : apporte du bruit
 * Décodage du canal : retrouver les bits envoyés à l'aide des bits de redondance
 * Décompression

### Codage entropique

// definition
La source est une suite de symboles sur un certain alphabet. $S = s_0 \ldots s_M$  
Chaque suite de $M+1$ symboles a une certaine probabilité $P(s_0, \ldots, s_M) = p_M$  
Dans le modèle sans mémoire, les suites sont indépendantes.  
On définit alors l'entropie : $H(S) = \sum p_n \log_2(\frac 1 {p_n})$

#### Développement en fraction continue

C'est un développement de la forme $x = /r_0r_1r_2 \ldots/ = r_0 + \frac 1 {/r_1r_2 \ldots/}$

On utilise le développement en fraction continue pour le codage de Huffman.

// theoreme (Inégalité de Kraft)
La longueur de code $I_k = |c_k|$ d'un code préfixe $(c_1, \ldots, c_N)$ satisfait  
$\displaystyle\sum_{1 \leq k \leq N}2^{-I_k} \leq 1$

// theoreme (Source de Shannon)
$H = \displaystyle\sum_{1\leq k\leq N}p_k \log_2 \frac 1 {p_k} \leq \displaystyle\sum_{1\leq k \leq N} p_k |c_k| = -C|$

#### Algorithme LZW

Il permet de déterminer la répartition statistique des différentes suites de bits afin d'optimiser le codage de Huffman.

Ce codage permet d'obtenir un taux de compression de 1 pour 3 pour du texte par exemple.


## Chaleur et équation de Laplace

La simulation est très complexe, mais l'analyse de l'équation de la chaleur est indispensable pour réaliser un circuit.

// definition (Équation de la chaleur)
$\frac \d {\d t}T(x, y, z, t) = c \left(\frac{\d^2}{\d x^2}+\frac{\d^2}{\d y^2}+\frac{\d^2}{\d z^2}\right)T(x, y, z, t) + p(x, y, z, t)$  
$p(x, y, z, t)$ est la source de chaleur extérieure.

// definition (Équation de Laplace)
C'est la cas limite de l'équation de la chaleur : $\frac{\d T}{\d t} = c\nabla^2T$

On ne cherche pas une solution analytique mais numérique. On utilise donc la méthode des éléments finis (finite elements).
Il y a un problème de définition aux limites (effets de bord). On peut le régler de plusieurs façons :

 * Réplication : Heat mirror
 * Puit de chaleur : Heat sink
 * Source de chaleur

Un autre problème que l'on rencontre est le choix du comportement de la division par 2 d'un nombre impair : Que faire du bit restant ?
On ne peut pas le tronquer car alors on perdrait de l'énergie. On choisi donc de façon aléatoire la valeur.
Cette solution est efficace car la marche aléatoire vérifie l'équation de la chaleur.
