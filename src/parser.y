%{
#include <iostream>
#include <string>
#include "node.h"
#include <fstream>
#include <set>
#include <cstring>
#include "node.h"
#include "type.h"
#include <fstream>
#include<vector>

typedef struct{

}node;

node* makenode(){
	string name;
}

node* assign(node* n){
	if(!node){

	}
}
using namespace std;
void yyerror(char *s);
int yylex();

%}
%union{
	node *ptr;
	char *str;
}


%token<str> EQEQUAL NOTEQUAL LESSEQUAL LEFTSHIFT GREATEREQUAL 
%token<str> RIGHTSHIFT PLUSEQUAL MINEQUAL STAREQUAL SLASHEQUAL PERCENTEQUAL 
%token<str> STARSTAR SLASHSLASH STARSTAREQUAL SLASHSLASHEQUAL 
%token<str> COLON COMMA SEMI PLUS MINUS STAR SLASH VBAR AMPER LESS 
%token<str> GREATER EQUAL DOT PERCENT BACKQUOTE '^' TILDE AT 
%token<str> LPAREN  RPAREN LBRACE  RBRACE LSQB  RSQB 
%token<str> NEWLINE INUMBER FNUMBER BINARYNUMBER OCTALNUMBER HEXADECIMALNUMBER  
%token<str> NUMBER INDENT  DEDENT TRIPLESTRING  STRING  
%token<str> RAWSTRING UNICODESTRING NAME WS ENDMARKER

%token<str> AND AS ASSERT BREAK CLASS CONTINUE DEF DEL ELIF ELSE EXCEPT EXEC FINALLY FOR FROM GLOBAL
%token<str> IF IMPORT IN IS LAMBDA NOT OR PASS PRINT RAISE RETURN TRY WHILE WITH YIELD





//%type <ptr> primary_expression postfix_expression argument_expression_list unary_expression unary_operator cast_expression multiplicative_expression additive_expression
//%type <ptr> shift_expression relational_expression equality_expression and_expression exclusive_or_expression inclusive_or_expression logical_and_expression logical_or_expression
//%type <ptr> conditional_expression assignment_expression assignment_operator expression constant_expression declaration declaration_specifiers init_declarator_list init_declarator
//%type <ptr> storage_class_specifier type_specifier struct_or_union_specifier struct_or_union struct_declaration_list struct_declaration specifier_qualifier_list struct_declarator_list
//%type <ptr> struct_declarator enum_specifier enumerator_list enumerator type_qualifier declarator direct_declarator pointer type_qualifier_list parameter_type_list parameter_list
//%type <ptr> parameter_declaration identifier_list type_name abstract_declarator direct_abstract_declarator initializer initializer_list statement labeled_statement compound_statement
// %type <ptr> declaration_list statement_list expression_statement selection_statement iteration_statement jump_statement translation_unit external_declaration function_definition

// %type <ptr>file_input single_stmt funcdef parameters varargslist fpdeflist fpdef fplist fplist1 stmt simple_stmt


%start translation_unit
%%

	file_input :	single_stmt ENDMARKER{
		$$ = assign($1);
		string str = ""
		emit(getCurrScope(), "","", -1, "HALT");
		addAttrtoCurrScope("num", 0);
		removeScope();
		print_out();
	}
	;
	single_stmt	:	single_stmt NEWLINE {
		$$ = assign($1);
	}
	;

    funcdef : DEF NAME MarkerScope parameters ':' suite{
		string str = ""
		no_op(getCurrScope(), $7->beginlist);
		no_op(getCurrScope(), $7->endlist);
		emit(getCurrScope(), "","","", "JUMPRETURN");
		removeScope();
		$$ = makenode();
		$$->type = "FUNCTION";
		$$->name = $3->name;
	}
	;
///////////////////////////

	parameters : '(' ')' {
		$$ = assign(NULL);
	}
				|'(' varargslist ')'{
		$$ = assign($2); //////////assignarray 
	}
	;

	function_call 	: NAME '(' ')' {
		$$ = makenode();
		if(!present($1))error();
		else{
			string idType = get_attr($1, "type");
			if(idType == "FUNCTION"){
				emit(getCurrScope(), "", "", $1->name, "JUMPLABEL");
				$$->type = get
			}
			else error();
		}
	}
						| NAME '(' testlist ')' 
						;

    varargslist 	:
    				 fpdef '=' test fpdeflist ','
    				| fpdef EQUAL test fpdeflist
    				| fpdef fpdeflist ','
    				| fpdef fpdeflist
    ;

	fpdeflist 	:
					 fpdeflist ',' fpdef
					| fpdeflist ',' fpdef EQUAL test
	;

	fpdef 	: NAME 
				| '(' fplist ')'
	;

	fplist 	: fpdef fplist1 ','
				| fpdef fplist1	
	;

	fplist1 	:
				 fplist1 ',' fpdef
	;

	stmt 	: simple_stmt
				| compound_stmt
	;

	simple_stmt 	: small_stmts NEWLINE
					| small_stmts SEMI NEWLINE
	;

	small_stmts 	: small_stmts SEMI small_stmt
					| small_stmt
	;
	small_stmt 	: flow_stmt
					| expr_stmt
					| print_stmt
					| pass_stmt
					| import_stmt
					| global_stmt
					| assert_stmt
	;

	expr_stmt 	: testlist augassign testlist
					| testlist eqtestlist
	;
	eqtestlist 	:
					 eqtestlist EQUAL testlist
	;

	augassign 	: PLUSEQUAL 
					| MINEQUAL 
					| STAREQUAL 
					| SLASHEQUAL 
					| PERCENTEQUAL 
					| STARSTAREQUAL 
					| SLASHSLASHEQUAL 
	;
	print_stmt 	:	PRINT
					|	PRINT testlist
	;

	pass_stmt : PASS
	;

	flow_stmt 	: break_stmt
					| continue_stmt
					| return_stmt
	;
	break_stmt 	: BREAK
	;
	continue_stmt 	: CONTINUE
	;
	return_stmt 	:	RETURN 
					|	RETURN testlist
	;
	import_stmt 	:	IMPORT NAME
					|	IMPORT NAME AS NAME
	;
	global_stmt 	: GLOBAL NAME namelist
	;
	namelist 	: 
					 ',' NAME namelist
	;
	assert_stmt 	: ASSERT testlist
	;
	compound_stmt 	: if_stmt
						| for_stmt
						| while_stmt
						| funcdef
						| classdef
	;
	if_stmt 	:	IF test ';' suite elif_list
				|	IF test ';' suite elif_list ELSE ';' suite
	;
	elif_list 	:
					 ELIF test ';' suite elif_list
	;
	while_stmt 	:	WHILE test ';' suite 
					|	WHILE test ';' suite ELSE ';' suite
	;




	for_stmt 	:	FOR exprlist IN testlist ';' suite{
		$$ = makenode();
		$$->nextlist = ($7->endlist).insert(($7->endlist).begin(),($7->nextlist).begin(),  ($7->endlist).end() )
		emit(getCurrScope(), $6->index, $->index, 1, "");
		emit(getCurrScope(),"","", $6->quad, "GOTO");
	}
	;


	suite 	: simple_stmt{
				$$ = assign($1);
	}
				| NEWLINE INDENT stmts DEDENT{

				$$ = assign($3);
				}
	;

	array	: test_expr
	:

	test_expr 	: or_test{
				$$ = assign($1);

	}
	;

// or_test: and_test ('or' and_test)*
//or_test(p)
	or_test 	: and_test{
						$$ = assign($1);

	}
				| and_test OR or_test{
				if($1->type == "BOOLEAN" && $3->type == "BOOLEAN"){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "BOOLEAN";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "OR");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
	;

	ortestlist 	:
					 OR and_test ortestlist
	;

	and_test 	: not_test {
						$$ = assign($1);
	}
	
				| not_test AND and_test{
				if($2->type == "BOOLEAN" ){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "BOOLEAN";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "AND");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
	;

	andtestlist 	:
					 AND not_test andtestlist
	;

	not_test 	: NOT not_test{
				if($2->type == "BOOLEAN" ){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "BOOLEAN";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "NOT");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
					| comparison{
						$$ = assign($1);
					}
	;

	comparison 	: expr {
		$$ = assign($1);
	}
				| expr comp_op expr{
				if($2->type == "BOOLEAN" ){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "BOOLEAN";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "comp_op");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
	;

	compexprlist 	:
						 comp_op expr compexprlist{
				if($1->type == "NUMBER" || $1->type == "UNDEFINED"||$1->type == "BOOLEAN" && $3->type == "NUMBER" || $3->type == "UNDEFINED"||$3->type == "BOOLEAN"){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "BOOLEAN";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "comp_op");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
	;

	comp_op 	: LESS	{$$ = assign($1)}
				| GREATER	{$$ = assign($1)}
				| EQEQUAL	{$$ = assign($1)}
				| GREATEREQUAL	{$$ = assign($1)}
				| LESSEQUAL	{$$ = assign($1)}
				| NOTEQUAL	{$$ = assign($1)}
	;

	expr 	: xor_expr{
		$$ = assign($1);
	}
			| xor_expr VBAR expr{
				if($1->type == "NUMBER" && $3->type == "NUMBER"){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "VBAR");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
	;

	xorexprlist 	:
						VBAR xor_expr xorexprlist
	;

	xor_expr 	: and_expr{
		$$ = assign($1);
	}
				| and_expr '^' xor_expr{
				if($1->type == "NUMBER" && $3->type == "NUMBER"){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "'^'");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
	;

	andexprlist 	:
					 '^' and_expr andexprlist
	;

	and_expr 	: shift_expr{
		$$ = assign($1);
	}
				| shift_expr AMPER and_expr{
				if($1->type == "NUMBER" && $3->type == "NUMBER"){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "AMPER");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
	;

	shiftexprlist 	:
						 AMPER shift_expr shiftexprlist
	;

	shift_expr 	: arith_expr {
		$$$ = assign($1);
	}
				| arith_expr LEFTSHIFT shift_expr{
				if($1->type == "NUMBER" && $3->type == "NUMBER"){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "LEFTSHIFT");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
				| arith_expr RIGHTSHIFT shift_expr{
				if($1->type == "NUMBER" && $3->type == "NUMBER"){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "RIGHTSHIFT");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
	;

	arithexprlist 	:
						 LEFTSHIFT arith_expr arithexprlist
						| RIGHTSHIFT arith_expr arithexprlist
	;

	arith_expr 	:	term{
		$$ = assign($1);
	}
				|	term PLUS arith_expr{
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "PLUS");
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
				|	term MINUS arith_expr{
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "MINUS");
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}

	;

	termlist 	:
					 PLUS term termlist
					| MINUS term termlist
	;

	term :	factor{
		$$ = assign($2);
	}
			| factor STAR term{
				if($1->type == "NUMBER" && $3->type == "NUMBER"){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "STAR");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
			| factor SLASH term{
				if($1->type == "NUMBER" && $3->type == "NUMBER"){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "SLASH");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
			| factor PERCENT term{
				if($1->type == "NUMBER" && $3->type == "NUMBER"){
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, $1->place, $3->place, "PERCENT");
				}
				else {
					if($1-> type == "REFERENCE_ERROR" || $3-> type == "REFERENCE_ERROR")error();
				}
			}
			
	;

	factorlist 	:
					 STAR factor factorlist
					| SLASH factor factorlist
					| PERCENT factor factorlist
					| SLASHSLASH factor factorlist
	;

	factor 	: power{
		$$ = assign($1);
	}
				| PLUS factor{
					if($2->type != "NUMBER")error();
					$$ = makenode();
					$$->place = getNewTempVar();
					$$->type = "NUMBER";
					emit(getCurrScope(), $$->place, 0, $2->place, "-");
				}
				| MINUS factor
	;

	power 	: atom{
		$$ = assign($1);
	}
				| atom LSQB STARSTAR RSQB{
					if($3 -> type != "NUMBER"){
						error();
					}
					else{
						if($1 -> isId){
							error();
						}
						$$ = makenode();
						$$->type = $1->type;
						int wid = getWid($1->type);
						int baseAddr = 100;//getBaseAddr(getCurrScope(), $1->name);
						index = getNewTempVar();
						emit(getCurrScope(), index, $3->place, "", "=");
						relAddr = getNewTempVar();
						emit(getCurrScope(), relAddr, index, wid, "*");
						absAddr = getNewTempVar();
						emit(getCurrScope(), absAddr, baseAddr, relAddr, "+" );
						val = getNewTempVar();
						emit(getCurrScope(), val, absAddr, "", "LW");
						$$->place = val;
						$$->absAddr = absAddr;
						$$->isArray = TRUE;
						$$->name = $1->name;

					}
				}
	;
	trailerlist 	: 
					 trailer trailerlist
	;

	atom 	: '(' ')'{
		$$ = makenode();
	}
				| '(' testlist_comp ')'{
					$$ = assign($2);
				}
				| LSQB RSQB{
					$$ = makenode();
					$$->place = empty_array();
					$$->type = "NUMBER";
				}
				| LSQB listmaker RSQB{
					$$ = assign($2);
					$$->isList = TRUE;
					$$->name = getNewTempVar();
					add_Id($$->name, $$->type);
					add_attr($$->name, "place", $$->place);
					add_attr($$->name, "isArray", "True");
					emit(getCurrScope(), $$->name, $$->place, 'ARRAY', '=');
				}
				| STRING{

					$$ = makenode();
					$$->place = assign($1);
					$$->type = "STRING";
				}
				| LBRACE dictorsetmaker RBRACE
				| BACKQUOTE testlist1 BACKQUOTE
				| NAME{
					$$ = makenode();
					if(present($1)){
						$$->name = $1;
						$$->type = get_attr($1, type);
					}
				}
				| NUMBER{

					$$ = makenode();
					$$->type = "NUMBER";
					name = getNewTempVar();
					add_Id(name, 'NUMBER');
					lvl = get_attr(name,'scopeLevel' );
					offset = get_attr(name, 'offset');
					$$->place = getNewTempVar((level, offset), name);
					emit(getCurrScope(), $$->place, $1,"", "=i" );
				}
				| FNUMBER{
					
					$$ = makenode();
					$$->place = assign($1);
					$$->type = "NUMBER";
				}
				| stringlist
	;

	stringlist 	: STRING 
					| STRING stringlist
					| TRIPLESTRING
					| TRIPLESTRING stringlist
	;

	listmaker 	: testlist{
	$$ = makenode();
	$$->place = makearray($1 ->place);
	$$->type = makearray($1 ->type);
	}
				| test ',' listmaker{
					if($3->type != $1->type) error();
					else{
						$$->place = makearray($1->place).insert($3->place);
						$$->type = $1->type;
					}
				}
	;
	
	trailer 	: '(' ')'
				| '(' arglist ')'
				| LSQB subscriptlist RSQB
				| DOT NAME
	;

	subscriptlist 	: subscript
						| subscript ','
						| subscript ',' subscriptlist
	;

	subscript 	: DOT DOT DOT
					| test
					| test ';' test sliceop
					| ';' test sliceop
					| test ';' sliceop
					| test ';' test
					| test ';'
					| ';' test
					| ';' sliceop
					| ';'
	;

	sliceop 	: ';'
				| ';' test
	;

	exprlist 	: expr
					| expr ','
					| expr ',' exprlist
	;

	testlist 	: test
					| test ','
					| test ',' testlist
	;

	dictorsetmaker 	: test';'list
						| testlist
	;

	test';'list 	: test ';' test
						| test ';' test ','
						| test ';' test ',' test';'list
	;

	classdef 	: CLASS NAME ';' suite
					| CLASS NAME '(' ')' ';' suite
					| CLASS NAME '(' testlist ')' ';' suite
	;

	arglist 	: argument
				| argument ','
				| argument ',' arglist
	;
	argument 	: test
					| test EQUAL test
	;
	testlist_comp 	: test{
		$$ = makearray($1);
	}
					| test ',' testlist_comp{
						$$ = makearray($1).insert($2);
					}
	;

	testlist 	: test{
		$$ = makearray($1);
	}
					| test ',' testlist{
						$$ = makearray($1).insert($2);
					}
	;

	stmts 	: stmt stmts {
		$$ = makenode();
		$$ -> beginlist.insert(($$->beginlist).end(), ($1->beginlist).begin(), ($2->beginlist).end());
		$$ -> endlist.insert(($$->endlist).end(), ($1->endlist).begin(), ($2->endlist).end());
	}
				| stmt Marker{
		$$ = makenode();
		$$ -> beginlist.insert(($$->beginlist).end(), ($1->beginlist).begin(), ($2->beginlist).end());
		$$ -> endlist.insert(($$->endlist).end(), ($1->endlist).begin(), ($2->endlist).end());
	}
	;




%%
#include <stdio.h>
#define red   "\033[31;1m"
#define reset   "\033[0m"
extern char yytext[];
extern int column;
extern int line;
char *filename;
FILE *in=NULL;
FILE *out=NULL;

void yyerror(char *s)
{	
	fflush(stdout);
	fprintf(stderr,"%s:%d:%d:%s Error: %s\n",filename,line,column,red,reset);
	fclose(in);
	in=freopen(filename,"r",stdin);
	string str;
	for(int i=0;i<line;i++)
	{
		getline(cin,str);
	}
	
	cerr<<str;

	fprintf(stderr,"\n%*s\n%s%*s%s\n", column, "^", red,column,s,reset);
}

void help(int f)
{	
	if(f) printf("%sError: %s\n",red,reset);
	printf("Give Input file with -i flag\n");
	printf("Give Output file with -o flag\n");
}


int main(int argc, char *argv[])
{	
	if(argc==1)
	{
		help(1);
		return 0;
	}
	
	for(int i=1;i<argc;i++)
	{

		if(strcmp("-help",argv[i])==0)
		{
			help(0);
			return 0;
		}
		else if(strcmp("-i",argv[i])==0)
		{
			if(i+1<argc)
			{
				in=freopen(argv[i+1],"r",stdin);
				filename=argv[i+1];
				i++;

				if(!in)
				{
					help(1);
					return 0;
				}
			}
			else
			{
				help(1);
				return 0;
			}
		}

		else if(strcmp("-o",argv[i])==0)
		{
			if(i+1<argc)
			{
				out =freopen(argv[i+1],"w",stdout);
				i++;
				if(!out)
				{
					help(1);
					return 0;
				}
			}
			else
			{
				help(1);
				return 0;
			}
		}
		else
		{
			help(1);
			return 0;
		}
	}
	if(!in)help(1);
	if(!out)freopen("ast.dot","w",stdout);
	BeginGraph();
	yyparse();
	EndGraph();
	
} 