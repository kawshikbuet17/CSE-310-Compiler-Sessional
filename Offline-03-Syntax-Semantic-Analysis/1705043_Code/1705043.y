%{
#include<bits/stdc++.h>
#include<iostream>
#include<cstdlib>
#include<cstring>
#include<cmath>
#include "symbol_table.cpp"
// #define YYSTYPE SymbolInfo*

using namespace std;

int yyparse(void);
int yylex(void);
extern FILE *yyin;

SymbolTable* symbolTable = new SymbolTable(7);

int lineCount = 1;
int errorCount = 0;

string symbolName;
string symbolType;

void yyerror(char *s)
{
	//write your code
}

ofstream log_file("1705043_log.txt");
ofstream error_file("1705043_error.txt");

void PrintGrammar(int lineNo, string grammarName){
	log_file << "At line no: " << lineNo << " "<<grammarName << "\n"  << endl;
}

void PrintToken(string tokenName){
	log_file << tokenName<< "\n" << endl;
}


%}


%union	{SymbolInfo* si; vector<SymbolInfo*>* vec;}
%token <si> ADDOP MULOP INCOP RELOP ID CONST_INT CONST_FLOAT IF ELSE FOR WHILE DO BREAK CHAR FLOAT DOUBLE VOID RETURN CONTINUE PRINTLN ASSIGNOP LOGICOP NOT LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COMMA SEMICOLON DECOP INT

%type <si> start program unit func_declaration func_definition parameter_list compound_statement var_declaration type_specifier declaration_list statements statement expression_statement variable expression logic_expression rel_expression simple_expression term unary_expression factor argument_list arguments
// %left 
// %right

// %nonassoc 


%%

start: program
	{
		//write your code in this block in all the similar blocks below
		PrintGrammar(lineCount, "start : program");
		symbolName = $1->getSymbolName();
		symbolType = $1->getSymbolType();
		PrintToken(symbolName);
		$$ = new SymbolInfo(symbolName, "non_terminal");
	}
	;

program: program unit	{
							PrintGrammar(lineCount, "program : program unit");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	| unit	{
				PrintGrammar(lineCount, "program : unit");
				symbolName = $1->getSymbolName();
				symbolType = $1->getSymbolType();
				PrintToken(symbolName);
				$$ = new SymbolInfo(symbolName, "non_terminal");
			}
	;
	
unit: var_declaration	{
							PrintGrammar(lineCount, "unit : var_declaration");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
     | func_declaration	{
							PrintGrammar(lineCount, "unit : func_declaration");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
     | func_definition	{
							PrintGrammar(lineCount, "unit : func_definition");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
     ;
     
func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON	{
							PrintGrammar(lineCount, "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType()+" "+$6->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
		| type_specifier ID LPAREN RPAREN SEMICOLON	{
							PrintGrammar(lineCount, "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
		;
		 
func_definition: type_specifier ID LPAREN parameter_list RPAREN compound_statement	{
							PrintGrammar(lineCount, "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType()+" "+$6->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
		| type_specifier ID LPAREN RPAREN compound_statement	{
							PrintGrammar(lineCount, "func_definition : type_specifier ID LPAREN RPAREN compound_statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
 		;				


parameter_list: parameter_list COMMA type_specifier ID	{
							PrintGrammar(lineCount, "parameter_list  : parameter_list COMMA type_specifier ID");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
		| parameter_list COMMA type_specifier	{
							PrintGrammar(lineCount, "parameter_list  : parameter_list COMMA type_specifier");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
 		| type_specifier ID	{
							PrintGrammar(lineCount, "parameter_list  : type_specifier ID");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
		| type_specifier	{
							PrintGrammar(lineCount, "parameter_list  : type_specifier");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
 		;

 		
compound_statement: LCURL statements RCURL	{
							PrintGrammar(lineCount, "compound_statement : LCURL statements RCURL");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
 		    | LCURL RCURL	{
							PrintGrammar(lineCount, "compound_statement : LCURL RCURL");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
 		    ;
 		    
var_declaration: type_specifier declaration_list SEMICOLON	{
							PrintGrammar(lineCount, "var_declaration : type_specifier declaration_list SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
 		 ;
 		 
type_specifier: INT	{
							PrintGrammar(lineCount, "type_specifier	: INT");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
 		| FLOAT	{
							PrintGrammar(lineCount, "type_specifier	: FLOAT");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
 		| VOID	{
							PrintGrammar(lineCount, "type_specifier	: VOID");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
 		;
 		
declaration_list: declaration_list COMMA ID	{
							PrintGrammar(lineCount, "declaration_list : declaration_list COMMA ID");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");

						}
 		  | declaration_list COMMA ID LTHIRD CONST_INT RTHIRD	{
							PrintGrammar(lineCount, "declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType()+" "+$6->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
 		  | ID	{
							PrintGrammar(lineCount, "declaration_list : ID");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
 		  | ID LTHIRD CONST_INT RTHIRD	{
							PrintGrammar(lineCount, "declaration_list : ID LTHIRD CONST_INT RTHIRD");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
 		  ;
 		  
statements: statement	{
							PrintGrammar(lineCount, "statements : statement");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	   | statements statement	{
							PrintGrammar(lineCount, "statements : statements statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	   ;
	   
statement: var_declaration	{
							PrintGrammar(lineCount, "statement : var_declaration");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	  | expression_statement	{
							PrintGrammar(lineCount, "statement : expression_statement");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	  | compound_statement	{
							PrintGrammar(lineCount, "statement : compound_statement");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	  | FOR LPAREN expression_statement expression_statement expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName()+" "+$7->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType()+" "+$6->getSymbolType()+" "+$7->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	  | IF LPAREN expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : IF LPAREN expression RPAREN statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	  | IF LPAREN expression RPAREN statement ELSE statement	{
							PrintGrammar(lineCount, "statement : IF LPAREN expression RPAREN statement ELSE statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName()+" "+$7->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType()+" "+$6->getSymbolType()+" "+$7->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");

						}
	  | WHILE LPAREN expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : WHILE LPAREN expression RPAREN statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	  | PRINTLN LPAREN ID RPAREN SEMICOLON	{
							PrintGrammar(lineCount, "statement : PRINTLN LPAREN ID RPAREN SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
	  | RETURN expression SEMICOLON	{
							PrintGrammar(lineCount, "statement : RETURN expression SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}
	  ;
	  
expression_statement: SEMICOLON	{
							PrintGrammar(lineCount, "expression_statement 	: SEMICOLON");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "terminal");
						}			
			| expression SEMICOLON	{
							PrintGrammar(lineCount, "expression_statement 	: expression SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 
			;
	  
variable: ID	{
							PrintGrammar(lineCount, "variable : ID");

							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();

							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "non_terminal");

							SymbolInfo *temp = new SymbolInfo(symbolName, symbolType);
							symbolTable->Insert(*temp);

						} 		
	 | ID LTHIRD expression RTHIRD	{
							PrintGrammar(lineCount, "variable : ID LTHIRD expression RTHIRD");

							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 
	 ;
	 
 expression: logic_expression	{
							PrintGrammar(lineCount, "expression : logic_expression");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();

							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "non_terminal");
						}	
	   | variable ASSIGNOP logic_expression	{
							PrintGrammar(lineCount, "expression : variable ASSIGNOP logic_expression");

							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();

							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 	
	   ;
			
logic_expression: rel_expression	{
							PrintGrammar(lineCount, "logic_expression : rel_expression");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 	
		 | rel_expression LOGICOP rel_expression	{
							PrintGrammar(lineCount, "logic_expression : rel_expression LOGICOP rel_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 	
		 ;
			
rel_expression: simple_expression	{
							PrintGrammar(lineCount, "rel_expression	: simple_expression");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 
		| simple_expression RELOP simple_expression	{
							PrintGrammar(lineCount, "rel_expression	: simple_expression RELOP simple_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}	
		;
				
simple_expression: term	{
							PrintGrammar(lineCount, "simple_expression : term");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 
		  | simple_expression ADDOP term	{
							PrintGrammar(lineCount, "simple_expression : simple_expression ADDOP term");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 
		  ;
					
term:	unary_expression	{
							PrintGrammar(lineCount, "term :	unary_expression");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
     |  term MULOP unary_expression	{
							PrintGrammar(lineCount, "term :	term MULOP unary_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
     ;

unary_expression: ADDOP unary_expression	{
							PrintGrammar(lineCount, "unary_expression : ADDOP unary_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}  
		 | NOT unary_expression	{
							PrintGrammar(lineCount, "unary_expression : NOT unary_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 
		 | factor	{
							PrintGrammar(lineCount, "unary_expression : factor");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 
		 ;
	
factor: variable	{
							PrintGrammar(lineCount, "factor	: variable");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 
	| ID LPAREN argument_list RPAREN	{
							PrintGrammar(lineCount, "factor	: ID LPAREN argument_list RPAREN");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	| LPAREN expression RPAREN	{
							PrintGrammar(lineCount, "factor	: LPAREN expression RPAREN");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	| CONST_INT	{
							PrintGrammar(lineCount, "factor	: CONST_INT");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 
	| CONST_FLOAT	{
							PrintGrammar(lineCount, "factor	: CONST_FLOAT");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	| variable INCOP	{
							PrintGrammar(lineCount, "factor	: variable INCOP");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						} 
	| variable DECOP	{
							PrintGrammar(lineCount, "factor	: variable DECOP");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	;
	
argument_list: arguments	{
							PrintGrammar(lineCount, "argument_list : arguments");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
			  
			  ;
	
arguments: arguments COMMA logic_expression	{
							PrintGrammar(lineCount, "arguments : arguments COMMA logic_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
						}
	      | logic_expression	{
							PrintGrammar(lineCount, "arguments : logic_expression");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "non_terminal");
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

