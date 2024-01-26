%{
   extern nb_ligne;
   extern Col;
   #include "syntaa2.tab.h"
    #include "TSProj2.h"
	extern YYSTYPE yylval;
%}
lettre [a-zA-Z]
chiffre[0-9]
cnst_real ({chiffre}+)("."({chiffre}*))
IDF{lettre}({lettre}|{chiffre})*
cst{chiffre}+

msg \"[^\"]*\"
%%
PROGRAM { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_prog;  }
ROUTINE { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_routine;  }
ENDR { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_endroutine;  }
CALL { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_call;  }
DIMENSION { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_dimension;  }
INTEGER   { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_integer; }
REAL      { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_real; }
LOGICAL      { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_log; }
CHARACTER      { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_char; }
STRING    { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_str; }
READ    { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_read; }
WRITE    { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_write; }
IF { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_if; }
ELSE { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_else; }
ENDIF { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_finif; }
THEN { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_then; }
DOWHILE { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_dowhile; }
ENDDO { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_enddo; }
EQUIVALENCE { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_equiv; }
.OR. { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_or; }
.AND. { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_and; }
.GT. { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_gt; }
.GE. { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_ge; }
.EQ. { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_eq; }
.NE. { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_ne; }
.LE. { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_le; }
.LT. { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_lt; }
TRUE { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_true; }
FALSE { rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_false; }
END.		{ rechercher(yytext,"Mot cle",0,0, 1); Col= Col + strlen(yytext); printf (" L entite lexicale reconnue est %s \n", yytext); return mc_end;  }

{IDF}     { 
              yylval.str=strdup(yytext);
			  rechercher(yytext,"IDF"," ",0,0);

              Col= Col + strlen(yytext);
			  if (yyleng>10) printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n ",nb_ligne, Col);
              printf (" L entite lexicale reconnue est %s \n", yytext); 
			  return idf;
			  
		  }
{cst}     { 
              yylval.entier=atoi(yytext);
              rechercher(yytext,"Cst entiere","INTEGER",atof(yytext),0); 
			  Col= Col + strlen(yytext); 
			  if (yylval.entier > -32768 && yylval.entier < 32767){
				printf (" L entite lexicale reconnue est %s \n", yytext);
				return cst;
			  }else{
				printf("Erreur lexicale : la constante depasse la plage des valeurs a la ligne %d a la colonne %d  \n",nb_ligne, Col);
			  }
			  
		  }
{cnst_real}     { 

              rechercher(yytext,"cnst_real","REAL",atof(yytext),0); 
			  Col= Col + strlen(yytext);
              if (atoi(yytext) > -32768.32768 && atoi(yytext) < 32767.32768) {
			  printf (" L entite lexicale reconnue est %s \n", yytext);
			  return cnst_real;}
			  else {
					printf("Erreur lexicale : la constante depasse la plage des valeurs a la ligne %d \n",nb_ligne);
					}		
		  }	

{msg} {return msg;Col=Col+yyleng;}
"/"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return Div;}
"+"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return add;}
"-"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return sub;}
"*"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext);return mult;}
"="       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return aff; }
"%"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return cmntr;}
","       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return vrg;}
";"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return pvrg;}
"("       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return parov;}
")"       { rechercher(yytext,"Mot cle",0,0,2); Col= Col + strlen(yytext); return parf;}

[ \t]     Col= Col + strlen(yytext);
\n        {Col= 1; nb_ligne++;} 
%[^\n]*   {printf("cmnt\n");}
. printf ("Entité lexicale non reconnue a ligne %d a la colonne %d \n", nb_ligne, Col);
