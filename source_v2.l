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

[a-zA-Z][_0-9a-zA-Z]* {
    return tVAR_NAME;
}

[0-9]+(e[0-9]+)? {
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