%{
    int yydebug = 1;
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #define SYMBOL_ARRAY_SIZE 256
    #define INSTRUCTION_ARRAY_SIZE 256

    extern int yylex();

    int yyerror(char* s)  {
        printf("yyerror");
        exit(1);
        return 1;
    }

    // Symbol array

    typedef struct {
        int type; // 0 = const | 1 = var
        char *name;
    } symbol;

    symbol symbol_array[SYMBOL_ARRAY_SIZE];

    int next_symbol_index = 0;

    int find_symbol(char *name) {
        for (int i = 0 ; i < next_symbol_index ; i++) {
            if (strcmp(name, symbol_array[i].name) == 0) {
                return i;
            }
        }
        printf("%s not found in symbol array\n", name);
        exit(1);        
    }

    // Instruction buffer

    typedef struct {
        char opCode[4]; // each opCode is 3 char size + \0
        int op1;
        int op2; // -1 if op2 is not used 
        int op3; // -1 if op3 is not used 
    } instruction;

    instruction instruction_array[INSTRUCTION_ARRAY_SIZE];

    int next_instruction_index = 0;

    void put_instruction3(char* opCode, int op1, int op2, int op3) {
        instruction* i = &instruction_array[next_instruction_index++];
        strncpy(i->opCode, opCode, 4);
        i->op1 = op1;
        i->op2 = op2;
        i->op3 = op3;
    }

    void put_instruction2(char* opCode, int op1, int op2) {
        put_instruction3(opCode, op1, op2, -1);
    }

    void put_instruction1(char* opCode, int op1) {
        put_instruction3(opCode, op1, -1, -1);
    }  

%}

%union {
    int nb;
    char *str;
}

%token          tMAIN 
                tPRINTF
                tINT
                tVOID
                tRETURN
                tCONST
                tIF
                tELSE 
        <str>   tVAR_NAME 
        <nb>    tINT_VAL 
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

%type   <nb>    EXPRESSION

%right tAFFECT
%left tPLUS tMINUS
%left tMUL tSLASH

%%

PROGRAM:
        tVOID tMAIN { /*ouvrir le fichier assembleur pour écrire dedans*/ } 
        tOPEN_PAR ARG_LIST tCLOSE_PAR tOPEN_BRACE BODY tCLOSE_BRACE {  }
    ;

ARG_LIST: 
        /* void */ {  }
    |   tINT tVAR_NAME tCOMA ARG_LIST {  }
    ;

BODY: 
        DECLARATION_BLOCK INSTRUCTION_BLOCK {  }
    ;

/*-----------------------------------DECLARATIONS-----------------------------------*/

DECLARATION_BLOCK:
        /* void */ {  }
    |   DECLARATION_LINE DECLARATION_BLOCK {  }
    ;

DECLARATION_LINE:
        VAR_DECLARATION_LINE {  }
    |   CONST_DECLARATION_LINE {  }
    ;

VAR_DECLARATION_LINE:
        tINT VAR_DECLARATION_LIST tEND {  }
    ;

CONST_DECLARATION_LINE:
        tCONST CONST_DECLARATION_LIST tEND {  }
    ;

VAR_DECLARATION_LIST:
        VAR_DECLARATION {  }
    |   VAR_DECLARATION tCOMA VAR_DECLARATION_LIST {  }
    ;

CONST_DECLARATION_LIST:
        CONST_DECLARATION {  }
    |   CONST_DECLARATION tCOMA CONST_DECLARATION_LIST {  }
    ;

VAR_DECLARATION:
        tVAR_NAME { 
            symbol_array[next_symbol_index].type = 1;
            symbol_array[next_symbol_index].name = strdup($1);
            next_symbol_index++;
        }
    |   tVAR_NAME tAFFECT tINT_VAL { 
            symbol_array[next_symbol_index].type = 1;
            symbol_array[next_symbol_index].name = strdup($1);
            //printf("AFC %d %d\n", next_symbol_index, $3);
            put_instruction2("AFC", next_symbol_index, $3);
            next_symbol_index++;
        }
    ;

CONST_DECLARATION:
        tVAR_NAME tAFFECT tINT_VAL { 
            symbol_array[next_symbol_index].type = 0;
            symbol_array[next_symbol_index].name = strdup($1);
            //printf("AFC %d %d\n", next_symbol_index, $3);
            put_instruction2("AFC", next_symbol_index, $3);
            next_symbol_index++;
        }
    ;

/*-----------------------------------INSTRUCTIONS-----------------------------------*/

INSTRUCTION_BLOCK:
        /* void */ { }
    |   INSTRUCTION_LINE INSTRUCTION_BLOCK {  }
    ;

INSTRUCTION_LINE:
        AFFECT tEND {  }
    |   PRINT tEND {  }
    |   RETURN tEND {  }
    |   IF 
    ;


IF:
        tIF tOPEN_PAR EXPRESSION tCLOSE_PAR tOPEN_BRACE BODY tCLOSE_BRACE IF_ELSE {  }
    ;

IF_ELSE:
    ;

AFFECT:
        tVAR_NAME tAFFECT EXPRESSION {
            next_symbol_index--;
            int addr = find_symbol($1);
            //printf("CPY %d %d\n", addr, $3);
            put_instruction2("CPY", addr, $3);
        }
    ;

PRINT:
        tPRINTF tOPEN_PAR EXPRESSION tCLOSE_PAR {
            //printf("PRI %d\n", $3); 
            put_instruction1("PRI", $3);
            next_symbol_index--;
        }
    ;

RETURN:
        tRETURN EXPRESSION { 
            next_symbol_index--;
        }
    ;

EXPRESSION:
        tINT_VAL { 
            // printf("AFC %d %d\n", next_symbol_index, $1);
            put_instruction2("AFC", next_symbol_index, $1);
            $$ = next_symbol_index;
            next_symbol_index++;
        }
    |   tVAR_NAME { 
            int addr = find_symbol($1);
            //printf("CPY %d %d\n", next_symbol_index, addr);
            put_instruction2("CPY", next_symbol_index, addr);
            $$ = next_symbol_index;
            next_symbol_index++;
        }
    |   EXPRESSION tMUL EXPRESSION { 
            //printf("MUL %d %d\n", $1, $3);
            put_instruction2("MUL", $1, $3);
            next_symbol_index--;
            $$ = $1;
        }
    |   EXPRESSION tSLASH EXPRESSION { 
            //printf("DIV %d %d\n", $1, $3);
            put_instruction2("DIV", $1, $3);
            next_symbol_index--;
            $$ = $1;
        }
    |   EXPRESSION tPLUS EXPRESSION { 
            //printf("ADD %d %d\n", $1, $3);
            put_instruction2("ADD", $1, $3);
            next_symbol_index--;
            $$ = $1;
        }
    |   EXPRESSION tMINUS EXPRESSION { 
            //printf("SUB %d %d\n", $1, $3);
            put_instruction2("SUB", $1, $3);
            next_symbol_index--;
            $$ = $1;
        }
    |   tMINUS EXPRESSION %prec tMUL { 

        }
    |   tOPEN_PAR EXPRESSION tCLOSE_PAR { 
            $$ = $2;
        }
    ;

%%

int main() {
    yyparse();
    printf("Instructions debuffering\n");
    for (int j = 0 ; j < next_instruction_index ; j++) {
        instruction *i = &instruction_array[j];
        if( (i->op2 == -1) && (i->op3 == -1) ) {
            printf("%s %d\n", i->opCode, i->op1);
        }
        else if( i->op3 == -1 ) {
            printf("%s %d %d\n", i->opCode, i->op1, i->op2);
        }
        else {
            printf("%s %d %d %d\n", i->opCode, i->op1, i->op2, i->op3);
        }
    }
}