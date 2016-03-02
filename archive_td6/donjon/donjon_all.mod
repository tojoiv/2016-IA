/*********************************************
Modèle simple permettant de trouver une solution
*********************************************/
using CP;

//----- Parametrage Solveur -----
/* Paramétrage du solveur */
execute {
  cp.param.searchType = "DepthFirst";
  cp.param.workers =1;
}

//----- Données du problème -----
range d = 0..12;
 
//----- Variables et domaines -----
{string} pointsCardinaux = {"Nord", "Sud", "Ouest", "Est", "Nord-Est", "Nord-Ouest", "Sud-Est", "Sud-Ouest"};
dvar int nb[pointsCardinaux] in d;

//----- Contraintes -----
constraints {

	// 12 soldats montent la garde
	nb["Nord"]+nb["Sud"]+nb["Ouest"]+nb["Est"]+nb["Nord-Est"]+nb["Nord-Ouest"]+nb["Sud-Est"]+nb["Sud-Ouest"] == 12;

	// au moins 5 paires d'yeux
	nb["Nord"]+nb["Nord-Est"]+nb["Nord-Ouest"] >= 5;
	nb["Sud"]+nb["Sud-Est"]+nb["Sud-Ouest"] >= 5;
	nb["Ouest"]+nb["Nord-Ouest"]+nb["Sud-Ouest"] >= 5;
	nb["Est"]+nb["Nord-Est"]+nb["Sud-Est"] >= 5;
}

/* Post-traitement (Affichage Solution) */
execute {

	writeln(nb["Nord-Ouest"], "-", nb["Nord"], "-", nb["Nord-Est"]);
	writeln(nb["Ouest"],"---", nb["Est"]);
	writeln(nb["Sud-Ouest"], "-", nb["Sud"], "-", nb["Sud-Est"]);
	
  /* for (var i in pointsCardinaux) {
    writeln(i, " = ", nb[i]);
  } */
}

main {
	thisOplModel.generate();
	cp.startNewSearch();
	solutions = 0;
	while (cp.next()) {
		thisOplModel.postProcess();
		solutions++;
	}

	writeln("===== NB SOLUTIONS = ", solutions);
}
