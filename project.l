%{
	#include <stdio.h>
	#include "projecty.tab.h"
        extern int yylval;
     
%}


headersign [@a-z@]
sp [ ]
singleLineComment		[ ]*[#][#][a-zA-Z0-9@$%^&*(){}_+-,.:\|?>< ]*
multipleLineComment		[ ]*[!][#][a-zA-Z0-9@$*(){}_+-,.:\|?><\n\t ]*[#][!]
%%

[ \t]+
"\n"
"int"  return(INT);
"char" return(CHAR);
"float" return(FLOAT);
"#""include"({sp}+)({headersign}+)".""h"  ;

"int main()"	{return MAIN ;}
{singleLineComment}		{ printf("this is single line comment\n");}
{multipleLineComment}	{  printf("this is multiline comment\n");}

[0-9]+ {yylval = atoi(yytext) ; return NUM ;}
[-][0-9] {yylval = atoi(yytext) ; return NEG ;}
[a-z] { yylval = *yytext -'a' ; return VAR ; }
"if" {return IF ;}
"else" {return ELSE ;}
"for" {return FOR;}
"do"  {return DO;}
"while" {return WHILE;}
"power" {return POWER;}
"printdata" {return PRNT;}
"inc" {return INC;}
"++"  {return PLUSPLUS;}
"--"  {return MINUSMINUS;}
"dec"   {return DEC;}
"switch"		   { return SWITCH; }
"case"		   { return CASE;  }
"break"  		   { return BREAK;  }
"default" 	   { return DEFAULT; }

[-+/*<>=,();:{}?~] {yylval = yytext[0] ; return *yytext ;}
.   {printf("\nunknown character");}


%%





