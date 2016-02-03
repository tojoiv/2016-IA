/*********************************************
 * Modèle OPL Pour le problème des billes
 *
 * Dans ce modèle chaque variable est déclarée explicitement
 * avec son nom d'origine dans le modèle initial
 *********************************************/
using CP;			/* Utilisation du solveur CP-Solver */


/* Déclarations domaines et variables */
int d = 4..7;

dvar int Anne in d;
dvar int Bernard in d;
dvar int Claudine in d;
dvar int Denis in d;

dvar int Bleue in d;
dvar int Jaune in d;
dvar int Noire in d;
dvar int Rouge in d;

dvar int Parc in d;
dvar int Chambre in d;
dvar int Jardin in d; 
dvar int Salon in d;

/* Paramétrage du solveur */
// TODO 


/* Contraintes */
// TODO 


/* Post-traitement (Affichage Solution) */
// TODO 

