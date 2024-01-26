
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     mc_prog = 258,
     mc_routine = 259,
     mc_endroutine = 260,
     mc_call = 261,
     mc_dimension = 262,
     mc_integer = 263,
     mc_real = 264,
     mc_log = 265,
     mc_char = 266,
     mc_str = 267,
     mc_read = 268,
     mc_write = 269,
     mc_if = 270,
     mc_else = 271,
     mc_finif = 272,
     mc_then = 273,
     mc_dowhile = 274,
     mc_enddo = 275,
     mc_equiv = 276,
     mc_true = 277,
     mc_false = 278,
     mc_or = 279,
     mc_and = 280,
     mc_gt = 281,
     mc_ge = 282,
     mc_eq = 283,
     mc_ne = 284,
     mc_le = 285,
     mc_lt = 286,
     mc_end = 287,
     idf = 288,
     cst = 289,
     cnst_real = 290,
     Div = 291,
     add = 292,
     sub = 293,
     mult = 294,
     aff = 295,
     cmntr = 296,
     msg = 297,
     vrg = 298,
     pvrg = 299,
     parov = 300,
     parf = 301
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 15 "syntaa2.y"

    int     entier;
    char*   str;
    float real;



/* Line 1676 of yacc.c  */
#line 106 "syntaa2.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


