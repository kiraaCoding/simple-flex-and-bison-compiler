%{
    int nb_ligne=1, Col=1;
    char sauvType [20];
    char AffecType [20];
    char VarType [20];
    char VarType2 [20];
    char Table [20];
    int sauvConstInt;
    int IF_Call = 0;
    char sauvIdf[20];
    int iC=0;
    int affectpossi=1;
%}

%union {
    int     entier;
    char*   str;
    float real;
}

%token mc_prog mc_routine mc_endroutine mc_call mc_dimension mc_integer mc_real mc_log mc_char
mc_str mc_read mc_write mc_if mc_else mc_finif mc_then mc_dowhile mc_enddo mc_equiv 
mc_true mc_false mc_or mc_and mc_gt mc_ge mc_eq mc_ne mc_le mc_lt mc_end <str>idf <entier>cst <real>cnst_real Div add sub mult aff
cmntr msg vrg pvrg parov parf  

%left add sub
%left mult Div
%left mc_or
%left mc_and
%start S

%%

S : LIST_func PGM
    { printf(" Le programme est correct syntaxiquement"); YYACCEPT; }
;
LIST_func: Function LIST_func
          |
;
Function: TYPE mc_routine idf parov List_par parf LIST_DEC INSTF mc_endroutine
        {
            if(doubleDeclaration($3) == 0) {insererTYPE($3,sauvType);}
            else {printf("erreur semantique a la ligne %d et la colone %d : la variable %s est deja declaree \n",nb_ligne,Col,$3);}
        }
;

INSTF:VAR aff EXP AFF_S 
    |mc_read parov idf parf pvrg INSTF
    {
        if(doubleDeclaration($3) == 0) {printf("erreur semantique a la ligne %d et la colone %d : la variable %s n'est pas declaree \n",nb_ligne,Col,$3);}
    }
    |mc_write parov somthing parf pvrg INSTF
    |mc_if parov EXPRESSION_COND parf mc_then INSTF ELSE_Cond mc_finif INSTF
    |mc_dowhile parov EXPRESSION_COND parf INSTF mc_enddo pvrg INSTF
    |mc_equiv EQV pvrg INSTF
    |
;
somthing:msg vrg idf somthing1
        |msg
;
somthing1:vrg somthing
|
;
AFF_S:pvrg INSTF
|
;
PGM :  mc_prog idf BODY mc_end
;
BODY : LIST_DEC INSTF
;

LIST_DEC: TYPE AFFL pvrg LIST_DEC
        | TYPE LIST_idf pvrg LIST_DEC
        | TYPE idf DIMM pvrg LIST_DEC
        {
        if(doubleDeclaration($2) == 0 ){insererTYPE($2,sauvType);}     
        else {printf("erreur semantique a la ligne %d et la colonne %d : la variable %s et deja declaree \n",nb_ligne,Col,$2);}    
        }
        | mc_char idf MULT pvrg LIST_DEC
        {
        if(doubleDeclaration($2) == 0 ){insererTYPE($2,"CHARACTER");}     
        else {printf("erreur semantique a la ligne %d et la colonne %d : la variable %s et deja declaree \n",nb_ligne,Col,$2);}     
        }
        |
;
AFFL:idf aff smth AFFLS
    {
        if(doubleDeclaration($1) == 0 ){insererTYPE($1,sauvType);}     
        else {printf("erreur semantique a la ligne %d et la colonne %d : la variable %s et deja declaree \n",nb_ligne,Col,$1);}      
         if(CompType($1,"INTEGER") == 0){printf("Erreur semantique a la ligne %d et la colone %d : INCOMTABILITE DE TYPE \n",nb_ligne,Col);}

    }
   
;
smth:cst
     |cnst_real
;
AFFLS:vrg AFFL
    |
;
MULT: mult cst
    {if($2 <= 0) {printf("erreur semantique a la ligne %d et la colonne %d : la taille d'une chaine de caractere doit etre superieur a 0 \n",nb_ligne,Col);}}
    | DIMM
    |
;
DIMM: mc_dimension parov cst parf
    {if($3 <= 0) {printf("erreur semantique a la ligne %d et la colonne %d : la taille d'un tableau doit etre superieur a 0 \n",nb_ligne,Col);}}
    | mc_dimension parov cst vrg cst parov
    {if(($3 <= 0) || ($5 <= 0)) {printf("erreur semantique a la ligne %d et la colonne %d : la taille d'une matrice doit etre superieur a 0 \n",nb_ligne,Col);}}
    
;
TYPE: mc_integer {strcpy(sauvType,"INTEGER");} 
     |mc_real    {strcpy(sauvType,"REAL");}
     |mc_log     {strcpy(sauvType,"LOGICAL");}
;
LIST_idf: idf vrg LIST_idf
        {
        if(doubleDeclaration($1) == 0 ) insererTYPE($1,sauvType);    
        else printf("erreur semantique a la ligne %d et la colonne %d : la variable %s et deja declaree \n",nb_ligne,Col,$1);    
        }
        | idf
        {
        if(doubleDeclaration($1) == 0 ) insererTYPE($1,sauvType); 
        else printf("erreur semantique a la ligne %d et la colonne %d : la variable %s et deja declaree \n",nb_ligne,Col,$1);      
        }
;
VAR: idf 
    {   strcpy(sauvIdf,$1) ;
        getTypeOfIDF($1, VarType);
        
        if(doubleDeclaration($1) == 0) {printf("Erreur semantique a la ligne %d et la colone %d : la variable %s n'est pas declaree",nb_ligne,Col,$1);}
    }
    | idf parov X parf
    {
        getTypeOfIDF($1, VarType);
        if(doubleDeclaration($1) == 0) {printf("Erreur semantique a la ligne %d et la colone %d : la variable %s n'est pas declaree",nb_ligne,Col,$1);}
    }
    | idf parov X vrg X parf
    {
        VarType, getType($1,VarType);
        if(doubleDeclaration($1) == 0) {printf("Erreur semantique a la ligne %d et la colone %d : la variable %s n'est pas declaree",nb_ligne,Col,$1);}
    }
;
VAR2: idf{ if (iC==1) {
        if(doubleDeclaration($1) == 0) {printf("erreur semantique a la ligne %d et la colone %d : la variable %s n'est pas declaree \n",nb_ligne,Col,$1);}
        else  {   strcpy(sauvIdf,$1) ;
        getTypeOfIDF($1, VarType2);
        if(strcmp(VarType,VarType2) != 0){printf("Erreur semantique a la ligne %d et la colone %d : INCOMTABILITE DE TYPE \n",nb_ligne,Col);}
        
        
    }
    }else
    }
    
    | idf parov X parf
     {
        if(doubleDeclaration($1) == 0) {printf("erreur semantique a la ligne %d et la colone %d : la variable %s n'est pas declaree \n",nb_ligne,Col,$1);}
        else  {   strcpy(sauvIdf,$1) ;
        getTypeOfIDF($1, VarType2);
        if(strcmp(VarType,VarType2) != 0){printf("Erreur semantique a la ligne %d et la colone %d : INCOMTABILITE DE TYPE \n",nb_ligne,Col);}

        
    }
    }
    
    | idf parov X vrg X parf
    {
        if(doubleDeclaration($1) == 0) {printf("erreur semantique a la ligne %d et la colone %d : la variable %s n'est pas declaree \n",nb_ligne,Col,$1);}
        else  {   strcpy(sauvIdf,$1) ;
        getTypeOfIDF($1, VarType2);
        if(strcmp(VarType,VarType2) != 0){printf("Erreur semantique a la ligne %d et la colone %d : INCOMTABILITE DE TYPE \n",nb_ligne,Col);}

        
    }
    }
    
;
X: VAR
  | cst
  {if($1 <= 0) {printf("erreur semantique a la ligne %d et la colonne %d : la taille d'un tableau doit etre superieur a 0 \n",nb_ligne,Col);}}
;
EXP:A
    {
        if((CompType(VarType,"REAL") == 0) && (CompType(VarType,"INTEGER") == 0)){printf("Erreur semantique a la ligne %d et la colone %d : INCOMTABILITE DE TYPE \n",nb_ligne,Col);}
    }
    | mc_call idf parov List_par parf
    {
        if(doubleDeclaration($2) == 0) {printf("erreur semantique a la ligne %d et la colone %d : la routine %s n'est pas declaree \n",nb_ligne,Col,$2);}
        else  {
                IF_Call = 1;
                getTypeOfIDF($2,AffecType);
                if(strcmp(VarType,AffecType) != 0){printf("Erreur semantique a la ligne %d et la colone %d : INCOMTABILITE DE TYPE \n",nb_ligne,Col);}
                }
    }
    | LOG 
    {
        if(CompType(VarType,"LOGICAL") == 0){printf("Erreur semantique a la ligne %d et la colone %d : INCOMTABILITE DE TYPE \n",nb_ligne,Col);}
    }
    | msg
    {
        if(CompType(VarType,"CHARACTER") == 0){printf("Erreur semantique a la ligne %d et la colone %d : INCOMTABILITE DE TYPE \n",nb_ligne,Col);}
    }
;
A:A add B
 | A sub B
 | B
;
B: B mult C
   | B Div C
   {
    if (sauvConstInt == 0){printf("Erreur semantique a la ligne %d et la colone %d : division par 0 \n",nb_ligne,Col);}
   }
   | C
;
C: parov A {iC++;} parf
 | VAR2 
 | cst {sauvConstInt = $1;}
;
LOG: mc_true 
    | mc_false 
;
List_par: idf List_parr
        {
            if(IF_Call == 1){
                if(doubleDeclaration($1) == 0) {printf("erreur semantique a la ligne %d et la colone %d : la variable %s n'est pas declaree \n",nb_ligne,Col,$1);}
            }
        }
        |
;
List_parr:vrg idf List_parr
         {
            if(IF_Call == 1){
                if(doubleDeclaration($1) == 0) {printf("erreur semantique a la ligne %d et la colone %d : la variable %s n'est pas declaree \n",nb_ligne,Col,$1);}
            }
        }
        |
;
ELSE_Cond: mc_else INSTF
        |
;
EXPRESSION_COND:EXPRESSION_COND  mc_or EXPAND
                |EXPAND
;
EXPAND:EXPAND mc_and PE
        | PE 
;
PE: parov EXPRESSION_COND parf
    | A EXP_COMP A
    | A CMPL LOG 
;

CMPL:mc_eq
    |mc_ne
;
EXP_COMP:  mc_gt 
         | mc_ge 
         | mc_lt 
         | mc_le 
         | mc_ne 
         | mc_eq 
;
EQV: parov VAR vrg IDFLEQ parf vrg EQV
    | parov VAR vrg IDFLEQ parf
;
IDFLEQ: VAR vrg IDFLEQ
        | VAR 
;

%%

main ()
{
    initialisation();
    yyparse(); 
    afficher();
}

yywrap ()
{}

int yyerror ( char* msg )  
{
    printf ("Erreur Syntaxique a ligne %d a colonne %d \n", nb_ligne,Col);
}