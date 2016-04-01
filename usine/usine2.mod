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

{string} codeTaches = { t.code | t in taches}; // code de chaque tache
Tache ct[codeTaches] = [ tt.code : tt | tt in taches ];   // indexage de chaque tache par code
int dureeTaches[codeTaches] = [ t.code : t.duree | t in taches ];   // duree de chaque tache
int sommeDuree = sum (t in taches) t.duree;       // duree du chantier si les taches sont executes les unes a la suite de autres.
int minDuree = min (t in taches) t.duree;         // Duree minimale parmi toutes les taches


//----------------------- Modèle ---------------------------

// -- variables de décisions --
dvar interval t[tt in codeTaches] in 0..sommeDuree size ct[tt].duree; // t["A"] = 0..5 debute a 0 et finit a 5.

// -- Critère d'optimisation --
dvar int finChantier in 1..sommeDuree; 

minimize 
   finChantier;

subject to {   		

	forall (c in cords) {
		endBeforeStart(t[c.avant], t[c.apres]);		
	}	

	finChantier == max(tt in codeTaches) endOf(t[tt]);
    
}	


//----------------------- Affichage Solution ---------------------------

execute {
	writeln("La fin du chantier est après : " , finChantier, " jours");
	for (c in codeTaches) {
		writeln("Tache " , c, " == debut : ", t[c].start, " -- fin : ", t[c].end);
		// ou Opl.startOf(t[c]) -- Opl.endOf(t[c])
	}	
}
