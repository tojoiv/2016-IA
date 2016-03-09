/*********************************************
 * Modèle pour le problème du zebre (Lewis Caroll)
 *
 * Ce modèle calcule toutes les solutions du problème
 *********************************************/
using CP;

//----- Parametrage Solveur -----
execute {
  cp.param.searchType = "DepthFirst";
  cp.param.workers =1;
}

/*** Données du problème  ***/
range d = 1..5;

{string} boissons = {"Thé", "Café", "Lait", "JusFruit", "Eau"};
{string} nationalites = {"Anglais", "Espagnol", "Japonais", "Italien", "Norvégien"};
{string} metiers = {"Peintre", "Sculpteur", "Diplomate", "Violoniste", "Médecin"};
{string} couleurs = {"Rouge", "Vert", "Blanc", "Jaune", "Bleu"};
{string} animaux = {"Chien", "Escargot", "Renard", "Cheval", "Zebre" };

{string} donnees = boissons union nationalites union metiers union couleurs union animaux;
 
/*** Variables et domaines  ***/
dvar int maison[donnees] in d;

/*** Contraintes  ***/
constraints {
  // 1. L'anglais habite la maison rouge
  maison["Rouge"] == maison["Anglais"];

  // 2. L'espagnol possède un chien.
  maison["Espagnol"] == maison["Chien"];

  // 3. Le japonais est peintre.
  maison["Japonais"] == maison["Peintre"];

  // 4. L'italien boit du thé.
  maison["Italien"] == maison["Thé"];

  // 5. Le norvégien habite la première maison à gauche.
  maison["Norvégien"] == 1;

  // 6. Le propriétaire de la maison verte boit du café.
    maison["Vert"] == maison["Café"];

  // 7. La maison verte est à droite de la blanche.
      maison["Vert"] == maison["Blanc"]+1;

  // 8. Le sculpteur élève des escargots.
  maison["Sculpteur"] == maison["Escargot"];

  // 9. Le diplomate habite la maison jaune.
  maison["Diplomate"] == maison["Jaune"];

  // 10. On boit du lait dans la maison du milieu.
  maison["Lait"] == 3;

  // 11. Le norvégien habite à coté de la maison bleue.
  maison["Norvégien"] == maison["Bleu"] + 1 || maison["Norvégien"] == maison["Bleu"] - 1;

  // 12. Le violoniste boit des jus de fruits. 
  maison["Violoniste"] == maison["JusFruit"];

  // 13. Le renard est dans la maison voisine du médecin.
  maison["Renard"] == maison["Médecin"] + 1 || maison["Renard"] == maison["Médecin"] - 1;

  // 14. Le cheval est à coté de celle du diplomate.
  maison["Cheval"] == maison["Diplomate"] + 1 || maison["Cheval"] == maison["Diplomate"] - 1;

  // Contraintes de différence
  forall (i, j in boissons : i != j) {
    maison[i] != maison[j];
  }

  forall (i, j in nationalites : i != j) {
    maison[i] != maison[j];
  }

  forall (i, j in metiers : i != j) {
    maison[i] != maison[j];
  } 

  forall (i, j in couleurs : i != j) {
    maison[i] != maison[j];
  } 

  forall (i, j in animaux : i != j) {
    maison[i] != maison[j];
  }
}

/* Post-traitement (Affichage Solution) */
execute {
  for (var i in d) {
    write("Maison ", i, " = ");
    for (var j in donnees) {
	if (maison[j] == i) write(" ", j);
    }
    writeln("");
  }
}

include "../../all_solutions.mod";
