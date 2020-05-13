%{
#include "y.tab.h"
%}

%%

"main" {
    return tMAIN;
}

"printf" {
    return tPRINTF;
}

"int" {
    return tINT;
}

"void" {
    return tVOID;
}

"return" {
    return tRETURN;
}

"const" {
    return tCONST;
}

"if" {
    return tIF;
}

"else" {
    return tELSE;
}

"while" {
    return tWHILE;
}

[a-zA-Z][_0-9a-zA-Z]* {
    yylval.str = strdup(yytext);
    return tVAR_NAME;
}

[0-9]+(e[0-9]+)? {
    yylval.nb = atoi(yytext);
    return tINT_VAL;
}

"{" {
    return tOPEN_BRACE;
}

"}" {
    return tCLOSE_BRACE;
}

"+" {
    return tPLUS;
}

"-" {
    return tMINUS;
}

"*" {
    return tMUL;
}

"/" {
    return tSLASH;
}

"=" {
    return tAFFECT;
}

"(" {
    return tOPEN_PAR;
}

")" {
    return tCLOSE_PAR;
}

[ \t\n]+ {
    // endl is equal to space and tab
    ;
}

"," {
    return tCOMA;
}

";" {
    return tEND;
}

%%

int yywrap(void) {}

// int main(void) {
//     yylex();
//     return 1;
// }