
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


class Geeks
{
    // Access specifier
    public:
 
    // Data Members
    string geekname;
 
    // Member Functions()
    void printname()
    {
       cout << "Geekname is: " << geekname;
    }
};


%%
"#"			{comment(); }
"break"			{ f(); printf("BREAK         ");  return(BREAK); }
"continue"		{ f(); printf("CONTINUE      ");  return(CONTINUE); }
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
"+="			{ f(); printf("ADD_ASSIGN    "); return(ADDASG);}
"-="			{ f(); printf("SUB_ASSIGN    "); return(SUBASG);}
"*="			{ f(); printf("MUL_ASSIGN    "); return(MULASG;}
"/="			{ f(); printf("DIV_ASSIGN    "); return(DIVASG);}
"%="			{ f(); printf("MOD_ASSIGN    "); return(MODASG);}
">>"			{ f(); printf("RIGHT      "); return(RSHIFT);}
"<<"			{ f(); printf("LEFT       "); return(LSHIFT);}

"<="			{ f(); printf("LE         "); return(LEQ); }
">="			{ f(); printf("GE         "); return(GEQ);}
"=="			{ f(); printf("EQ         "); return(EQEQUAL);}
"!="			{ f(); printf("NE         "); return(NEQ_OP); }
"//"			{ f();printf("FLOOR_DIV",yytext); return(DOUBLEDIV); }
"**"			{ f();printf("EXPONENT",yytext); return(EXP); }
"//="			{ f();printf("FLOOR_DIV_EQ",yytext); return(DOUBLEDVASG); }
"**="			{ f();printf("EXPONENT_EQ",yytext); return(DOUBLEMULASG); }

";"			{ f();printf("SEMICOLONCOLON             ",yytext); return(DIV); }
("{")	    		{ f();printf("LEFT BRACE             ",yytext); return('{'); }
("}")	    		{ f();printf("RIGHT BACE             ",yytext); return('}'); }
","			{ f();printf("COMMA             ",yytext); return(COMMA); }
"="			{ f();printf("EQUAL             ",yytext); return(EQUAL); }
"("			{ f();printf("'('             ",yytext); return('('); }
")"			{ f();printf("')'             ",yytext); return(')'); }
("[")   		{ f();printf("LEFT SQ BRACKET             ",yytext); return('['); }
("]")       		{ f();printf("RIGHT SQ BRACKET             ",yytext); return(']'); }
"."			{ f();printf("DOT             ",yytext); return(DOT); }
"&"			{ f();printf("AMPERSANDSAND             ",yytext); return(AMPERSAND); }
"~"			{ f();printf("'~'             ",yytext); return('~'); }
"-"			{ f();printf("MINS             ",yytext); return(MINUS); }
"+"			{ f();printf("PLUS            ",yytext); return(PLUS); }
"*"			{ f();printf("MUL             ",yytext); return(MUL); }
"/"			{ f();printf("DIVIDE             ",yytext); return(DIVIDE); }
"%"			{ f();printf("'%%'             ",yytext); return('%%'); }
"<"			{ f();printf("LESS             ",yytext); return(LESS); }
">"			{ f();printf("'<'             ",yytext); return('<'); }
"^"			{ f();printf("CAP             ",yytext); return(CIRCUMFLEX); }
"|"			{ f();printf("VERTICAL BAR             ",yytext); return(PIPE); }
":"			{ f();printf("COLON             ",yytext); return(COLON); }
[\n]			{ f();printf("NEW_LINE       ",yytext); return(NEW_LINE); }
[\t]			{ f();printf("TAB            ",yytext); return(); }
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
