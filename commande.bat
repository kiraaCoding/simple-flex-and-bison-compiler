flex lexicalproj.l
bison -d syntaa2.y
gcc lex.yy.c syntaa2.tab.c -lfl -ly -o comp.exe