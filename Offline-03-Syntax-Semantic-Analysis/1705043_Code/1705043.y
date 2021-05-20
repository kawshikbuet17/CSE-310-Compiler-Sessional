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

SymbolTable* symbolTable = new SymbolTable(30);

int lineCount = 1;
int errorCount = 0;

string symbolName;
string symbolType;
string currentType = "void";
string currentFunction = "global";
string currentCalled = "global";

void yyerror(char *s)
{
	//write your code
}

ofstream log_file("1705043_log.txt");
ofstream error_file("1705043_error.txt");

void PrintGrammar(int lineNo, string grammarName){
	log_file << "Line " << lineNo << ": "<<grammarName << "\n"  << endl;
}

void PrintToken(string tokenName){
	log_file << tokenName<< "\n" << endl;
}

void PrintError(int lineNo, string errorName){
	log_file << "Error at line " << lineNo << " : "<<errorName << "\n"  << endl;
	error_file << "Error at line " << lineNo << " : "<<errorName << "\n"  << endl;
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
		//PrintToken(symbolName);
		$$ = new SymbolInfo(symbolName, "dummyType");
		symbolTable->PrintAllTables(log_file);

		log_file<<"Total lines: "<<lineCount<<endl;
		log_file<<"Total errors: "<<errorCount<<endl;
	}
	;

program: program unit	{
							PrintGrammar(lineCount, "program : program unit");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	| unit	{
				PrintGrammar(lineCount, "program : unit");
				symbolName = $1->getSymbolName();
				PrintToken(symbolName);
				$$ = new SymbolInfo(symbolName, "dummyType");
			}
	;
	
unit: var_declaration	{
							PrintGrammar(lineCount, "unit : var_declaration");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
     | func_declaration	{
							PrintGrammar(lineCount, "unit : func_declaration");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "func_declaration");
						}
     | func_definition	{
							PrintGrammar(lineCount, "unit : func_definition");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "func_definition");
						}
     ;
     
func_declaration: type_specifier ID LPAREN parameter_list RPAREN {
		currentFunction = $2->getSymbolName();
		if(symbolTable->Lookup(currentFunction) == NIL){
			SymbolInfo* temp = new SymbolInfo(currentFunction, "ID");
			for(auto i : params_list){
				temp->addFuncParams(i);
			}
			temp->setStructType("func");
			temp->setDataType($1->getSymbolName());
			params_list.clear();
			symbolTable->Insert(*temp);
		}
		else{
			PrintError(lineCount, "Multiple declaration of "+currentFunction);
			++errorCount;
		}
	} SEMICOLON	{
							PrintGrammar(lineCount, "func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$7->getSymbolName()+"\n";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "func");
						}
		| type_specifier ID LPAREN RPAREN {
			currentFunction=$2->getSymbolName();
			if(symbolTable->Lookup(currentFunction) == NIL){
				SymbolInfo* temp = new SymbolInfo(currentFunction, "ID");
				symbolTable->Insert(*temp);
			}
			else{
				PrintError(lineCount, "Multiple declaration of "+currentFunction);
				++errorCount;
			}
		} SEMICOLON	{
							PrintGrammar(lineCount, "func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$6->getSymbolName()+"\n";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
						}
		;
		 
func_definition: type_specifier ID LPAREN parameter_list RPAREN {
	currentFunction=$2->getSymbolName();
	if(symbolTable->Lookup(currentFunction) == NIL){
		SymbolInfo* temp = new SymbolInfo(currentFunction, "ID");
		for(auto i : params_list){
			temp->addFuncParams(i);
		}
		temp->setStructType("func");
		temp->setDataType($1->getSymbolName());
		params_list.clear();
		symbolTable->Insert(*temp);
	}
	else{
		SymbolInfo* temp = symbolTable->Lookup(currentFunction);
		if(temp->getStructType() != "func"){
			PrintError(lineCount, "Multiple declaration of "+currentFunction);
			++errorCount;

			SymbolInfo* temp = new SymbolInfo(currentFunction, "ID");
			for(auto i : params_list){
				temp->addFuncParams(i);
			}
			temp->setStructType("func");
			temp->setDataType($1->getSymbolName());
			params_list.clear();
		}
		else{
			vector<SymbolInfo> v = temp->getFuncParams();
			if($1->getSymbolName() != temp->getDataType()){
				PrintError(lineCount, "Return type mismatch with function declaration in function "+temp->getSymbolName());
				++errorCount;
			}
			if(v.size() != params_list.size()){
				PrintError(lineCount, "Total number of arguments mismatch with declaration in function "+currentFunction);
				++errorCount;
			}
			else{
				for(int i; i<v.size(); i++){
					if(params_list[i].getDataType() != v[i].getDataType()){
						PrintError(lineCount, currentFunction+" parameter type error");
						++errorCount;
					}
				}
				temp->clearFuncParams();
				for(auto i : params_list){
					temp->addFuncParams(i);
				}
				params_list.clear();
			}
		}
		
	}
	
} compound_statement	{
							PrintGrammar(lineCount, "func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$7->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "func");							
						}
		| type_specifier ID LPAREN RPAREN {
			currentFunction=$2->getSymbolName();
			if(symbolTable->Lookup(currentFunction) == NIL){
				SymbolInfo* temp = new SymbolInfo(currentFunction, "ID");
				temp->setStructType("func");
				temp->setDataType($1->getSymbolName());
				symbolTable->Insert(*temp);
			}
			
	} compound_statement	{
							PrintGrammar(lineCount, "func_definition : type_specifier ID LPAREN RPAREN compound_statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$6->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						}
 		;				


parameter_list: parameter_list COMMA type_specifier ID	{
							PrintGrammar(lineCount, "parameter_list  : parameter_list COMMA type_specifier ID");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();
							

							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($4->getSymbolName(), $4->getSymbolType());
							temp->setStructType("var");
							temp->setDataType($3->getSymbolName());
							temp->addParams($3->getSymbolName());
							bool found = false;
							for(auto i:params_list){
								if(i.getSymbolName() == temp->getSymbolName()){
									PrintError(lineCount, "Multiple declaration of "+i.getSymbolName()+" in parameter");
									++errorCount;
									found = true;
									break;
								}
							}
							if(found == false){
								params_list.push_back(*temp);
							}
							PrintToken(symbolName);
						}
		| parameter_list COMMA type_specifier	{
							PrintGrammar(lineCount, "parameter_list  : parameter_list COMMA type_specifier");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($3->getSymbolName(), $3->getSymbolType());
							temp->setStructType("var");
							temp->setDataType($3->getSymbolName());
							temp->addParams($3->getSymbolName());
							params_list.push_back(*temp);
						}
 		| type_specifier ID	{
							PrintGrammar(lineCount, "parameter_list  : type_specifier ID");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($2->getSymbolName(), $2->getSymbolType());
							temp->setStructType("var");
							temp->setDataType($1->getSymbolName());
							temp->addParams($1->getSymbolName());
							params_list.push_back(*temp);
						}
		| type_specifier	{
							PrintGrammar(lineCount, "parameter_list  : type_specifier");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($1->getSymbolName(), $1->getSymbolType());
							temp->setStructType("var");
							temp->setDataType($1->getSymbolName());
							temp->addParams($1->getSymbolName());
							params_list.push_back(*temp);
						}
 		;

 		
compound_statement: LCURL dummy_enterScope statements RCURL	{
							PrintGrammar(lineCount, "compound_statement : LCURL statements RCURL");
							symbolName = $1->getSymbolName()+"\n"+$3->getSymbolName()+$4->getSymbolName()+"\n";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							symbolTable->PrintAllTables(log_file);
							symbolTable->ExitScope();
						}
 		    | LCURL dummy_enterScope RCURL	{
							PrintGrammar(lineCount, "compound_statement : LCURL RCURL");
							symbolName = $1->getSymbolName()+" "+$3->getSymbolName()+"\n";
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
 
							symbolTable->ExitScope();
							symbolTable->PrintAllTables(log_file);
						}
 		    ;

dummy_enterScope:	{
						symbolTable->EnterScope();
						SymbolInfo* temp = symbolTable->Lookup(currentFunction);
						vector<SymbolInfo> v = temp->getFuncParams();
						for(auto i : v){
							symbolTable->Insert(i);
						}
						params_list.clear();
					}
	;
var_declaration: type_specifier declaration_list SEMICOLON	{
							PrintGrammar(lineCount, "var_declaration : type_specifier declaration_list SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+"\n";
							symbolType = $1->getSymbolType()+" "+$2->getSymbolType()+" "+$3->getSymbolType()+"\n";
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");

							if($1->getSymbolName() == "void"){
								PrintError(lineCount, "Variable type cannot be void");
								++errorCount;
							}
						}
 		 ;
 		 
type_specifier: INT	{
							PrintGrammar(lineCount, "type_specifier	: INT");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");

							currentType = "int";
						}
 		| FLOAT	{
							PrintGrammar(lineCount, "type_specifier	: FLOAT");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");

							currentType = "float";
						}
 		| VOID	{
							PrintGrammar(lineCount, "type_specifier	: VOID");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");

							currentType = "void";
						}
 		;
 		
declaration_list: declaration_list COMMA ID	{
							PrintGrammar(lineCount, "declaration_list : declaration_list COMMA ID");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($3->getSymbolName(), $3->getSymbolType());
							temp->setStructType("var");
							temp->setDataType(currentType);

							ScopeTable* sc = symbolTable->getCurrentScope();
							if(sc->LookupBoolean(temp->getSymbolName())){
								++errorCount;
								PrintError(lineCount,  "Multiple declaration of "+temp->getSymbolName());
							}
							PrintToken(symbolName);
							if(currentType != "void"){
								symbolTable->Insert(*temp);
							}

						}
 		  | declaration_list COMMA ID LTHIRD CONST_INT RTHIRD	{
							PrintGrammar(lineCount, "declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName();
							

							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($3->getSymbolName(), $3->getSymbolType());
							temp->setStructType("array");
							temp->setDataType(currentType);
							temp->addParams($5->getSymbolName());

							ScopeTable* sc = symbolTable->getCurrentScope();
							if(sc->LookupBoolean(temp->getSymbolName())){
								++errorCount;
								PrintError(lineCount, "Multiple declaration of "+temp->getSymbolName());
							}
							PrintToken(symbolName);
							if(currentType != "void"){
								symbolTable->Insert(*temp);
							}
						}
 		  | ID	{
							PrintGrammar(lineCount, "declaration_list : ID");
							symbolName = $1->getSymbolName();
							

							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo(symbolName, $1->getSymbolType());
							temp->setStructType("var");
							temp->setDataType(currentType);

							ScopeTable* sc = symbolTable->getCurrentScope();
							if(sc->LookupBoolean(temp->getSymbolName())){
								++errorCount;
								PrintError(lineCount, "Multiple declaration of "+temp->getSymbolName());
							}
							PrintToken(symbolName);
							if(currentType != "void"){
								symbolTable->Insert(*temp);
							}
						}
 		  | ID LTHIRD CONST_INT RTHIRD	{
							PrintGrammar(lineCount, "declaration_list : ID LTHIRD CONST_INT RTHIRD");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();
							
							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* temp = new SymbolInfo($1->getSymbolName(), $1->getSymbolType());
							temp->setStructType("array");
							temp->setDataType(currentType);
							temp->addParams($3->getSymbolName());
							
							ScopeTable* sc = symbolTable->getCurrentScope();
							if(sc->LookupBoolean(temp->getSymbolName())){
								++errorCount;
								PrintError(lineCount, "Multiple declaration of "+temp->getSymbolName());
							}					
							PrintToken(symbolName);	
							if(currentType != "void"){
								symbolTable->Insert(*temp);
							}
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
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | expression_statement	{
							PrintGrammar(lineCount, "statement : expression_statement");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | compound_statement	{
							PrintGrammar(lineCount, "statement : compound_statement");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | FOR LPAREN expression_statement expression_statement expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName()+" "+$7->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | IF LPAREN expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : IF LPAREN expression RPAREN statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | IF LPAREN expression RPAREN statement ELSE statement	{
							PrintGrammar(lineCount, "statement : IF LPAREN expression RPAREN statement ELSE statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+" "+$6->getSymbolName()+" "+$7->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | WHILE LPAREN expression RPAREN statement	{
							PrintGrammar(lineCount, "statement : WHILE LPAREN expression RPAREN statement");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  | PRINTLN LPAREN ID RPAREN SEMICOLON	{
							PrintGrammar(lineCount, "statement : PRINTLN LPAREN ID RPAREN SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName()+"\n";
							

							$$ = new SymbolInfo(symbolName, "dummyType");

							SymbolInfo* t = symbolTable->Lookup($3->getSymbolName());
							if(t==NIL){
								PrintError(lineCount, "Undeclared variable "+$3->getSymbolName());
							}
							PrintToken(symbolName);
						}
	  | RETURN expression SEMICOLON	{
							PrintGrammar(lineCount, "statement : RETURN expression SEMICOLON");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+"\n";
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						}
	  ;
	  
expression_statement: SEMICOLON	{
							PrintGrammar(lineCount, "expression_statement 	: SEMICOLON");
							symbolName = $1->getSymbolName()+"\n";
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						}			
			| expression SEMICOLON	{
							PrintGrammar(lineCount, "expression_statement 	: expression SEMICOLON");
							symbolName = $1->getSymbolName();							
							symbolName += $2->getSymbolName();
							symbolName += "\n";
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
						} 
			;
	  
variable: ID	{
							PrintGrammar(lineCount, "variable : ID");
							symbolName = $1->getSymbolName();
							

							SymbolInfo* t = symbolTable->Lookup(symbolName);
							if(t == NIL){
								PrintError(lineCount, "Undeclared variable "+symbolName);
								++errorCount;
								$$ = new SymbolInfo(symbolName, "dummyType");
								$$->setStructType("var");
								$$->setDataType("float");
							}
							else{
								if(t->getStructType() == "array"){
									PrintError(lineCount, "Type mismatch, "+t->getSymbolName()+ " is an array");
									++errorCount;
								}
								$$ = new SymbolInfo(symbolName, "dummyType");
								$$ = t;
							}
							PrintToken(symbolName);
							
						} 		
	 | ID LTHIRD expression RTHIRD	{
							PrintGrammar(lineCount, "variable : ID LTHIRD expression RTHIRD");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName()+" "+$4->getSymbolName();
							

							SymbolInfo* t = symbolTable->Lookup($1->getSymbolName());
							
							if(t == NIL){
								PrintError(lineCount, "Undeclared variable "+symbolName);
								++errorCount;
								$$ = new SymbolInfo($1->getSymbolName(), "array");
								$$->setStructType("array");
								$$->setDataType("float");
								$$->addParams("-1");
							}else{
								if(t->getStructType() != "array"){
									PrintError(lineCount, t->getSymbolName()+" not an array");
									++errorCount;
								}
								$$ = new SymbolInfo(symbolName, "dummyType");
								$$->setStructType("array");
								$$->setDataType(t->getDataType());
								if($3->getDataType()=="float"){
									PrintError(lineCount, "Expression inside third brackets not an integer");
									++errorCount;
								}
							}
							PrintToken(symbolName);
						} 
	 ;
	 
 expression: logic_expression	{
							PrintGrammar(lineCount, "expression : logic expression");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$ = $1;
						}	
	   | variable ASSIGNOP logic_expression	{
							PrintGrammar(lineCount, "expression : variable ASSIGNOP logic_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();

							if($1->getDataType()=="void" || $3->getDataType()=="void" ){
								PrintError(lineCount, "Void function used in expression");
								++errorCount;
							}
							else if($1->getDataType()!="float" && ($1->getDataType() != $3->getDataType())){
								// log_file<<$1->getDataType()<<" = "<<$3->getDataType()<<endl;
								PrintError(lineCount, "Type Mismatch");
								++errorCount;
							}
							
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");


						} 	
	   ;
			
logic_expression: rel_expression	{
							PrintGrammar(lineCount, "logic_expression : rel_expression");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
							$$ = $1;
						} 	
		 | rel_expression LOGICOP rel_expression	{
							PrintGrammar(lineCount, "logic_expression : rel_expression LOGICOP rel_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$->setDataType("int");

							if($1->getDataType()=="void" || $3->getDataType()=="void" ){
								PrintError(lineCount, "Void function used in expression");
								++errorCount;
							}
						} 	
		 ;
			
rel_expression: simple_expression	{
							PrintGrammar(lineCount, "rel_expression	: simple_expression");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$ = $1;
						} 
		| simple_expression RELOP simple_expression	{
							PrintGrammar(lineCount, "rel_expression	: simple_expression RELOP simple_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();;
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$->setDataType("int");

							if($1->getDataType()=="void" || $3->getDataType()=="void" ){
								PrintError(lineCount, "Void function used in expression");
								++errorCount;
							}
						}	
		;
				
simple_expression: term	{
							PrintGrammar(lineCount, "simple_expression : term");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$ = $1;
						} 
		  | simple_expression ADDOP term	{
							PrintGrammar(lineCount, "simple_expression : simple_expression ADDOP term");
							symbolName = $1->getSymbolName();
							symbolName += $2->getSymbolName();
							symbolName += $3->getSymbolName();

							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							if($1->getDataType()=="float" || $3->getDataType()=="float"){
								$$->setDataType("float");
							}
							else if($1->getDataType()=="int" || $3->getDataType()=="int"){
								$$->setDataType("int");
							}

							else if($1->getDataType()=="void" || $3->getDataType()=="void" ){
								PrintError(lineCount, "Void function used in expression");
								++errorCount;
							}
						} 
		  ;
					
term:	unary_expression	{
							PrintGrammar(lineCount, "term :	unary_expression");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$ = $1;
						}
     |  term MULOP unary_expression	{
							PrintGrammar(lineCount, "term :	term MULOP unary_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							

							$$ = new SymbolInfo(symbolName, "dummyType");

							if($2->getSymbolName()=="%"){
								if($1->getDataType()!="int" || $3->getDataType()!="int"){
									PrintError(lineCount, "Non-Integer operand on modulus operator");
									++errorCount;
								}

								if($3->getSymbolName()=="0"){
									PrintError(lineCount, "Modulus by Zero");
									++errorCount;
								}
								$$->setDataType("int");
							}
							else{
								if($1->getDataType()=="float" || $3->getDataType()=="float"){
									$$->setDataType("float");
								}
								else{
									$$->setDataType("int");
								}
							}
							if($1->getDataType()=="void" || $3->getDataType()=="void" ){
								PrintError(lineCount, "Void function used in expression");
								++errorCount;
							}
							PrintToken(symbolName);
						}
     ;

unary_expression: ADDOP unary_expression	{
							PrintGrammar(lineCount, "unary_expression : ADDOP unary_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$->setDataType($2->getDataType());
						}  
		 | NOT unary_expression	{
							PrintGrammar(lineCount, "unary_expression : NOT unary_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$->setDataType($2->getDataType());
						} 
		 | factor	{
							PrintGrammar(lineCount, "unary_expression : factor");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$ = $1;
						} 
		 ;
	
factor: variable	{
							PrintGrammar(lineCount, "factor	: variable");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
							$$ = $1;	
						} 

	| ID LPAREN {
		currentCalled = $1->getSymbolName();
	} argument_list RPAREN	{
							PrintGrammar(lineCount, "factor	: ID LPAREN argument_list RPAREN");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$4->getSymbolName()+" "+$5->getSymbolName();

							SymbolInfo* t = symbolTable->Lookup($1->getSymbolName());
							if(t == NIL){
								PrintError(lineCount, "Undeclared function "+$1->getSymbolName());
								++errorCount;
								$$ = new SymbolInfo(symbolName, "dummyType");
							}
							else{
								vector<SymbolInfo> v = t->getFuncParams();
								if(v.size() != params_list.size()){
									PrintError(lineCount, "Total number of arguments mismatch in function "+ currentCalled);
									++errorCount;
								}else{
									for(int i=0; i<v.size(); i++){
										if(v[i].getDataType() != params_list[i].getDataType()){
											if(v[i].getDataType()=="float" && params_list[i].getDataType()=="int"){
												;
											}
											else{
												PrintError(lineCount, to_string(i+1) + "th argument mismatch in function "+currentCalled);
												++errorCount;
												break;
											}
										}
									}
								}
								params_list.clear();
								$$ = new SymbolInfo(symbolName, "dummyType");
								$$->setDataType(t->getDataType());
							}
							PrintToken(symbolName);
						}
	| LPAREN expression RPAREN	{
							PrintGrammar(lineCount, "factor	: LPAREN expression RPAREN");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$->setDataType($2->getDataType());
						}
	| CONST_INT	{
							PrintGrammar(lineCount, "factor	: CONST_INT");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "CONST_INT");
							$$->setStructType("val");
							$$->setDataType("int");
							$$->addParams("int");
						} 
	| CONST_FLOAT	{
							PrintGrammar(lineCount, "factor	: CONST_FLOAT");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "CONST_FLOAT");
							$$->setStructType("val");
							$$->setDataType("float");
							$$->addParams("float");
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

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$ = $1;
						}
			  
			  ;
	
arguments: arguments COMMA logic_expression	{
							PrintGrammar(lineCount, "arguments : arguments COMMA logic_expression");
							symbolName = $1->getSymbolName()+" "+$2->getSymbolName()+" "+$3->getSymbolName();

							PrintToken(symbolName);
							$$ = new SymbolInfo(symbolName, "dummyType");
							params_list.push_back(*$3);
						}
	      | logic_expression	{
							PrintGrammar(lineCount, "arguments : logic_expression");
							symbolName = $1->getSymbolName();
							PrintToken(symbolName);

							$$ = new SymbolInfo(symbolName, "dummyType");
							$$ = $1;
							params_list.push_back(*$1);
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

