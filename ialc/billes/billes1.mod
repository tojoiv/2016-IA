/*********************************************
 * Modèle OPL Pour le problème des billes
 *
 * Dans ce modèle chaque variable est déclarée explicitement
 * avec son nom d'origine dans le modèle initial
 *********************************************/
using CP;			/* Utilisation du solveur CP-Solver */


/* Déclarations domaines et variables */
range d = 4..7;

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
execute {
  cp.param.searchType = "DepthFirst";
  cp.param.workers =1;
}


/* Contraintes */
constraints {
  // Denis joue dans le Parc et n'a pas 4 ans, contrairement à l'enfant qui a des billes bleues.
  Denis != 4;
  Bleue == 4;
  Denis == Parc;

    // La fille de 6 ans a des billes jaunes.
Jaune == 6;
  // Claudine == Jaune || Anne == Jaune;
  Bernard != 6;
  Denis != 6;

  //  L’enfant qui joue avec des billes noires est plus âgé que l’enfant qui joue dans le jardin mais plus jeune que Anne.
  Noire > Jardin;
  Noire < Anne;

  // Anne, qui joue dans sa chambre, a 1 an de plus que l’enfant qui joue dans le salon.
  Anne == Chambre;
  Anne == Salon + 1;
 
  Anne != Bernard;
  Anne != Claudine;
  Anne != Denis;
  Bernard != Claudine;
  Bernard != Denis;
  Claudine != Denis;

  Bleue != Jaune;
  Bleue != Noire;
  Bleue != Rouge;
  Jaune != Noire;
  Jaune != Rouge;
  Noire != Rouge;

  Parc != Chambre;
  Parc != Jardin;
  Parc != Salon;
  Chambre != Jardin;
  Chambre != Salon;
  Jardin != Salon;
}

/* Post-traitement (Affichage Solution) */
execute {
  writeln( "Anne = ", Anne);
  writeln( "Bernard = ", Bernard);
  writeln( "Claudine = ", Claudine);
  writeln( "Denis = ", Denis);

  writeln( "Billes Bleues = ", Bleue);
  writeln( "Billes Jaunes = ", Jaune);
  writeln( "Billes Noires = ", Noire);
  writeln( "Billes Rouges = ", Rouge);

  writeln( "Parc = ", Parc);
  writeln( "Chambre = ", Chambre);
  writeln( "Jardin = ", Jardin);
  writeln( "Salon = ", Salon);


}
