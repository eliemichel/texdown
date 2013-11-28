# Langages formels, Calculabilité, Complexité

<center>Elie Michel, d'après le cours d'Eugène Asarin</center><br/><br/>

Pour le début du cours, *cf* version papier puis version $\TeX$.



## Calculabilité


// theoreme
$f$ récursive partielle $\Leftrightarrow f$ calculable par une machine de Turing.


/* preuve
**Sens facile** : $\Rightarrow$  
On prouve par induction structurelle sur $f$ récursive partielle que $f$ est *bien* calculable par une machine de Turing $M$.

Par *bien calculer*, on entend :

 * $M$ calcule $f$
 * $M$ s'arrête en état $q_1$ seulement
 * $M$ ne va jamais à gauche de sa position initiale
 * À la fin du calcul sur $(X_1, \ldots, X_k)$, on a sur le ruban $\overline{\underline{0000}\underset{\Delta}0\underline{1111\ldots10000}}$ avec $f(\overline X)$ fois 1.

$0 : q_0 \overset{0/0^-}\longrightarrow q_1$  
Le ruban est alors $\overline{\underline{\ldots}\underset{\Delta}0\underline{\ldots}}$

$\sigma : \ldots$

$\pi_i^k$ : facile.

**Comp** (Cas scalaire) :  
On a une machine $F = (Q_F, \Sigma, q_{0F}, \Delta_F)$ qui calcule $f$.  
On a une machine $G = (Q_G, \Sigma, q_{0G}, \Delta_G)$ qui calcule $g$.  
On suppose $Q_F$ et $Q_G$ disjoints.  
On pose alors $M = (Q_F \cup Q_G, \Sigma, q_{0F}, \Delta_F \cup \Delta_G \cup \{q_{1F} \overset {0/0^-}\longrightarrow q_{0G}\})$.  
Cette machine calcule alors Comp$(g, f)$.

**Rec_prim** :  
On a une machine $F$ pour $f(X)$ et une machine $G$ pour $g(X, Y, v)$.  
On veut une machine pour  
$\begin{array}{r|l l}
	h(X, Y) = & f(X)                 & \text{si } Y = 0 \\
	          & g(X, Y-1, h(X, Y-1)) & \text{sinon}
\end{array}$

Pseudo code pour cette machine :

	X, Y
	Y_1 = Y
	i = 0
	h = f(X)
	répéter tq Y_1 > 0
		i_1 = i
		h_1 = h
		Y_1--
		i++
		h = g(X, i_1, h_1)
	effacer tout sauf h

En pratique :

$\overline{\underset{\underset{q_{0}}\Delta}0\underline{\quad X\quad 0 \quad Y \quad}}$

$\overline{\underline{0 \quad X\quad 0 \quad Y \quad 0 \quad Y_1 = Y \quad 0 \quad i_1 = 0 \quad}\underset{\underset{q_{0F}}\Delta}0}$

$\overline{\underline{0 \quad X\quad 0 \quad Y \quad 0 \quad Y_1 = 0 \quad 0 \quad i_1 = Y \quad \ldots \quad}\underset{\underset{q_{1G}}\Delta}0\underline{\quad h = h(X, Y) \quad }}$

**Sens difficile** : $\Leftarrow$  
Méthode : On code tout par des nombres. (C'est l'arithmétisation, ou Gödelisation.)  
Notation : Numéro de Gödel de $X$ : $\langle X \rangle \in \mathbb N$.

n-uplet d'entiers : $\langle (X_1, \ldots, X_n) \rangle = 2^n \displaystyle\prod_{i=1}^np_i^{X_i}$
où $p_i$ désigne le $i^{\text{ème}}$ nombre premier.  
Cette notation est injective et toutes les opérations utiles sont récursives primitives.

On fixe un alphabet $\Sigma = \{a_1, \ldots, a_n\}$ et on pose :

 * Pour tout $i$, $\langle a_i \rangle = i$
 * Si $w = w_1\ldots w_K$, $\langle w \rangle = \langle (\langle w_1 \rangle, \ldots, \langle w_K \rangle) \rangle$.

La machine de Turing est $M = (Q, \Sigma, \Delta, q_0)$ avec

 * $Q = \{q_0, q_1, \ldots, q_m\}$
 * $\Sigma = \{a_0 = 0, a_1 = 1, \ldots, a_n = n\}$
 * Pour tout $i$, $\langle q_i \rangle = i$
 * config $\overline{\underline{W_g \quad}\underset{\underset{q}\Delta}{W_d}\underline{\quad}}$,
   $\langle$config$\rangle = \langle(\langle W_g \rangle, \langle q \rangle, \langle W_d \rangle)\rangle$
 * instr $i = p \overset{a/b, \text{depl}}{\longrightarrow} q$,
   $\langle instr \rangle = \langle (\langle p \rangle, \langle a \rangle, \langle b\rangle, \langle \text{depl} \rangle, \langle q \rangle)\rangle$
 * $\Delta = \{i_1, \ldots, i_r\}$ puis ensuite $\langle M \rangle = \langle(\langle i_1 \rangle, \ldots, \langle i_r \rangle)\rangle$

On a une machine de Turing de numéro $m = \langle M \rangle$.  
On cherche à exprimer $f_M : \mathbb N \rightarrow \mathbb N$ en récursion partielle.

 1. Soit init$(X) = \langle \overline{\underset{\underset{q_0}\Delta}{0}\underline{111\ldots 1}} \rangle$  
    init $\in$ RP
 2. Soit suivant$(m, c) = \langle \text{conf'} \rangle$
    avec conf $\overset M \longrightarrow$ conf' et $\langle$conf$\rangle = c$  
    suivant $\in$ RP
 3. conf$(m, X, t) =$ numéro de la config de la machine $m$ sur l'entrée $X$ après $t$ pas de calcul (ou 0 en cas d'erreur)  
    conf $\in$ RP
 4. stop$(m, c) =$ 1 ssi $m$ ets bloqué sur la config de numéro $c$  
    stop $\in$ RP
 5. temps$(m, X) =$ temps de calcul de la machine $m$ sur l'entrée $X$  
    temps$(m, X) = \mu t.($stop$(m, $conf$(m, X, t)))  
    temps $\in$ RP
 6. sortie$(c) =$ nombre de 1 sur le ruban dans la config de numéro $c$ (ou 0 en cas d'erreur)
    sortie $\in$ RP
 7. $\mathcal U(m, X) =$ résultat du calcul de la machine de numéro $m$ sur l'entrée $X$.

*/

On a démontré que $f$ rec part $\Leftrightarrow f$ MT calculcable.

// remarque
Dans le même style, on peut faire $f$ rec part $\Leftrightarrow f$ programmable en C

// corollaire (forme normale)
Chaque fonction récursive partielle peut être exprimée comme ceci :  
$f(X) = g(X, \mu Y.P(X, Y))$ où $g, P \in$ RPrim

### Fonction universelle
Il existe une fonction récursive partielle (*i.e.* Turing-calculcable) $\mathcal U(m, x)$ telle que
pour chaque machine de Turing $M$, $\mathcal U(\langle M \rangle, x) = f_M(x)$.

$\mathcal U$ sait donc faire les calculs de chaque machine de Turing.

$\mathcal U$ est une MT rec part qui sait interpréter toutes les MT.
On a donc une machine de Turing universelle $M_{\mathcal U}$ qui calcule $\mathcal U$.

$\overline{\underset{\underset{q_{0}}\Delta}0\underline{\quad \langle M \rangle \quad 0 \quad X \quad}}$  
$ \quad \downarrow \mathcal U$  
$\overline{\underline{0 \quad f_M(X) \quad}}$

// theoreme (d'énumération)
On peut énumérer toutes les fonctions réc part $\varphi_0, \varphi_1, \ldots, \varphi_K$
et la fonction $(i, X) \mapsto \varphi_i(X)$ est elle aussi récursive partielle.

// preuve
Soit $\varphi_i(X) = \mathcal U(i, x)$  
Autrement dit, $\varphi_{\langle M \rangle}(X) = f_M(X)$ où $M$ est une machine de Turing.

// theoreme (s-n-m)
Il existe une fonction récursive partielle $s$ telle que  
$\varphi_m^{(2)}(X, Y) = \varphi_{s(m, X)}^{(1)}(Y)$

/* exemple
Soit $f(X, Y) = \varphi_m^{(2)}(X, Y)$ une fonction calculable telle que :

 * Y \mapsto f(0, Y) = \varphi_{c_0}^{(1)}(Y)
 * Y \mapsto f(1, Y) = \varphi_{c_1}^{(1)}(Y)
 * $\vdots$
 * Y \mapsto f(K, Y) = \varphi_{c_K}^{(1)}(Y)

avec $c_K = s(m, K) =$ machine $m$ où le premier argument est fixé à $K$.

*/


/* preuve
On a $m$ un numéro de MT et $X$ une valeur de paramètre.  
On construit une nouvelle MT de numéro $s(m, X)$ d'argument $Y$ telle que

$\overline{\underline{\quad \quad \quad \quad}\underset{\underset{q_{0}}\Delta}0\underline{\quad Y \quad}}$  
$ \quad \downarrow$  
$\overline{\underset{\underset{q_{0M}}\Delta}0\underline{\quad X \quad 0 \quad Y \quad}}$ (On écrit X)

$M'$ : instructions pour écrire $X \cup$ toutes les instructions de $M$.

*/


**Application de s-n-m**  
Trouver $h$ tel que $\varphi_{h(X, Y)} = \text{Comp}(\varphi_X, \varphi_Y)$  
Comment composer deux fonctione récursives partielles (d'un point de vue numéral) ?

Soit $f(X, Y, Z) = \varphi_X(\varphi_Y(Z)) = \mathcal U(X, \mathcal U(Y, Z))$

$f$ est rec part donc on peut poser $b_f$ son numéro.  
$b_f(X, Y, Z) = \text{Comp}(\varphi_X, \varphi_Y)(Z)$

On utilise alors le théorème s-n-m :  
$\varphi_{s(b_f, X, Y)}(Z) = \text{Comp}(\varphi_x, \varphi_Y)(Z)$

Ainsi, $h(X, Y) = s(b_f, X, Y)$ convient.


### Ensemble/Prédicats décidables et indécidables

// definition
$P \subset \mathbb N^*$ est décidable si $\chi_p$ est récursive totale.

// propriete
Les ensembles décidables sont clos par union, intersection et passage au complémentaire.

// preuve
$\chi_{A \cap B} = \chi_A \chi_B$  
$\chi_{\overline A} = 1 - \chi_A$

// definition
Un ensemble ou prédicat est *intéressant* si Arrêt = $\{(X, Y) ~|~ \varphi_X(Y)\downarrow\}$

// definition
$K(X) \Leftrightarrow$ Arrêt$(X, X)$

// theoreme
$K$ est indécidable, Arrêt aussi.

/* preuve
Supposons $K$ décidable.  
Il existe une fonction récursive totale $g$ telle que :

 * $\varphi_X(X)\downarrow \Rightarrow g(X) = 1$
 * $\varphi_X(X)\uparrow \Rightarrow g(X) = 0$

On construit une fonction "paradoxale", "diagonale" :  
$\begin{array}{r|l}
d(X) = v(g(X)) = & 0 \text{ si } \varphi_X(X)\uparrow \\
& \uparrow \text{ si } \varphi_X(X)\downarrow
\end{array}$

On peut choisir $v$ recursive partielle (par exemple $v(z) = \mu Y.(0=Z)$) donc $d$ est rec part.

On a donc $d(X)\downarrow \Leftrightarrow \varphi_X(X)\uparrow$ ($*$)

**Première contradiction**  
$d(K)\downarrow \Leftrightarrow \varphi_K(K)\uparrow$  
donc $d \neq \varphi_K$

Ainsi, $d$ n'est pas dans la liste de toutes les rec part, ce qui est contradictoire.

**Seconde contradiction** *(du barbier)*  
$d$ est rec part.  
Soit $b$ son numéro. ($d = \varphi_b$)  
On applique ($*$) à $b$ :

$\forall X, \varphi_b(X)\downarrow \Leftrightarrow \varphi_X(X)\uparrow$

Prenons $x = b$ :  
$\forall X, \varphi_X(X)\downarrow \Leftrightarrow \varphi_X(X)\uparrow$  
Absurde.

*/

// indent (Rappel)  
On ne peut pas énumérer les fonctions totales « calculables ».
Si on avait une liste $f_1, f_2, \ldots$ de toutes ces fonctions, la fonction
transversale $d:x \mapsto f_x(x)+1$ serait hors de cette liste.  
C'est cependant le cas pour les fonctions récursives partielles.

**Objectif** Prouver l'indécidabilité de problèmes.

// definition
Soient A et B deux préducats sur $\mathbb N$.  
On dit que $A \leq_m B$ (*A se réduit à B*) s'il existe $h$ récursive totale telle que  
$\forall x, A(x) \Leftrightarrow B(h(x))$

// propriete
$\leq_m$ est réflexive et transitive.  
Si A est décidable et B non vide, alors A se réduit en B.

// propriete
Si A $\leq_m$ B et B est décidable, alors A est décidable.

// preuve
$\chi_A(x) = \underset{rec}{\underbrace{\chi_B}}(\underset{rec}{\underbrace{h}}(x))$ est rec.

// corollaire (utilisé en calculcabilité)
Si $A \leq_m B$ et A est indécidable, alors B est indécidable.

Donc pour prouver l'indécision de B, il suffit de montrer $K \leq_m B$ ou Arrêt $\leq_m B$.

/* exemple
$P(x) \Leftrightarrow \varphi_x(12) = 13$  
Montrons que $P$ est indécidable.

On veut montrer que $K \leq_m P$.

*Raisonement informel* :  
On transforme le programme $x$ en programe $h(x)$ tel que  
$\begin{array}{r|l}
\varphi_{h(x)}(y) = & 13 \text{ si } \varphi_x(x) \downarrow \\
& \uparrow \text{ si } \varphi_x(x) \uparrow
\end{array}$

Si on a un tel $h$, alors  
$\begin{array}{rl}
x\in K & \Rightarrow \varphi_x(x) \downarrow \\
& \Rightarrow \varphi_{h(x)}(y) = 13 \forall y \\
& \Rightarrow \varphi_{h(x)}(12) = 13 \\
& \Rightarrow h(x) \in P \\
\end{array}$

$\varphi_{h(x)}(y)$ : on calcule $\varphi_x(x)$ et quand ça s'arrête on retourne 13.

*Formellement*  
On pose $\begin{array}{r|l}
f(x, y) = & 13 \text{ si } \varphi_x(x) \downarrow\\
& \uparrow \text{ si } \varphi_x(x) \uparrow
\end{array}$  
On a $f(x, y) = \mathcal U(x, x).0 + 13$ donc f est rec partielle.

Soit $a$ son numéro.  
On applique le s.m.n.  
On pose $h(x) = s(a, x)$

*/

/* definition
Soit $C$ un ensemble de fonctions partielles de $\mathbb N \rightarrow \mathbb N$.  
On dit que $C$ est non trivial si

1. $\exists f$ rec partielle telle que $f \in C$
2. $\exists f$ rec partielle telle que $f \not \in C$

*/

// theoreme (de Rice)
Soit $C$ non-trivial. On définit $P_C = \{x~|~\varphi_x \in C\}$.  
Alors $P_C$ est indécidable.

**Conséquence** Toutes les propriétés des fonctions rec partielles ou des machines de Turing sont
indécidables.

/* preuve
*Cas 1* : $\bot \not \in C$  
Soit $f \in C$ rec partielle.

On va réduire $K \leq_m P_C$  
Pour ça, on construit $h$ tel que  
$\begin{array}{r|l}
\varphi_{h(x)}(y) = & f(y) \text{ si } \varphi_x(x) \downarrow \\
& \uparrow \text{ si } \varphi_x(x) \uparrow
\end{array}$

Alors on aura  
$x\in K \Rightarrow \varphi_{h(x)} = f \in C \Rightarrow h(x) \in P_C$  
$x \not \in K \Rightarrow \varphi_{h(x)} = \bot \not \in C \Rightarrow h(x) \in P_C$  
Donc $K \leq_m P_C$.

Pour construire $h(x)$ rec prim, on utilise s.m.n.

*Cas 2* : $\bot \in C$  
Soit $f \not \in C$ rec partielle.  
La même réduction que précédemment donne  
$K \leq_m \overline{P_C} \Rightarrow \overline{P_C}$ indécidable

Donc $P_C$ est indécidable.

*/

// remarque
Les problèmes sur les machines de Turing peuvent être indécidables.

/* exemple
Problèmes décidables :

 * Est-ce que la machine de numéro $x$ a un nombre premier d'instructions ?
 * Est-ce que $\varphi_x(10) = 12$ et que le calcul prend moins de 10^{10^{10}} pas ?

Problèmes indécidables car sur des fonctions calculées :

 * $\varphi_x(y) = y! ~ \forall y$
 * $\varphi_x()$ est totale

*/

### Semi-décidabilité ###

// remarque
Pour $K(x)$, Arrêt$(x, y), \varphi_x(10) = 13 ?$, si la réponse est oui alors on le saura.

// definition
$P\subset \mathbb N^K$ est semi-décidable (*sd*) s'il existe $f$ rec partielle telle que $P = \text{dom} f = \{x~|~f(x)\downarrow\}$.

Variante : Soit
$\begin{array}{r|l}
\psi_P(x) = & 1 \text{ si } x \in P \\
& \uparrow \text{ sinon}
\end{array}$

// proposition
$P$ est semi-décidable $\Leftrightarrow \psi_P$ rec partielle

// definition
$P \subset \mathbb N$ est récursivement énumérable (*re*) si  
$P \neq \emptyset$ ou $\exists h$ rec totale telle que $P = \text{Im}(h)$

// propriete (Forme normale)
$P$ semi-décidable $\Rightarrow$ (Pour $R$ rec prim, $x\in P \Leftrightarrow \exists t: R(x, t)$)

// theoreme
re $\Leftrightarrow$ sd

// indent (Rappel)
ex2$(n) =$ exposant de 2 dans la factorisation de $n$ en facteurs premiers.  
ex2$(n) = \mu i\leq n.(2\uparrow(i+1) \nmid n)$

// theoreme (de Post)
$P$ décidable $\Leftrightarrow P$ semi-décidable et $\overline P$ semi-décidable.

// corrollaire
$K$ est sd.  
$\overline K$ n'est pas sd.  
Arrêt est sd.  
$\overline{\text{Arrêt}}$ n'est pas sd.

// exemple
Tot $= \{x~|~\varphi_x \text{ est totale}\} = \{x~|~\forall y, \varphi_x(y)\downarrow\}$

// propriete
Tot n'est pas sd.  
$\overline{\text{Tot}}$ n'est pas sd.




