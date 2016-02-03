/*********************************************
 * Modèle OPL Pour le problème des billes
 *
 * Utiliser un ou plusieurs tableau pour regrouper les variables 
 * dans des structures adéquates, permettant de simplifier 
 * l'énoncé de certaines contraintes ainsi que l'affichage de la solution.
 *********************************************/
using CP;			/* Utilisation du solveur CP-Solver */

/* Déclarations domaines et variables */
range d = 4..7;

{string} prenoms = {"Anne", "Bernard", "Claudine", "Denis"};
{string} couleurs = { "Bleue", "Jaune", "Noire", "Rouge"};
{string} lieux = {"Parc", "Chambre", "Jardin", "Salon"};
{string} vars = prenoms union couleurs union lieux;
dvar int age[vars] in d;

/* Paramétrage du solveur */
execute {
  cp.param.searchType = "DepthFirst";
  cp.param.workers =1;
}

/* Contraintes */
constraints {
  // Denis joue dans le Parc et n'a pas 4 ans, contrairement à l'enfant qui a des billes bleues.
  age["Denis"] != 4;
  age["Bleue"] == 4;
  age["Denis"] == age["Parc"];

    // La fille de 6 ans a des billes jaunes.
age["Jaune"] == 6;
  // Claudine == Jaune || Anne == Jaune;
  age["Bernard"] != 6;
  age["Denis"] != 6;

  //  L’enfant qui joue avec des billes noires est plus âgé que l’enfant qui joue dans le jardin mais plus jeune que Anne.
  age["Noire"] > age["Jardin"];
  age["Noire"] < age["Anne"];

  // Anne, qui joue dans sa chambre, a 1 an de plus que l’enfant qui joue dans le salon.
  age["Anne"] == age["Chambre"];
  age["Anne"] == age["Salon"] + 1;

  // Contraintes de différence
  forall (i, j in prenoms : i != j) {
    age[i] != age[j];
  }

  forall (i, j in couleurs : i != j) {
    age[i] != age[j];
  }

  forall (i, j in lieux : i != j) {
    age[i] != age[j];
  }
}


/* Post-traitement (Affichage Solution) */
execute {
  for (var i in vars) {
    writeln(i, " = ", age[i]);
  }
}
