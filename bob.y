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
        tPLUS tMINUS 
        tMUL
        tSLASH 
        tAFFECT 
        tOPEN_PAR 
        tCLOSE_PAR 
        tCOMA 
        tEND

%%

PROGRAMME:
        tVOID tMAIN tOPEN_PAR ARG_LIST tCLOSE_PAR tOPEN_BRACE BODY tCLOSE_BRACE { printf("main found\n"); }
    ;

ARG_LIST: 
        /* void */ { printf("no arg in main\n"); }
    |   tINT tVAR_NAME tCOMA ARG_LIST { printf("arg found in main\n"); }
    ;

BODY: 
        DECLARATION_BLOCK INSTRUCTION_BLOCK
    ;

/*-----------------------------------DECLARATIONS-----------------------------------*/

DECLARATION_BLOCK:
        /* void */ { printf("no declaration\n"); }
    |   DECLARATION_LINE DECLARATION_BLOCK
    ;

DECLARATION_LINE:
        VAR_DECLARATION_LINE { printf("var declaration line found\n"); }
    |   CONST_DECLARATION_LINE { printf("const declaration line found\n"); }
    ;

VAR_DECLARATION_LINE:
        tINT VAR_DECLARATION_LIST tEND { printf("int found\n"); }
    ;

CONST_DECLARATION_LINE:
        tCONST CONST_DECLARATION_LIST tEND { printf("const found\n"); }
    ;

VAR_DECLARATION_LIST:
        VAR_DECLARATION { printf("int declaration\n"); }
    |   VAR_DECLARATION tCOMA VAR_DECLARATION_LIST { printf("int declaration + list\n"); }
    ;

CONST_DECLARATION_LIST:
        CONST_DECLARATION { printf("const declaration\n"); }
    |   CONST_DECLARATION tCOMA CONST_DECLARATION_LIST { printf("const declaration + list\n"); }
    ;

VAR_DECLARATION:
        tVAR_NAME { printf("int without value\n"); }
    |   tVAR_NAME tAFFECT tINT_VAL { printf("int with value\n"); }
    ;

CONST_DECLARATION:
        tVAR_NAME tAFFECT tINT_VAL { printf("const with value\n"); }
    ;

/*-----------------------------------INSTRUCTIONS-----------------------------------*/

INSTRUCTION_BLOCK:
        /* void */ { printf("no instruction\n"); }
    |   INSTRUCTION_LINE INSTRUCTION_BLOCK { printf("instruction found\n"); }
    ;

INSTRUCTION_LINE:
        AFFECT tEND { printf("affect instruction\n"); }
    |   PRINT tEND { printf("print instruction\n"); }
    |   RETURN tEND { printf("return instruction\n"); }
    ;

AFFECT:
        tVAR_NAME tAFFECT EXPRESSION { printf("affect instruction with expression\n"); }
    ;

PRINT:
        tPRINTF tOPEN_PAR EXPRESSION tCLOSE_PAR { printf("printf instruction with expression\n"); }
    ;

RETURN:
        tRETURN EXPRESSION { printf("return instruction with expression\n"); }
    ;

EXPRESSION:
        tINT_VAL { printf("int affect\n"); }
    |   tVAR_NAME { printf("VAR_NAME affect\n"); }
    |   tOPEN_PAR EXPRESSION tMUL EXPRESSION tCLOSE_PAR { printf("mul\n"); }
    |   tOPEN_PAR EXPRESSION tSLASH EXPRESSION tCLOSE_PAR { printf("divide\n"); }
    |   tOPEN_PAR EXPRESSION tPLUS EXPRESSION tCLOSE_PAR { printf("plus\n"); }
    |   tOPEN_PAR EXPRESSION tMINUS EXPRESSION tCLOSE_PAR { printf("minus\n"); }
    ;

%%

int main() {
    yyparse();
}