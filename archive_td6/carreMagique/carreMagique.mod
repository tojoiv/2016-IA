/*********************************************
 * Modèle pour le problème du carré magique
 *
 * Les données de l'instance sont décrites dans un fichier .dat externe
 *********************************************/
using CP;

//----- Parametrage Solveur -----
execute {
	cp.param.searchType = "DepthFirst";
	cp.param.workers = 1;
	cp.param.logVerbosity = "Quiet";	
}

//----- Données du problème -----
// Carré Magique n x n
int n = ...;
range d = 1..n;
range nombre = 1..n*n;
 
//----- Variables et domaines -----
dvar int carre[d,d] in nombre;
dvar int somme in (1+2+3+4)..((n-3)+(n-2)+(n-1)+n);

//----- Contraintes -----
constraints {

	forall(i in d) {		
	

		(sum(j in d) carre[i][j]) == somme;
		(sum(j in d) carre[j][i]) == somme;
		(sum(j in d) carre[j][j]) == somme;
		
		
	}

}

//----- Post-traitement -----

execute {
	writeln(carre);
	writeln("SOMME =", somme);
}

