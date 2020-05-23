/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    tMAIN = 258,
    tPRINTF = 259,
    tINT = 260,
    tVOID = 261,
    tRETURN = 262,
    tCONST = 263,
    tIF = 264,
    tELSE = 265,
    tWHILE = 266,
    tVAR_NAME = 267,
    tINT_VAL = 268,
    tOPEN_BRACE = 269,
    tCLOSE_BRACE = 270,
    tPLUS = 271,
    tMINUS = 272,
    tMUL = 273,
    tSLASH = 274,
    tAFFECT = 275,
    tOPEN_PAR = 276,
    tCLOSE_PAR = 277,
    tCOMA = 278,
    tEND = 279
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tPRINTF 259
#define tINT 260
#define tVOID 261
#define tRETURN 262
#define tCONST 263
#define tIF 264
#define tELSE 265
#define tWHILE 266
#define tVAR_NAME 267
#define tINT_VAL 268
#define tOPEN_BRACE 269
#define tCLOSE_BRACE 270
#define tPLUS 271
#define tMINUS 272
#define tMUL 273
#define tSLASH 274
#define tAFFECT 275
#define tOPEN_PAR 276
#define tCLOSE_PAR 277
#define tCOMA 278
#define tEND 279

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 78 "spark.y" /* yacc.c:1909  */

    int nb;
    char *str;

#line 107 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
