cls
bison -d projecty.y
flex project.l
gcc lex.yy.c projecty.tab.c -o app
app