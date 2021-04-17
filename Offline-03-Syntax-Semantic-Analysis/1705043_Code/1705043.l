%option noyywrap

%{
#include<bits/stdc++.h>
using namespace std;
#include "symbol_table.cpp"
#include "y.tab.h"

extern YYSTYPE yylval;
extern SymbolTable* symbolTable;

extern int lineCount = 1;
extern int errorCount = 0;

%}

DIGIT [0-9]
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
LETTER [a-zA-Z]
ALPHANUMERIC [a-zA-Z0-9]
NEWLINE \r?\n
WHITESPACE [ \t]
INTEGER {DIGIT}+
FLOAT ({DIGIT}+\.?{DIGIT}*|\.{DIGIT}+)([Ee][+-]?{DIGIT}+)?

%%
      
"if"        {return IF;}
"else"      {return ELSE;}
"for"       {return FOR;}
"while"     {return WHILE;}
"do"        {return DO;}
"break"     {return BREAK;}
"int"       {return INT;}
"char"      {return CHAR;}
"float"     {return FLOAT;}
"double"    {return DOUBLE;}
"void"      {return VOID;}
"return"    {return RETURN;}
"continue"  {return CONTINUE;}

"+"|"-"     {return ADDOP;}
"*"|"/"|"%" {return MULOP;}
"++"|"--"   {return INCOP);}
"<"|"<="|">"|">="|"=="|"!=" {return RELOP";}
"="         {return ASSIGNOP";}
"&&"|"||"   {return LOGICOP";}
"!"         {return NOT;}
"("         {return LPAREN;}
")"         {return RPAREN;}
"{"         {return LCURL;}
"}"         {return RCURL;}
"["         {return LTHIRD;}
"]"         {return RTHIRD";}
","         {return COMMA;}
";"         {return SEMICOLON";}

{WHITESPACE}    {}
{NEWLINE}     {++lineCount;}
{IDENTIFIER}    {return ID;}
{INTEGER}   {return CONST_INT;}
{FLOAT}     {return CONST_FLOAT;}

%%

