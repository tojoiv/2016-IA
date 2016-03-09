using CP;

execute {
cp.param.logVerbosity = "Quiet";
	  }

// Il existe des pièces de 1, 2, ... 50 cts.
{int} piece = {1, 2, 5, 10, 20, 50};

// N'importe quelle somme inférieure à 1€ = 100 cts.
range somme = 1..99;

// Notre porte_monnaie contient un certains nombres de pièces.
dvar int porte_monnaie[piece] in 0..50;

// Choix représente pour toutes les sommes, le nombre de pièces
dvar int choix[somme, piece] in 0..99;

// On veut minimiser le nombre de pièces totales
minimize
     sum (i in piece) porte_monnaie[i];

// Les contraintes à satisfaire
subject to {
  forall(s in somme) {
    forall (p in piece) {
       choix[s][p] <= porte_monnaie[p];
     }
     (sum(i in piece) choix[s][i]*i) == s;
  }
}

execute {
	writeln("Nombres de Pièces  = ", porte_monnaie );
}
