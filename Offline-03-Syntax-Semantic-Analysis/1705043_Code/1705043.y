%{
#include<bits/stdc++.h>
#include<iostream>
#include<cstdlib>
#include<cstring>
#include<cmath>
#include "symbol_table.cpp"
#define YYSTYPE SymbolInfo*

using namespace std;

int yyparse(void);
int yylex(void);
extern FILE *yyin;

SymbolTable* symbolTable = new SymbolTable(7);

int lineCount = 1;
int errorCount = 0;

void yyerror(char *s)
{
	//write your code
}

ofstream log_file("1705043_log.txt");
ofstream error_file("1705043_error.txt");

void PrintGrammar(int lineNo, string grammarName){
	log_file << "At line no: " << lineNo << " "<<grammarName  << endl;
}

void PrintSymbolName(string symbolName){
	log_file << symbolName << endl;
}


%}

%token IF ELSE FOR WHILE DO BREAK INT CHAR FLOAT DOUBLE VOID RETURN CONTINUE PRINTLN ASSIGNOP LOGICOP NOT LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COMMA SEMICOLON DECOP

%union	{SymbolInfo* si; double dval; int ival; string str;}
%token <si> ADDOP MULOP INCOP RELOP ID CONST_INT CONST_FLOAT

// %left 
// %right

// %nonassoc 


%%

start: program
	{
		//write your code in this block in all the similar blocks below
		PrintGrammar(lineCount, "start : program");
	}
	;

program: program unit	{
							PrintGrammar(lineCount, "program : program unit");
						}
	| unit	{
				PrintGrammar(lineCount, "program : unit");
			}
	;
	
unit: var_declaration	{
							PrintGrammar(lineCount, "unit : var_declaration");
						}
     | func_declaration	{
							PrintGrammar(lineCount, "unit : func_declaration");
						}
     | func_definition	{
							PrintGrammar(lineCount, "unit : func_definition");
						}
     ;
     
func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON	{
							PrintGrammar(lineCount, "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
						}
		| type_specifier ID LPAREN RPAREN SEMICOLON	{
							PrintGrammar(lineCount, "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON");
						}
		;
		 
func_definition: type_specifier ID LPAREN parameter_list RPAREN compound_statement	{
							PrintGrammar(lineCount, "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement");
						}
		| type_specifier ID LPAREN RPAREN compound_statement	{
							PrintGrammar(lineCount, "func_definition : type_specifier ID LPAREN RPAREN compound_statement");
						}
 		;				


parameter_list: parameter_list COMMA type_specifier ID	{
							PrintGrammar(lineCount, "parameter_list  : parameter_list COMMA type_specifier ID");
						}
		| parameter_list COMMA type_specifier	{
							PrintGrammar(lineCount, "parameter_list  : parameter_list COMMA type_specifier");
						}
 		| type_specifier ID	{
							PrintGrammar(lineCount, "parameter_list  : type_specifier ID");
						}
		| type_specifier	{
							PrintGrammar(lineCount, "parameter_list  : type_specifier");
						}
 		;

 		
compound_statement: LCURL statements RCURL	{
							PrintGrammar(lineCount, "compound_statement : LCURL statements RCURL");
						}
 		    | LCURL RCURL	{
							PrintGrammar(lineCount, "compound_statement : LCURL RCURL");
						}
 		    ;
 		    
var_declaration: type_specifier declaration_list SEMICOLON	{
							PrintGrammar(lineCount, "var_declaration : type_specifier declaration_list SEMICOLON");
						}
 		 ;
 		 
type_specifier: INT	{
							PrintGrammar(lineCount, "type_specifier	: INT");
						}
 		| FLOAT	{
							PrintGrammar(lineCount, "type_specifier	: FLOAT");
						}
 		| VOID	{
							PrintGrammar(lineCount, "type_specifier	: VOID");
						}
 		;
 		
declaration_list: declaration_list COMMA ID	{
							PrintGrammar(lineCount, "declaration_list : declaration_list COMMA ID");
						}
 		  | declaration_list COMMA ID LTHIRD CONST_INT RTHIRD	{
							PrintGrammar(lineCount, "declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
						}
 		  | ID	{
							PrintGrammar(lineCount, "declaration_list : ID");
						}
 		  | ID LTHIRD CONST_INT RTHIRD	{
							PrintGrammar(lineCount, "declaration_list : ID LTHIRD CONST_INT RTHIRD");
						}
 		  ;
 		  
statements: statement	{
							PrintGrammar(lineCount, "statements : statement");
						}
	   | statements statement	{
							PrintGrammar(lineCount, "statements : statements statement");
						}
	   ;
	   
statement: var_declaration	{
							PrintGrammar(lineCount, "statement : var_declaration");
						}
	  | expression_statement	{
							PrintGrammar(lineCount, "statement : expression_statement");
						}
	  | compound_statement	{
							PrintGrammar(lineCount, "statement : compound_statement");
						}
	  | FOR LPAREN expression_statement expression_statement expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement");
						}
	  | IF LPAREN expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : IF LPAREN expression RPAREN statement");
						}
	  | IF LPAREN expression RPAREN statement ELSE statement	{
							PrintGrammar(lineCount, "statement : IF LPAREN expression RPAREN statement ELSE statement");
						}
	  | WHILE LPAREN expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : WHILE LPAREN expression RPAREN statement");
						}
	  | PRINTLN LPAREN ID RPAREN SEMICOLON	{
							PrintGrammar(lineCount, "statement : PRINTLN LPAREN ID RPAREN SEMICOLON");
						}
	  | RETURN expression SEMICOLON	{
							PrintGrammar(lineCount, "statement : RETURN expression SEMICOLON");
						}
	  ;
	  
expression_statement: SEMICOLON	{
							PrintGrammar(lineCount, "expression_statement 	: SEMICOLON");
						}			
			| expression SEMICOLON	{
							PrintGrammar(lineCount, "expression_statement 	: expression SEMICOLON");
						} 
			;
	  
variable: ID	{
							PrintGrammar(lineCount, "variable : ID");
						} 		
	 | ID LTHIRD expression RTHIRD	{
							PrintGrammar(lineCount, "variable : ID LTHIRD expression RTHIRD");
						} 
	 ;
	 
 expression: logic_expression	{
							PrintGrammar(lineCount, "expression : logic_expression");
						}	
	   | variable ASSIGNOP logic_expression	{
							PrintGrammar(lineCount, "expression : variable ASSIGNOP logic_expression");
						} 	
	   ;
			
logic_expression: rel_expression	{
							PrintGrammar(lineCount, "logic_expression : rel_expression");
						} 	
		 | rel_expression LOGICOP rel_expression	{
							PrintGrammar(lineCount, "logic_expression : rel_expression LOGICOP rel_expression");
						} 	
		 ;
			
rel_expression: simple_expression	{
							PrintGrammar(lineCount, "rel_expression	: simple_expression");
						} 
		| simple_expression RELOP simple_expression	{
							PrintGrammar(lineCount, "rel_expression	: simple_expression RELOP simple_expression");
						}	
		;
				
simple_expression: term	{
							PrintGrammar(lineCount, "simple_expression : term");
						} 
		  | simple_expression ADDOP term	{
							PrintGrammar(lineCount, "simple_expression : simple_expression ADDOP term");
						} 
		  ;
					
term:	unary_expression	{
							PrintGrammar(lineCount, "term :	unary_expression");
						}
     |  term MULOP unary_expression	{
							PrintGrammar(lineCount, "term :	term MULOP unary_expression");
						}
     ;

unary_expression: ADDOP unary_expression	{
							PrintGrammar(lineCount, "unary_expression : ADDOP unary_expression");
						}  
		 | NOT unary_expression	{
							PrintGrammar(lineCount, "unary_expression : NOT unary_expression");
						} 
		 | factor	{
							PrintGrammar(lineCount, "unary_expression : factor");
						} 
		 ;
	
factor: variable	{
							PrintGrammar(lineCount, "factor	: variable");
						} 
	| ID LPAREN argument_list RPAREN	{
							PrintGrammar(lineCount, "factor	: ID LPAREN argument_list RPAREN");
						}
	| LPAREN expression RPAREN	{
							PrintGrammar(lineCount, "factor	: LPAREN expression RPAREN");
						}
	| CONST_INT	{
							PrintGrammar(lineCount, "factor	: variCONST_INTable");
						} 
	| CONST_FLOAT	{
							PrintGrammar(lineCount, "factor	: CONST_FLOAT");
						}
	| variable INCOP	{
							PrintGrammar(lineCount, "factor	: variable INCOP");
						} 
	| variable DECOP	{
							PrintGrammar(lineCount, "factor	: variable DECOP");
						}
	;
	
argument_list: arguments	{
							PrintGrammar(lineCount, "argument_list : arguments");
						}
			  |
			  ;
	
arguments: arguments COMMA logic_expression	{
							PrintGrammar(lineCount, "arguments : arguments COMMA logic_expression");
						}
	      | logic_expression	{
							PrintGrammar(lineCount, "arguments : logic_expression");
						}
	      ;
 

%%
int main(int argc,char *argv[])
{
	if(argc!=2){
		printf("Please provide input file name and try again\n");
		return 0;
	}
	
	FILE *fin=fopen(argv[1],"r");
	if(fin==NULL){
		printf("Cannot open specified file\n");
		return 0;
	}
	

	yyin= fin;
	yyparse();
	fclose(yyin);
	return 0;
}

