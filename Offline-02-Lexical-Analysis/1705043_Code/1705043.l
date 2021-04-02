%option noyywrap

%{
#include<bits/stdc++.h>
#include<stdio.h>
#include<stdlib.h>

using namespace std;
#include "symbol_table.cpp"


int lineCount = 1;
int errorCount = 0;

SymbolTable* symboltable = new SymbolTable(100);

void PrintKeyword(string token, string lexeme, int lineNo){
    freopen ("1705043_token.txt", "a", stdout);
    cout << token <<" ";
    fclose(stdout);
    
    freopen ("1705043_log.txt", "a", stdout);
    cout << "Line no " << lineNo << ": Token "<< token <<" Lexeme " << lexeme << " found" << endl;
    fclose(stdout);
}

void PrintOperator(string token, string lexeme,  int lineNo){
    freopen ("1705043_token.txt", "a", stdout);
    cout <<"<" << token <<", "<<lexeme<<"> ";
    fclose(stdout);
    
    freopen ("1705043_log.txt", "a", stdout);
    cout << "Line no " << lineNo << ": Token "<< token <<" Lexeme " << lexeme << " found" << endl;
    fclose(stdout);
}

void PrintIdentifier(string token, string lexeme, int lineNo){
    freopen ("1705043_token.txt", "a", stdout);
    cout <<"<" << token <<", "<<lexeme<<"> ";
    fclose(stdout);
    
    freopen ("1705043_log.txt", "a", stdout);
    cout << "Line no " << lineNo << ": Token "<< token <<" Lexeme " << lexeme << " found" << endl;
    fclose(stdout);
}
%}

IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
ALPHANUMERIC [a-zA-Z0-9]
NEWLINE \r?\n
DIGIT [0-9]
INTEGER {DIGIT}+


%%
"if"        {PrintKeyword("<IF> ", yytext, lineCount);}
"else"      {PrintKeyword("<ELSE> ", yytext, lineCount);}
"for"       {PrintKeyword("<FOR> ", yytext, lineCount);}
"while"     {PrintKeyword("<WHILE> ", yytext, lineCount);}
"do"        {PrintKeyword("<DO> ", yytext, lineCount);}
"break"     {PrintKeyword("<BREAK> ", yytext, lineCount);}
"int"       {PrintKeyword("<INT> ", yytext, lineCount);}
"char"      {PrintKeyword("<CHAR> ", yytext, lineCount);}
"float"     {PrintKeyword("<FLOAT> ", yytext, lineCount);}
"double"    {PrintKeyword("<DOUBLE> ", yytext, lineCount);}
"void"      {PrintKeyword("<VOID> ", yytext, lineCount);}
"return"    {PrintKeyword("<RETURN> ", yytext, lineCount);}
"switch"    {PrintKeyword("<SWITCH> ", yytext, lineCount);}
"case"      {PrintKeyword("<CASE> ", yytext, lineCount);}
"default"   {PrintKeyword("<DEFAULT> ", yytext, lineCount);}
"continue"  {PrintKeyword("<CONTINUE> ", yytext, lineCount);}
"+"|"-"     {PrintOperator("ADDOP", yytext, lineCount);}
"*"|"/"|"%" {PrintOperator("MULOP", yytext, lineCount);}
"++"|"--"   {PrintOperator("INCOP", yytext, lineCount);}
"<"|"<="|">"|">="|"=="|"!=" {PrintOperator("RELOP", yytext, lineCount);}
"="         {PrintOperator("ASSIGNOP", yytext, lineCount);}
"&&"|"||"   {PrintOperator("LOGICOP", yytext, lineCount);}
"!"         {PrintOperator("NOT", yytext, lineCount);}
"("         {PrintOperator("LPAREN", yytext, lineCount);}
")"         {PrintOperator("RPAREN", yytext, lineCount);}
"{"         {PrintOperator("LCURL", yytext, lineCount);}
"}"         {PrintOperator("RCURL", yytext, lineCount);}
"["         {PrintOperator("LTHIRD", yytext, lineCount);}
"]"         {PrintOperator("RTHIRD", yytext, lineCount);}
","         {PrintOperator("COMMA", yytext, lineCount);}
";"         {PrintOperator("SEMICOLON", yytext, lineCount);}
{NEWLINE}     {lineCount++;}
{IDENTIFIER}    {PrintIdentifier("ID", yytext, lineCount);}
.   {}
%%
int main(int argc,char *argv[]){
	
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
	yylex();
	fclose(yyin);
	return 0;
}
