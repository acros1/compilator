%{
    int yydebug = 1;
    #include <stdio.h>
    #include <stdlib.h>

    extern int yylex();

    int yyerror(char* s)  {
        printf("yyerror");
        exit(1);
        return 1;
    }
%}

%token  tMAIN 
        tPRINTF
        tINT
        tVOID
        tRETURN
        tCONST 
        tVAR_NAME 
        tINT_VAL 
        tOPEN_BRACE 
        tCLOSE_BRACE 
        tPLUS 
        tMINUS 
        tMUL
        tSLASH 
        tAFFECT 
        tOPEN_PAR 
        tCLOSE_PAR 
        tCOMA 
        tEND

%right tAFFECT
%left tPLUS tMINUS
%left tMUL tSLASH

%%

PROGRAM:
        tVOID tMAIN tOPEN_PAR ARG_LIST tCLOSE_PAR tOPEN_BRACE BODY tCLOSE_BRACE { printf("PROGRAM\n"); }
    ;

ARG_LIST: 
        /* void */ { printf("ARG_LIST\n"); }
    |   tINT tVAR_NAME tCOMA ARG_LIST { printf("ARG_LIST\n"); }
    ;

BODY: 
        DECLARATION_BLOCK INSTRUCTION_BLOCK { printf("BODY\n"); }
    ;

/*-----------------------------------DECLARATIONS-----------------------------------*/

DECLARATION_BLOCK:
        /* void */ { printf("DECLARATION_BLOCK\n"); }
    |   DECLARATION_LINE DECLARATION_BLOCK { printf("DECLARATION_BLOCK\n"); }
    ;

DECLARATION_LINE:
        VAR_DECLARATION_LINE { printf("DECLARATION_LINE\n"); }
    |   CONST_DECLARATION_LINE { printf("DECLARATION_LINE\n"); }
    ;

VAR_DECLARATION_LINE:
        tINT VAR_DECLARATION_LIST tEND { printf("VAR_DECLARATION_LINE\n"); }
    ;

CONST_DECLARATION_LINE:
        tCONST CONST_DECLARATION_LIST tEND { printf("CONST_DECLARATION_LINE\n"); }
    ;

VAR_DECLARATION_LIST:
        VAR_DECLARATION { printf("VAR_DECLARATION_LIST\n"); }
    |   VAR_DECLARATION tCOMA VAR_DECLARATION_LIST { printf("VAR_DECLARATION_LIST\n"); }
    ;

CONST_DECLARATION_LIST:
        CONST_DECLARATION { printf("CONST_DECLARATION_LIST\n"); }
    |   CONST_DECLARATION tCOMA CONST_DECLARATION_LIST { printf("CONST_DECLARATION_LIST\n"); }
    ;

VAR_DECLARATION:
        tVAR_NAME { printf("VAR_DECLARATION\n"); }
    |   tVAR_NAME tAFFECT tINT_VAL { printf("VAR_DECLARATION_VALUE\n"); }
    ;

CONST_DECLARATION:
        tVAR_NAME tAFFECT tINT_VAL { printf("CONST_DECLARATION\n"); }
    ;

/*-----------------------------------INSTRUCTIONS-----------------------------------*/

INSTRUCTION_BLOCK:
        /* void */ { printf("INSTRUCTION_BLOCK\n"); }
    |   INSTRUCTION_LINE INSTRUCTION_BLOCK { printf("INSTRUCTION_BLOCK\n"); }
    ;

INSTRUCTION_LINE:
        AFFECT tEND { printf("INSTRUCTION_LINE\n"); }
    |   PRINT tEND { printf("INSTRUCTION_LINE\n"); }
    |   RETURN tEND { printf("INSTRUCTION_LINE\n"); }
    ;

AFFECT:
        tVAR_NAME tAFFECT EXPRESSION { printf("AFFECT\n"); }
    ;

PRINT:
        tPRINTF tOPEN_PAR EXPRESSION tCLOSE_PAR { printf("PRINT\n"); }
    ;

RETURN:
        tRETURN EXPRESSION { printf("RETURN\n"); }
    ;

EXPRESSION:
        tINT_VAL { printf("EXPRESSION\n"); }
    |   tVAR_NAME { printf("EXPRESSION\n"); }
    |   EXPRESSION tMUL EXPRESSION { printf("EXPRESSION\n"); }
    |   EXPRESSION tSLASH EXPRESSION { printf("EXPRESSION\n"); }
    |   EXPRESSION tPLUS EXPRESSION { printf("add $1, $3\n"); }
    |   EXPRESSION tMINUS EXPRESSION { printf("EXPRESSION\n"); }
    |   tMINUS EXPRESSION %prec tMUL { printf("EXPRESSION\n"); }
    |   tOPEN_PAR EXPRESSION tCLOSE_PAR { printf("EXPRESSION\n"); }
    ;

%%

int main() {
    yyparse();
}