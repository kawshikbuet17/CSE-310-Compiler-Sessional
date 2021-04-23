%{
#include<bits/stdc++.h>
#include<iostream>
#include<cstdlib>
#include<cstring>
#include<cmath>
#include "symbol_table.cpp"
#define NIL NULL
// #define YYSTYPE SymbolInfo*

using namespace std;

int yyparse(void);
int yylex(void);
extern FILE *yyin;

SymbolTable* symbolTable = new SymbolTable(31);


int lineCount = 1;
int errorCount = 0;

string symbolName;
string symbolType;
string currentType = "void";
string currentTypeValue = "void";

string op1 = "void";
string op2 = "void";


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

void PrintError(int lineNo, string errorName){
	log_file << "Error at line no: " << lineNo << " "<<errorName << "\n"  << endl;
	error_file << "Error at line no: " << lineNo << " "<<errorName << "\n"  << endl;
}

void DebugPrint(int lineNo, string debug){
	cout << "Debug line no: " << lineNo << debug <<endl;
}


vector<SymbolInfo> params_list;



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
		$$ = new SymbolInfo(symbolName, "dummyType");
		symbolTable->PrintAllTables(log_file);

		log_file<<"Total Lines: "<<lineCount<<endl;
		log_file<<"Total Errors: "<<errorCount<<endl;
	}
	;

program: program unit	{
							PrintGrammar(lineCount, "program : program unit");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	| unit	{
				PrintGrammar(lineCount, "program : unit");
				symbolName = $1->getSymbolName();
				symbolType = $1->getSymbolType();
				PrintToken(symbolName);
				$$ = new SymbolInfo(symbolName, "dummyType");
			}
	;
	
unit: var_declaration	{
							PrintGrammar(lineCount, "unit : var_declaration");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
     | func_declaration	{
							PrintGrammar(lineCount, "unit : func_declaration");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "func_declaration");
						}
     | func_definition	{
							PrintGrammar(lineCount, "unit : func_definition");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "func_definition");
						}
     ;
     
func_declaration: type_specifier ID LPAREN parameter_list RPAREN SEMICOLON	{
							PrintGrammar(lineCount, "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName()+"\n";

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($2->getSymbolName(), $2->getSymbolType());

							ScopeTable* sc = symbolTable->getCurrentScope();
							if(sc->LookupBoolean(temp->getSymbolName())){
								++errorCount;
								PrintError(lineCount, "Multiple Declaration");
							}
							symbolTable->Insert(*temp);
						}
		| type_specifier ID LPAREN RPAREN SEMICOLON	{
							PrintGrammar(lineCount, "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+"\n";

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($2->getSymbolName(), $2->getSymbolType());
							
							ScopeTable* sc = symbolTable->getCurrentScope();
							if(sc->LookupBoolean(temp->getSymbolName())){
								++errorCount;
								PrintError(lineCount, "Multiple Declaration");
							}
							
							symbolTable->Insert(*temp);
						}
		;
		 
func_definition: type_specifier ID LPAREN parameter_list RPAREN compound_statement	{
							PrintGrammar(lineCount, "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName();

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($2->getSymbolName(), $2->getSymbolType());

							symbolTable->Insert(*temp);
						}
		| type_specifier ID LPAREN RPAREN compound_statement	{
							PrintGrammar(lineCount, "func_definition : type_specifier ID LPAREN RPAREN compound_statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($2->getSymbolName(), $2->getSymbolType());
							
							symbolTable->Insert(*temp);
						}
 		;				


parameter_list: parameter_list COMMA type_specifier ID	{
							PrintGrammar(lineCount, "parameter_list  : parameter_list COMMA type_specifier ID");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($4->getSymbolName(), $4->getSymbolType());
							//symbolTable->Insert(*temp);
						}
		| parameter_list COMMA type_specifier	{
							PrintGrammar(lineCount, "parameter_list  : parameter_list COMMA type_specifier");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
 		| type_specifier ID	{
							PrintGrammar(lineCount, "parameter_list  : type_specifier ID");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($2->getSymbolName(), $2->getSymbolType());
							//symbolTable->Insert(*temp);
						}
		| type_specifier	{
							PrintGrammar(lineCount, "parameter_list  : type_specifier");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
 		;

 		
compound_statement: LCURL dummy_enterScope statements RCURL	{
							PrintGrammar(lineCount, "compound_statement : LCURL statements RCURL");
							symbolName = $1->getSymbolName()+"\n"+$3->getSymbolName()+"\n"+$4->getSymbolName();
							symbolType = $1->getSymbolType()+"\n"+$3->getSymbolType()+"\n"+$4->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
							symbolTable->PrintAllTables(log_file);
							symbolTable->ExitScope();
						}
 		    | LCURL dummy_enterScope RCURL	{
							PrintGrammar(lineCount, "compound_statement : LCURL RCURL");
							symbolName = $1->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
							symbolTable->PrintAllTables(log_file);
							symbolTable->ExitScope();
						}
 		    ;

dummy_enterScope:	{
						symbolTable->EnterScope();
					}

var_declaration: type_specifier declaration_list SEMICOLON	{
							PrintGrammar(lineCount, "var_declaration : type_specifier declaration_list SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+"\n";
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+"\n";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
 		 ;
 		 
type_specifier: INT	{
							PrintGrammar(lineCount, "type_specifier	: INT");
							symbolName = $1->getSymbolName()+" ";
							symbolType = $1->getSymbolType()+" ";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							currentType = "int";
						}
 		| FLOAT	{
							PrintGrammar(lineCount, "type_specifier	: FLOAT");
							symbolName = $1->getSymbolName()+" ";
							symbolType = $1->getSymbolType()+" ";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							currentType = "float";
						}
 		| VOID	{
							PrintGrammar(lineCount, "type_specifier	: VOID");
							symbolName = $1->getSymbolName()+" ";
							symbolType = $1->getSymbolType()+" ";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							currentType = "void";
						}
 		;
 		
declaration_list: declaration_list COMMA ID	{
							PrintGrammar(lineCount, "declaration_list : declaration_list COMMA ID");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($3->getSymbolName(), $3->getSymbolType());
							temp->addParams(currentType);

							ScopeTable* sc = symbolTable->getCurrentScope();
							if(sc->LookupBoolean(temp->getSymbolName())){
								++errorCount;
								PrintError(lineCount, "Multiple Declaration");
							}

							symbolTable->Insert(*temp);
						}
 		  | declaration_list COMMA ID LTHIRD CONST_INT RTHIRD	{
							PrintGrammar(lineCount, "declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName();

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($3->getSymbolName(), $3->getSymbolType());
							temp->addParams(currentType);
							temp->addParams($5->getSymbolName());

							ScopeTable* sc = symbolTable->getCurrentScope();
							if(sc->LookupBoolean(temp->getSymbolName())){
								++errorCount;
								PrintError(lineCount, "Multiple Declaration");
							}

							symbolTable->Insert(*temp);
						}
 		  | ID	{
							PrintGrammar(lineCount, "declaration_list : ID");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo(symbolName, symbolType);
							temp->addParams(currentType);

							ScopeTable* sc = symbolTable->getCurrentScope();
							if(sc->LookupBoolean(temp->getSymbolName())){
								++errorCount;
								PrintError(lineCount, "Multiple Declaration");
							}

							symbolTable->Insert(*temp);
						}
 		  | ID LTHIRD CONST_INT RTHIRD	{
							PrintGrammar(lineCount, "declaration_list : ID LTHIRD CONST_INT RTHIRD");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();
	
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($1->getSymbolName(), $1->getSymbolType());
							temp->addParams(currentType);
							temp->addParams($3->getSymbolName());
							

							ScopeTable* sc = symbolTable->getCurrentScope();
							if(sc->LookupBoolean(temp->getSymbolName())){
								++errorCount;
								PrintError(lineCount, "Multiple Declaration");
							}

							symbolTable->Insert(*temp);
						}
 		  ;
 		  
statements: statement	{
							PrintGrammar(lineCount, "statements : statement");
							symbolName = $1->getSymbolName();

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	   | statements statement	{
							PrintGrammar(lineCount, "statements : statements statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	   ;
	   
statement: var_declaration	{
							PrintGrammar(lineCount, "statement : var_declaration");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | expression_statement	{
							PrintGrammar(lineCount, "statement : expression_statement");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | compound_statement	{
							PrintGrammar(lineCount, "statement : compound_statement");
							symbolName = $1->getSymbolName();
							symbolType = $1->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | FOR LPAREN expression_statement expression_statement expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName()+" "+$7->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType()+" "+$6->getSymbolType()+" "+$7->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | IF LPAREN expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : IF LPAREN expression RPAREN statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | IF LPAREN expression RPAREN statement ELSE statement	{
							PrintGrammar(lineCount, "statement : IF LPAREN expression RPAREN statement ELSE statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName()+" "+$7->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType()+" "+$6->getSymbolType()+" "+$7->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

						}
	  | WHILE LPAREN expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : WHILE LPAREN expression RPAREN statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | PRINTLN LPAREN ID RPAREN SEMICOLON	{
							PrintGrammar(lineCount, "statement : PRINTLN LPAREN ID RPAREN SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+"\n";
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+" "+$4->getSymbolType()+" "+$5->getSymbolType()+"\n";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($3->getSymbolName(), $3->getSymbolType());
							symbolTable->Insert(*temp);
						}
	  | RETURN expression SEMICOLON	{
							PrintGrammar(lineCount, "statement : RETURN expression SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+"\n";
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+"\n";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  ;
	  
expression_statement: SEMICOLON	{
							PrintGrammar(lineCount, "expression_statement 	: SEMICOLON");
							symbolName = $1->getSymbolName()+"\n";
							symbolType = $1->getSymbolType()+"\n";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}			
			| expression SEMICOLON	{
							PrintGrammar(lineCount, "expression_statement 	: expression SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+"\n";
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+"\n";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						} 
			;
	  
variable: ID	{
							PrintGrammar(lineCount, "variable : ID");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							SymbolInfo* t = symbolTable->Lookup(symbolName);
							if(t == NIL){
								PrintError(lineCount, "Variable not declared");
								++errorCount;
							}else{
								$$ = t;
							}
							
						} 		
	 | ID LTHIRD expression RTHIRD	{
							PrintGrammar(lineCount, "variable : ID LTHIRD expression RTHIRD");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();
							PrintToken(symbolName);

							SymbolInfo* t = symbolTable->Lookup($1->getSymbolName());
							if(t == NIL){
								PrintError(lineCount, "Variable not declared ");
								++errorCount;
								$$ = new SymbolInfo(symbolName, "array");
							}else{
								if($3->getParams(0) != t->getParams(0)){
									PrintError(lineCount, "Array Index Error");
									++errorCount;
								}
								else{
									;
								}

								$$ = t;
								$$->addParams($3->getSymbolName());
								$$->setSymbolName(symbolName);
							}
						} 
	 ;
	 
 expression: logic_expression	{
							PrintGrammar(lineCount, "expression : logic_expression");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = $1;
						}	
	   | variable ASSIGNOP logic_expression	{
							PrintGrammar(lineCount, "expression : variable ASSIGNOP logic_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
							
							if($1->getParamsSize()==0 || $3->getParamsSize()==0){
										PrintError(lineCount, "ASSIGNOP Error");
										++errorCount;
									}
							else if(($1->getParams(0) != $3->getParams(0)) && $1->getParams(0)!="float"){
										PrintError(lineCount, "Type Mismatch");
										++errorCount;
									}
						} 	
	   ;
			
logic_expression: rel_expression	{
							PrintGrammar(lineCount, "logic_expression : rel_expression");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = $1;
						} 	
		 | rel_expression LOGICOP rel_expression	{
							PrintGrammar(lineCount, "logic_expression : rel_expression LOGICOP rel_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						} 	
		 ;
			
rel_expression: simple_expression	{
							PrintGrammar(lineCount, "rel_expression	: simple_expression");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = $1;
						} 
		| simple_expression RELOP simple_expression	{
							PrintGrammar(lineCount, "rel_expression	: simple_expression RELOP simple_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();;
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}	
		;
				
simple_expression: term	{
							PrintGrammar(lineCount, "simple_expression : term");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = $1;
						} 
		  | simple_expression ADDOP term	{
							PrintGrammar(lineCount, "simple_expression : simple_expression ADDOP term");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							PrintToken(symbolName);

							if($1 != NIL && $3 != NIL){
								if($1->getParams(0) == "float"){
									$$ = $1;
								}else if($3->getParams(0)=="float"){
									$$ = $3;
								}
							}
							else{
								PrintError(lineCount, "Invalid ADDOP");
							}
							$$ = new SymbolInfo(symbolName, "dummyType");
						} 
		  ;
					
term:	unary_expression	{
							PrintGrammar(lineCount, "term :	unary_expression");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = $1;
						}
     |  term MULOP unary_expression	{
							PrintGrammar(lineCount, "term :	term MULOP unary_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
     ;

unary_expression: ADDOP unary_expression	{
							PrintGrammar(lineCount, "unary_expression : ADDOP unary_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}  
		 | NOT unary_expression	{
							PrintGrammar(lineCount, "unary_expression : NOT unary_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						} 
		 | factor	{
							PrintGrammar(lineCount, "unary_expression : factor");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = $1;
						} 
		 ;
	
factor: variable	{
							PrintGrammar(lineCount, "factor	: variable");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							SymbolInfo* t = symbolTable->Lookup(symbolName);
							if(t == NIL){
								PrintError(lineCount, "Variable not declared");
								++errorCount;
								$$ = t;	
							}else{
								$$ = t;	
								currentTypeValue = t->getParams(0);
							}
						} 

	| ID LPAREN argument_list RPAREN	{
							PrintGrammar(lineCount, "factor	: ID LPAREN argument_list RPAREN");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();

							SymbolInfo* t = symbolTable->Lookup($1->getSymbolName());
							if(t == NIL){
								PrintError(lineCount, "Variable not declared");
								++errorCount;
							}
							else{
								$$ = $1;
								$$->addParams($3->getSymbolName());
							}

							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($1->getSymbolName(), $1->getSymbolType());
							symbolTable->Insert(*temp);
						}
	| LPAREN expression RPAREN	{
							PrintGrammar(lineCount, "factor	: LPAREN expression RPAREN");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	| CONST_INT	{
							PrintGrammar(lineCount, "factor	: CONST_INT");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "CONST_INT");
							$$->addParams("int");

							currentTypeValue = "int";
						} 
	| CONST_FLOAT	{
							PrintGrammar(lineCount, "factor	: CONST_FLOAT");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "CONST_FLOAT");
							$$->addParams("float");

							currentTypeValue = "float";
						}
	| variable INCOP	{
							PrintGrammar(lineCount, "factor	: variable INCOP");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						} 
	| variable DECOP	{
							PrintGrammar(lineCount, "factor	: variable DECOP");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	;
	
argument_list: arguments	{
							PrintGrammar(lineCount, "argument_list : arguments");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = $1;
						}
			  
			  ;
	
arguments: arguments COMMA logic_expression	{
							PrintGrammar(lineCount, "arguments : arguments COMMA logic_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	      | logic_expression	{
							PrintGrammar(lineCount, "arguments : logic_expression");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = $1;
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

