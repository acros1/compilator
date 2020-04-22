all:	comp

comp:	y.tab.o lex.yy.o
		gcc -Wall y.tab.o lex.yy.o -o comp

y.tab.c: 	spark.y
			yacc -d spark.y
			
lex.yy.c:	source_v2.l
			lex source_v2.l

.PHONY: clean

clean:
	rm y.tab.o y.tab.c lex.yy.c lex.yy.o