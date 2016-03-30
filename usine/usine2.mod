using CP;

// ----- Structures de données pour décrire une instance de problème -----

// Modélisation des informations caractérisant une tâche
tuple Tache{
    string code;		// le code de la tache
    int duree;		    // la duree de la tache
    int puissance;		// la puissance consommee par la tache
}

// Modélisation des contraintes d'ordonnancement à respecter
tuple Ord{
   string avant;		// le code de la tache qui doit se derouler en premier
   string apres;		// le code de la tache qui doit se derouler en second 	
}

//----------------------- Données ---------------------------
Tache} taches = ...;        // les taches du probleme
{Ord}   cords = ...;       // les contraintes d'ordonnancement entre taches
int	  puissanceMax = ...;   // la puissance maximale de l'usine

//----------------------- Pretraitement ---------------------------
	    
// A compléter si nécessaire

//----------------------- Modèle ---------------------------

// -- variables de décisions --

// -- variables de commodité --

// -- Critère d'optimisation --


minimize 
   // Objectif - A completer
subject to {
    // Contraintes - A completer
    
}	


//----------------------- Affichage Solution ---------------------------

execute {
    
}