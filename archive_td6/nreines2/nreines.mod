/*********************************************
 * Modèle pour le problème des n-reines
 *
 * Les données de l'instance sont décrites dans un fichier .dat externe
 *********************************************/
using CP;

//----- Parametrage Solveur -----
/* Paramétrage du solveur */
execute {
  cp.param.searchType = "DepthFirst";
  cp.param.workers =1;

  var f = cp.factory;
  cp.setSearchPhases(reines, f.selectSmallest(f.value()));
}

//----- Données du problème -----
int n = ... ;
 
//----- Variables et domaines -----
range d = 1..n;
dvar int reines[d] in d;

//----- Contraintes -----
constraints {

  forall (i, j in d : i < j) {
    reines[i] != reines[j];
    abs(reines[i]-reines[j]) != abs(i-j);
  }

}

/* Post-traitement (Affichage Solution) */
execute {
	
  for (var i in d) {
    writeln("Ligne", i, " = Colonne", reines[i]);
  } 
}

