#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct element {
    int state;
    char name[20];
    char code[20];
    char type[20];
    float val;
    struct element *next;
} Element;

typedef struct elt {
    int state;
    char name[20];
    char type[20];
    struct elt *next;
} Elt;

Element *tab = NULL;
Elt *tabm = NULL;
Elt *tabs = NULL;
extern char sav[20];

void initialisation() {
    // Initialisation des listes chaînées à NULL
    tab = NULL;
    tabm = NULL;
    tabs = NULL;
}

void inserer(char entite[], char code[], char type[], float val, int y) {
    switch (y) {
        case 0: {
            // Insertion dans la table des IDF et CONST
            Element *new_element = malloc(sizeof(Element));
            if (new_element == NULL) {
                fprintf(stderr, "Erreur d'allocation mémoire.\n");
                exit(EXIT_FAILURE);
            }
            new_element->state = 1;
            strcpy(new_element->name, entite);
            strcpy(new_element->code, code);
            strcpy(new_element->type, type);
            new_element->val = val;
            new_element->next = tab;
            tab = new_element;
            break;
        }

        case 1: {
            // Insertion dans la table des mots clés
            Elt *new_elt_m = malloc(sizeof(Elt));
            if (new_elt_m == NULL) {
                fprintf(stderr, "Erreur d'allocation mémoire.\n");
                exit(EXIT_FAILURE);
            }
            new_elt_m->state = 1;
            strcpy(new_elt_m->name, entite);
            strcpy(new_elt_m->type, code);
            new_elt_m->next = tabm;
            tabm = new_elt_m;
            break;
        }

        case 2: {
            // Insertion dans la table des séparateurs
            Elt *new_elt_s = malloc(sizeof(Elt));
            if (new_elt_s == NULL) {
                fprintf(stderr, "Erreur d'allocation mémoire.\n");
                exit(EXIT_FAILURE);
            }
            new_elt_s->state = 1;
            strcpy(new_elt_s->name, entite);
            strcpy(new_elt_s->type, code);
            new_elt_s->next = tabs;
            tabs = new_elt_s;
            break;
        }
    }
}

void rechercher(char entite[], char code[], char type[], float val, int y) {
    int found = 0;

    switch (y) {
        case 0: {
            // Recherche dans la table des IDF et CONST
            Element *current = tab;
            while (current != NULL) {
                if (strcmp(entite, current->name) == 0) {
                    found = 1;
                    break;
                }
                current = current->next;
            }
            if (!found) {
                inserer(entite, code, type, val, 0);
            } else {
                printf("Entité existe déjà.\n");
            }
            break;
        }

        case 1: {
            // Recherche dans la table des mots clés
            Elt *current_m = tabm;
            while (current_m != NULL) {
                if (strcmp(entite, current_m->name) == 0) {
                    found = 1;
                    break;
                }
                current_m = current_m->next;
            }
            if (!found) {
                inserer(entite, code, type, val, 1);
            } else {
                printf("Entité existe déjà.\n");
            }
            break;
        }

        case 2: {
            // Recherche dans la table des séparateurs
            Elt *current_s = tabs;
            while (current_s != NULL) {
                if (strcmp(entite, current_s->name) == 0) {
                    found = 1;
                    break;
                }
                current_s = current_s->next;
            }
            if (!found) {
                inserer(entite, code, type, val, 2);
            } else {
                printf("Entité existe déjà.\n");
            }
            break;
        }
    }
}

void afficher() {
    // Affichage de la table des symboles IDF
    printf("/***************Table des symboles IDF*************/\n");
    printf("____________________________________________________________________\n");
    printf("\t| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite\n");
    printf("____________________________________________________________________\n");

    Element *current = tab;
    while (current != NULL) {
        printf("\t|%10s |%15s | %12s | %12f\n", current->name, current->code, current->type, current->val);
        current = current->next;
    }

    // Affichage de la table des symboles mots clés
    printf("\n/***************Table des symboles mots clés*************/\n");
    printf("_____________________________________\n");
    printf("\t| NomEntite |  CodeEntite | \n");
    printf("_____________________________________\n");

    Elt *current_m = tabm;
    while (current_m != NULL) {
        printf("\t|%10s |%12s | \n", current_m->name, current_m->type);
        current_m = current_m->next;
    }

    // Affichage de la table des symboles séparateurs
    printf("\n/***************Table des symboles séparateurs*************/\n");
    printf("_____________________________________\n");
    printf("\t| NomEntite |  CodeEntite | \n");
    printf("_____________________________________\n");

    Elt *current_s = tabs;
    while (current_s != NULL) {
        printf("\t|%10s |%12s | \n", current_s->name, current_s->type);
        current_s = current_s->next;
    }
}

// Définir une fonction de recherche dans la table des symboles IDF
Element *recherche(char entite[]) {
    Element *current = tab;
    while (current != NULL) {
        if (strcmp(entite, current->name) == 0) {
            return current;
        }
        current = current->next;
    }
    return NULL;
}

// Définir une fonction pour insérer le type dans la table des symboles IDF
void insererTYPE(char entite[], char type[]) {
    Element *element = recherche(entite);
    if (element != NULL) {
        strcpy(element->type, type);
    }
}

// Définir une fonction de mise à jour dans la table des symboles IDF
void maj(char entite[], char type[]) {
    Element *current = tab;
    while (current != NULL) {
        if (strcmp(entite, current->name) == 0) {
            strcpy(current->type, type);
            break;
        }
        current = current->next;
    }
}

// Définir une fonction qui détecte la double déclaration dans la table des symboles IDF

int doubleDeclaration(char entite[]) {
    

    Element *element = recherche(entite);

    if (element != NULL) {
        // L'entité a été trouvée dans la liste chaînée, donc elle est déjà déclarée.
        if (strcmp(element->type, " ") == 0) {
            // Si le type de l'entité est vide, c'est probablement non initialisé.
            return 0;  // Non initialisée
        } else {
            return -1;  // Double déclaration détectée
        }
    }
   
       

    
}


int isDeclared(char entite[]) {
    Element *element = recherche(entite);
    return (element != NULL && element->state == 2);
}

// Définir une fonction pour comparer le type dans la table des symboles IDF

int CompType(char entite[], char type[]) {
    Element *element = recherche(entite);

    if (element != NULL) {
        if (strcmp(element->type, type) == 0) {
            return 1; // Le type est compatible
        } else {
            return 0; // Le type n'est pas compatible
        }
    } else {
        // L'entité n'a pas été trouvée dans la table des symboles IDF
        printf("Entité IDF '%s' non trouvée.\n", entite);
        return -1;
    }
}


// Une fonction pour comparer le type de deux idfs
int CompTypeIDF(char entite1[], char entite2[]) {
    Element *element1 = recherche(entite1);
    Element *element2 = recherche(entite2);
    if (element1 != NULL && element2 != NULL) {
        if (strcmp(element1->type, element2->type) == 0) {
            return 1; // Le type est compatible
        } else {
            return 0; // Le type n'est pas compatible
        }
    }
    return -1; // Entité non trouvée dans la table des symboles IDF
}


// La fonction pour récupérer le type d'un IDF
char* getType(char entite[]) {
    Element* result = recherche(entite);
    if (result != NULL) {
        return result->type;
    } else {
        return NULL; 
    }
}



// Une fonction pour vérifier si une entité est une constante
int isConstant(char entite[]) {
    Element *element = recherche(entite);
    if (element != NULL && element->state == 1 && strcmp(element->type, "const") == 0) {
        return 1; // It is a constant
    } else {
        return 0; // It is not a constant
    }
}

void getTypeOfIDF(char entite[], char resultType[]) {
    // Search for the entity in the table of IDF
    Element *current = tab;
    while (current != NULL) {
        if (strcmp(entite, current->name) == 0) {
            // Copy the type of the IDF to the resultType array
            strcpy(resultType, current->type);
            return;
        }
        current = current->next;
    }

    // Set resultType to an empty string if the entity is not found
    resultType[0] = '\0';
}


