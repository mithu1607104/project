%{
    #include <stdio.h>
    #include <math.h>
    #define YYSTYPE int	
    extern FILE *yyin;
    extern FILE *yyout;
    int sym[1000] ;
    int ckvar[1000]={0};
    int yylex(); 
    void yyerror (char const *s);      

%}



%token  NUM VAR IF ELSE MAIN INT CHAR FLOAT FOR DO WHILE POWER NEG PRNT INC PLUSPLUS DEC MINUSMINUS SWITCH CASE BREAK DEFAULT 
%nonassoc IF
%nonassoc ELSE
%nonassoc SWITCH
%nonassoc CASE
%nonassoc DEFAULT
%left '<' '>'
%left '+' '-'
%left '*' '/'

%start program

%%


program:
	| MAIN '{' in_main '}'	{ printf("\n\n END MAIN FUNCTION \n");}
       ;
in_main:
    | in_main  statement
    ;


statement : ';'
        |declaration {}
	|expression ';'   { $$=$1;}
	|VAR '=' expression ';'	{ sym[$1] = $3 ;$$=$3;
				printf(" assiging value of variable :%c= %d\t\n",$1+'a',$3);}
	|IF '(' expression ')' '{' statement  '}' {if($3) printf("In if \n");                                                                                            else printf("Condition false\n");}
	|IF '(' expression ')'  '{' statement '}'  ELSE  '{'  statement '}'  {if($3) printf("IN IF\n");
						 else printf("In else\n");}
        |IF '(' expression ')' '?' statement  ':' statement { if($3)
                                                              { 
                                                                printf("1st part is true\n");}

                                                               
                                                              else 
                                                              { 
                                                                 printf("2nd part is true\n");}

                                                               
                                                            }
	|FOR expression NUM ':' NUM '{' statement '}'       {
					int k;
                                        printf("Value in for loop\n");
					for(k=$3; k<=$5; k++)
						printf("%d\n",$7);
				}
        |DO '{' statement '}' WHILE '(' expression ')' ';'   {
                                                          int i=1;
                                                          printf("Value in do while loop\n");
                                                          do
                                                           {
                                                            printf("%d\n",$3);
                                                            i++;
                                                           }while(i<$7);
                                                         }
                                                             
         |POWER '(' expression ',' expression ')' ';' {
                                                      int b=$3;
                                                      int c=$5;
                                                      float result=1;
                                                      if($3>0 && $5>0)
                                                      { 
                                                      while(c!=0)
                                                       {
                                                        result=result*b;
                                                        c--;
                                                       }
                                                       printf("The value of power function is %f \n",result);

                                                      }
                                                      else if(b>0 && c<0)
                                                       { 
                                                         result=1;
                                                         int x=-c;
                                                      while(x!=0)
                                                       {
                                                        result=(result)*(-b);
                                                        x--;
                                                       }
                                                       result=(1/result);
                                                       printf("The value of power function is %f \n",result);

                                                      }
                                                       else if(b<0 && c<0)
                                                       { 
                                                         result=1;
                                                         int x=-c;
                                                      while(x!=0)
                                                       {
                                                        result=(result)*(-b)*(-1);
                                                        x--;
                                                       }
                                                       result=(1/result);
                                                       printf("The value of power function is %f \n",result);

                                                      }

                                                    }

       |PRNT '(' expression ')' ';'    {  printf("inside printf functions value is %d \n",$3);}

       |INC VAR PLUSPLUS ';'    {printf("the incremental value of %c is= %d\n",$2+'a',++sym[$2]);}

       |DEC VAR MINUSMINUS ';'  {printf("the decremental value of %c is= %d\n",$2+'a',--sym[$2]);}
       |SWITCH '(' VAR ')' '{' A  '}' 
       ;

A   :B 
	| B C
    ;
B  : B '~' B
	| CASE NUM ':' expression ';' BREAK ';' { printf("in case %d\n",$2);}
	;
C   : DEFAULT ':' expression ';' BREAK ';' {}
	
      ;

expression : NUM	{$$ = $1 ;}
	| VAR	{$$ = sym[$1];}
        |'-'VAR {$$ = sym[$2];}
        | NEG	{$$ = $1 ;}
	| expression '+' expression 	{$$ = $1 + $3 ;}
	| expression '-' expression 	{$$ = $1 - $3 ;}
	| expression '*' expression 	{$$ = $1 * $3 ;}
	| expression '/' expression 	{ if($3) $$ = $1 / $3 ;
					  else { $$ = 0 ; printf("\nDivision by zero\n") ;} }
	| expression '<' expression 	{$$ = $1 < $3 ;}
	| expression '>' expression 	{$$ = $1 > $3 ;}
	| '(' expression ')'	{$$ = $2;}
     ;
declaration : TYPE ID1 ';' {
                               printf("\nValid Declaration\n");
                           }
             ;


TYPE : INT  {}
     | FLOAT  {}
     | CHAR  {}
     ;



ID1 : ID1 ',' VAR  {
                    if(ckvar[$3]==0)
                    { ckvar[$3]++;} 
                    else
                    { printf("Error,Declared it in previous\n");} 
                   }
    |VAR          {if(ckvar[$1]==0)
                    { ckvar[$1]++;}
                   else
                    { printf("Error,Declared it in previous\n");}
                    }
    ;

%%

int main()
{
	printf("GO TO START ");
        yyin =  freopen("input.txt","r",stdin);
        yyout = freopen("output.txt","w",stdout);
	yyparse();
	return 0;
}


void yyerror (char const *s)
{
	fprintf (stderr, "%s\n", s);
}

int yywrap()
{
	return 1;
}






