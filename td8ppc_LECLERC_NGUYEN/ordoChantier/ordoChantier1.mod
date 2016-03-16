/***********************************************
*  LECLERC - NGUYEN
************************************************/
using CP;


//------------------- Données ------------------- 
// TODO
tuple Tache {
	string code;
	string nom;
	int duree;
	{string} avant;
}

{Tache}   TachesChantier = ...;

//---------------- Prétraitement ---------------- 

execute {
	cp.param.logVerbosity = "Quiet";
}

// Extraction des informations utiles à partir des données brutes décrivant l'instance

// ensemble contenant les codes de chaque tache 
{string} codeTaches = {t.code | t in TachesChantier}; 

//---------------- Variables et domaines ---------------- 

int dureeTaches[codeTaches] = [ t.code : t.duree | t in TachesChantier ];

// Duree totale du chantier
int sommeDuree = sum (t in TachesChantier) t.duree;

// Duree minimale parmi toutes les taches
int minDuree = min (t in TachesChantier) t.duree;

// Moment ou le chantier fini
dvar int finChantier in 1..sommeDuree; 

// Les taches debutent a l'instance 0 jusqu'a la fin du chantier maximale - la duree minimal des taches
dvar int debutTaches[codeTaches] in 0..(sommeDuree-minDuree);
dvar int finTaches[codeTaches] in minDuree..sommeDuree;



//---------------- Objectif et Contraintes ---------------- 
minimize 
	finChantier;

subject to {
	forall (t in TachesChantier) {
		finTaches[t.code] == debutTaches[t.code] + t.duree;

		forall (ta in t.avant) {
			debutTaches[t.code] >= debutTaches[ta]+dureeTaches[ta];
		}	
	}

	finChantier == max(i in codeTaches) finTaches[i];
	
}



/*********** Post-traitement ***********/
execute {
	writeln("La fin du chantier est après : " , finChantier, " jours");
}


