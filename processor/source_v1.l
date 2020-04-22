%%

"main" {
    printf("MAIN\n");
}

"printf" {
    printf("PRINTF\n");
}

"int" {
    printf("INT\n");
}

"const" {
    printf("CONST\n");
}

[a-zA-Z][_0-9a-zA-Z]* {
    printf("VAR_NAME\n");
}

[0-9]+(e[0-9]+)? {
    printf("INT_VAL\n");
}

"{" {
    printf("OPEN_BRACE\n");
}

"}" {
    printf("CLOSE_BRACE\n");
}

"+" {
    printf("PLUS\n");
}

"-" {
    printf("MINUS\n");
}

"*" {
    printf("MUL\n");
}

"/" {
    printf("SLASH\n");
}

"=" {
    printf("AFFECT\n");
}

"(" {
    printf("OPEN_PAR\n");
}

")" {
    printf("CLOSE_PAR\n");
}

[ \t\n]+ {
    // endl is equal to space and tab
    printf("SPACE\n");
}

"," {
    printf("COMA\n");
}

";" {
    printf("END\n");
}

%%

int yywrap(void) {}

int main(void) {
    yylex();
    return 1;
}