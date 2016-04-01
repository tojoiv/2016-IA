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
{Tache} taches = ...;        // les taches du probleme
{Ord}   cords = ...;       // les contraintes d'ordonnancement entre taches
int	puissanceMax = ...;   // la puissance maximale de l'usine

//----------------------- Pretraitement ---------------------------
	    
execute {
	cp.param.logVerbosity = "Quiet";
}

{string} codeTaches = {t.code | t in taches};

int dureeTaches[codeTaches] = [ t.code : t.duree | t in taches ];   // code de chaque tache
int sommeDuree = sum (t in taches) t.duree;       // duree du chantier si les taches sont executes les unes a la suite de autres.
int minDuree = min (t in taches) t.duree;         // Duree minimale parmi toutes les taches

//----------------------- Modèle ---------------------------

// -- variables de décisions --
// Les taches debutent a l'instance 0 jusqu'a la fin du chantier maximale - la duree minimal des taches
dvar int debutTaches[codeTaches] in 0..(sommeDuree-minDuree); // debutTaches["A"] = 3 signifie que la tache A commence a 3.

// -- variables de commodité --
dvar int finTaches[codeTaches] in minDuree..sommeDuree; // finTaches["C"] = 7 signifie que la tache C finit a 7.

// -- Critère d'optimisation --
dvar int finChantier in 1..sommeDuree; 


minimize 
   finChantier;

subject to {
    forall (t in taches) {
		finTaches[t.code] == debutTaches[t.code] + t.duree;

		forall (c in cords) {
			finTaches[c.avant] <= debutTaches[c.apres];
		}	
	}

	finChantier == max(i in codeTaches) finTaches[i];
    
}	


//----------------------- Affichage Solution ---------------------------

execute {
	writeln("La fin du chantier est après : " , finChantier, " jours");
	for (i in codeTaches) {
		writeln("Tache " , i, " == debut : ", debutTaches[i], " -- fin : ", finTaches[i]);
	}	
}
