
D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
IS			(u|U|l|L)*
O   			[0-7]
NZ  			[1-9]
A   			[a-zA-Z_0-9]
HP  			(0[xX])
E   			([Ee][+-]?{D}+)
P   			([Pp][+-]?{D}+)
FS  			(f|F|l|L)
CP  			(u|U|L)
SP  			(u8|u|U|L)
ES  			(\\(['"\?\\abfnrtv]|[0-7]{1,3}|x[a-fA-F0-9]+))
WS  			[ \t\v\n\f]

%{
#include <stdio.h>
#include "def.h"
void f();

%}

%%
"#"			{comment(); }
"break"			{ f(); printf("BREAK         ");  return(BREAK); }
"continue"		{ f(); printf("CONTINUE      ");  return(CONTINUE); }
"do"			{ f(); printf("DO            ");  return(DO); }
"else"			{ f(); printf("ELSE          ");  return(ELSE); }
"for"			{ f(); printf("FOR           ");  return(FOR); }
"if"			{ f(); printf("IF            ");  return(IF); }
"return"		{ f(); printf("RETURN        ");return(RETURN); }
"while"			{ f(); printf("WHILE         "); return(WHILE);}
"True"			{ f(); printf("TRUE         "); return(TRUE);}
"False"			{ f(); printf("FALSE         "); return(FALSE);}
"None"			{ f(); printf("NONE         "); return(NONE);}
"and"			{ f(); printf("AND         "); return(AND);}
"def"			{ f(); printf("DEF         "); return(DEF);}
"not"			{ f(); printf("NOT         "); return(NOT);}
"import"		{ f(); printf("IMPORT         "); return(IMPORT);}
"or"			{ f(); printf("OR         "); return(OR);}
"from"			{ f(); printf("FROM         "); return(FROM);}
"global"		{ f(); printf("GLOBAL         "); return(GLOBAL);}
"print"			{ f(); printf("PRINT         "); return(PRINT);}
"in"			{ f(); printf("IN         "); return(IN);}
"range"			{ f(); printf("RANGE         "); return(RANGE);}
"class"			{ f(); printf("CLASS         "); return(CLASS);}

{L}({L}|{D})*		{ f(); printf("IDENTIFIER"); return(IDENTIFIER); }
{HP}{H}+{IS}?		{ f(); printf("CONSTANT      "); return(CONSTANT); }
0{D}+{IS}?		{ f(); printf("CONSTANT      "); return(CONSTANT); }
{D}+{IS}?		{ f(); printf("CONSTANT      "); return(CONSTANT); }
L?'(\\.|[^\\'])+'	{ f();printf("CONSTANT      "); return(CONSTANT); }
{D}+{E}{FS}?		{ f();printf("CONSTANT      "); return(CONSTANT); }
{D}*"."{D}+({E})?{FS}?	{ f();printf("CONSTANT      "); return(CONSTANT); }
{D}+"."{D}*({E})?{FS}?	{ f();printf("CONSTANT      "); return(CONSTANT); }
L?\"(\\.|[^\\"])*\"	{ f();printf("STRING_LITERAL	"); return(STRING_LITERAL); }

">>="			{ f(); printf("RIGHT_ASSIGN	 "); return(RIGHT_ASSIGN);}
"<<="			{ f(); printf("LEFT_ASSIGN   "); return(LEFT_ASSIGN);}
"+="			{ f(); printf("ADD_ASSIGN    "); return(ADD_ASSIGN);}
"-="			{ f(); printf("SUB_ASSIGN    "); return(SUB_ASSIGN);}
"*="			{ f(); printf("MUL_ASSIGN    "); return(MUL_ASSIGN);}
"/="			{ f(); printf("DIV_ASSIGN    "); return(DIV_ASSIGN);}
"%="			{ f(); printf("MOD_ASSIGN    "); return(MOD_ASSIGN);}
"&="			{ f(); printf("AND_ASSIGN    "); return(AND_ASSIGN);}
"^="			{ f(); printf("XOR_ASSIGN    "); return(XOR_ASSIGN);}
"|="			{ f(); printf("OR_ASSIGN     "); return(OR_ASSIGN);}
">>"			{ f(); printf("RIGHT      "); return(RIGHT);}
"<<"			{ f(); printf("LEFT       "); return(LEFT);}
"++"			{ f(); printf("INC        "); return(INC);}
"--"			{ f(); printf("DEC        "); return(DEC);}
"->"			{ f(); printf("PTR        "); return(PTR);}
"&&"			{ f(); printf("AND        "); return(AND);}
"||"			{ f(); printf("OR         "); return(OR);}
"<="			{ f(); printf("LE         "); return(LE); }
">="			{ f(); printf("GE         "); return(GE);}
"=="			{ f(); printf("EQ         "); return(EQ);}
"!="			{ f(); printf("NE         "); return(NE); }
"//"			{ f();printf("FLOOR_DIV",yytext); return(FL); }
"**"			{ f();printf("EXPONENT",yytext); return(EXP); }

";"			{ f();printf("%s             ",yytext); return(';'); }
("{")	    		{ f();printf("%s             ",yytext); return('{'); }
("}")	    		{ f();printf("%s             ",yytext); return('}'); }
","			{ f();printf("%s             ",yytext); return(','); }
":"			{ f();printf("%s             ",yytext); return(':'); }
"="			{ f();printf("%s             ",yytext); return('='); }
"("			{ f();printf("%s             ",yytext); return('('); }
")"			{ f();printf("%s             ",yytext); return(')'); }
("[")   		{ f();printf("%s             ",yytext); return('['); }
("]")       		{ f();printf("%s             ",yytext); return(']'); }
"."			{ f();printf("%s             ",yytext); return('.'); }
"&"			{ f();printf("%s             ",yytext); return('&'); }
"~"			{ f();printf("%s             ",yytext); return('~'); }
"-"			{ f();printf("%s             ",yytext); return('-'); }
"+"			{ f();printf("%s             ",yytext); return('+'); }
"*"			{ f();printf("%s             ",yytext); return('*'); }
"/"			{ f();printf("%s             ",yytext); return('/'); }
"%"			{ f();printf("%s             ",yytext); return('%'); }
"<"			{ f();printf("%s             ",yytext); return('<'); }
">"			{ f();printf("%s             ",yytext); return('>'); }
"^"			{ f();printf("%s             ",yytext); return('^'); }
"|"			{ f();printf("%s             ",yytext); return('|'); }
":"			{ f();printf("%s             ",yytext); return(':'); }
[\n]			{ f();printf("NEW_LINE       ",yytext); return(NEW_LINE); }
[\t]			{ f();printf("TAB            ",yytext); return('TAB'); }
[ \v\f]			{ f(); }
.			{ f(); printf("INVALID       "); return yytext[0]; }

%%

yywrap()
{
	return(1);
}

int column = 0;
int line=1;
comment()
{
	char c;
	while ((c = input()) != '\n' && c != 0) ;
	column=0;
	line++;
}	

int coln = 0;
void f()
{
	coln = column+1;
	for (int i = 0; yytext[i] != '\0'; i++)
	{	
		if (yytext[i] == '\n')
			column = 0,line++;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;
	}
}

int main(int argc, char *argv[])
{	
	for(int i=1;i<argc;i++)
	{
        if(i+1<argc)
        {
            FILE *file=freopen(argv[i+1],"r",stdin);
            i++;
            if(!file)
            {
                printf("Error, incorrect file location\n");
                return 0;
            }
        }
        else
        {
            printf("Error, incomplete command\n");
            return 0;
        }
	}
	printf("Token			Lexeme			Line#			Column#\n");
	while( yylex() > 0)
	{
		if(yytext[0] == '\n'){
			printf("		new_line		%d			%d \n",line,coln);
			continue;
		}
		if(yytext[0] == '\t'){
			printf("		hor_tab			%d			%d \n",line,coln);
			continue;
		}
		printf("		%s			%d			%d\n",yytext,line,coln);							
	}
	
}
