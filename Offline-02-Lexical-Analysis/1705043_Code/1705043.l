%option noyywrap

%x str
%x comment

%{
#include<bits/stdc++.h>
using namespace std;
#include "symbol_table.cpp"


int lineCount = 1;
int errorCount = 0;

ofstream token_file("1705043_token.txt");
ofstream log_file("1705043_log.txt");
SymbolTable* symboltable = new SymbolTable(10);


void PrintKeyword(string token, string lexeme, int lineNo){
     token_file <<"<" << token <<", "<<lexeme<<"> ";
    log_file << "Line no " << lineNo << ": Token "<< token <<" Lexeme " << lexeme << " found" << endl;
    
}

void PrintOperator(string token, string lexeme,  int lineNo){

    token_file <<"<" << token <<", "<<lexeme<<"> ";
    log_file << "Line no " << lineNo << ": Token "<< token <<" Lexeme " << lexeme << " found" << endl;
    if(lexeme=="{"){
        symboltable->EnterScope();
        }
    else if(lexeme=="}"){
        symboltable->ExitScope();
    }
}

void PrintIdentifier(string token, string lexeme, int lineNo){
    token_file <<"<" << token <<", "<<lexeme<<"> ";
    log_file << "Line no " << lineNo << ": Token "<< token <<" Lexeme " << lexeme << " found" << endl;
    
    SymbolInfo* symbol = new SymbolInfo(lexeme, token);
    symboltable->Insert(*symbol);
    symboltable->PrintAllTables(log_file);
}

void PrintError(string errorName, int lineNo){
    log_file << "Line no " << lineNo << ": Error "<< errorName << endl;
}

%}

DIGIT [0-9]
SINGLE_LINE_COMMENT \\\\{ALPHANUMERIC}+
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
LETTER [a-zA-Z]
ALPHANUMERIC [a-zA-Z0-9]
NEWLINE \r?\n

INTEGER {DIGIT}+
FLOAT ({DIGIT}+\.?{DIGIT}*|\.{DIGIT}+)([Ee][+-]?{DIGIT}+)?
SINGLE_LINE_STRING \"([^\\\"]|\\.)*\"
CHARCTER_LITERAL \'[\\n\\\\\'\\a\\f\\r\\b\\v\\0]\'
TOO_MANY_DECIMAL {DIGIT}+\.{DIGIT}+\.{DIGIT}+
ILL_FORMED_NUMBER {DIGIT}+[Ee][+-]?{DIGIT}+\.{DIGIT}*
INVALID_PREFIX {DIGIT}+{ALPHANUMERIC}+
CHARACTER_CONSTANT_ERROR \'{ALPHANUMERIC}+{ALPHANUMERIC}+\'
UNFINISHED_CHARACTER_ERROR \'(\\)*{ALPHANUMERIC}*(\\)*
UNRECOGNIZED_CHARACTER [^{ALPHANUMERIC}]

%%
{SINGLE_LINE_COMMENT} {}  
"if"        {PrintKeyword("IF", yytext, lineCount);}
"else"      {PrintKeyword("ELSE", yytext, lineCount);}
"for"       {PrintKeyword("FOR", yytext, lineCount);}
"while"     {PrintKeyword("WHILE", yytext, lineCount);}
"do"        {PrintKeyword("DO", yytext, lineCount);}
"break"     {PrintKeyword("BREAK", yytext, lineCount);}
"int"       {PrintKeyword("INT", yytext, lineCount);}
"char"      {PrintKeyword("CHAR", yytext, lineCount);}
"float"     {PrintKeyword("FLOAT", yytext, lineCount);}
"double"    {PrintKeyword("DOUBLE", yytext, lineCount);}
"void"      {PrintKeyword("VOID", yytext, lineCount);}
"return"    {PrintKeyword("RETURN", yytext, lineCount);}
"switch"    {PrintKeyword("SWITCH", yytext, lineCount);}
"case"      {PrintKeyword("CASE", yytext, lineCount);}
"default"   {PrintKeyword("DEFAULT", yytext, lineCount);}
"continue"  {PrintKeyword("CONTINUE", yytext, lineCount);}


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
\/\/[^\r\n]*    {}
"/*"         {
             BEGIN(comment);
             }
<comment>[^*\n]*        {/* eat anything that's not a '*' */}
<comment>"*"+[^*/\n]*   {/* eat up '*'s not followed by '/'s */}
<comment>\n             {lineCount++;}
<comment>"*"+"/"        {BEGIN(INITIAL);}

TOO_MANY_DECIMAL {PrintError("too many decimal points", lineCount); errorCount++;}
ILL_FORMED_NUMBER {PrintError("ILL_FORMED_NUMBER", lineCount); errorCount++;}
INVALID_PREFIX {PrintError("INVALID_PREFIX", lineCount); errorCount++;}
CHARACTER_CONSTANT_ERROR {PrintError("CHARACTER_CONSTANT_ERROR", lineCount); errorCount++;}
UNFINISHED_CHARACTER_ERROR {PrintError("UNFINISHED_CHARACTER_ERROR", lineCount); errorCount++;}
UNRECOGNIZED_CHARACTER {PrintError("UNRECOGNIZED_CHARACTER", lineCount); errorCount++;}


{NEWLINE}     {lineCount++;}
{IDENTIFIER}    {PrintIdentifier("ID", yytext, lineCount);}
{INTEGER}   {PrintIdentifier("CONST_INT", yytext, lineCount);}
{FLOAT}     {PrintIdentifier("CONST_FLOAT", yytext, lineCount);}

{CHARCTER_LITERAL}  {PrintIdentifier("CONST_CHAR", yytext, lineCount);}

<<EOF>> {log_file<<"Total lines : "<<lineCount<<endl;
            log_file<<"Total errors : "<<errorCount<<endl;
            return 0;}
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
