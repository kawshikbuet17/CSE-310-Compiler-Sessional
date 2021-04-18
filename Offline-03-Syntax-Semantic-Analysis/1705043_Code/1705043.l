%option noyywrap

%{
#include<bits/stdc++.h>
using namespace std;
#include "symbol_table.cpp"
#include "y.tab.h"

extern YYSTYPE yylval;
extern SymbolTable* symbolTable;
SymbolInfo* symbolInfo;

void yyerror(char *);

extern int lineCount;
extern int errorCount;

%}

DIGIT [0-9]
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
LETTER [a-zA-Z]
ALPHANUMERIC [a-zA-Z0-9]
NEWLINE (\r)?\n
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
"println"   {return PRINTLN;}

"+"|"-"     {
                //symbolInfo = new SymbolInfo(yytext, "ADDOP");
                //yylval = (YYSTYPE) symbolInfo*;
                return ADDOP;
            }
"*"|"/"|"%" {
                //symbolInfo = new SymbolInfo(yytext, "MULOP");
                //yylval = (YYSTYPE) symbolInfo*;
                return MULOP;
            }
"++"|"--"   {
                //symbolInfo = new SymbolInfo(yytext, "INCOP");
                //yylval = (YYSTYPE) symbolInfo*;
                return INCOP;
            }
"<"|"<="|">"|">="|"=="|"!=" {
                                //symbolInfo = new SymbolInfo(yytext, "RELOP");
                                //yylval = (YYSTYPE) symbolInfo*;
                                return RELOP;
                            }
"="         {return ASSIGNOP;}
"&&"|"||"   {return LOGICOP;}
"!"         {return NOT;}
"("         {return LPAREN;}
")"         {return RPAREN;}
"{"         {return LCURL;}
"}"         {return RCURL;}
"["         {return LTHIRD;}
"]"         {return RTHIRD;}
","         {return COMMA;}
";"         {return SEMICOLON;}

{WHITESPACE}    {}
{NEWLINE}     {++lineCount;}
{IDENTIFIER}    {
                    //symbolInfo = new SymbolInfo(yytext, "ID");
                    //yylval = (YYSTYPE) symbolInfo*;
                    return ID;
                }
{INTEGER}   {
                //symbolInfo = new SymbolInfo(yytext, "CONST_INT");
                //yylval = (YYSTYPE) symbolInfo*;
                return CONST_INT;
            }
{FLOAT}     {
                //symbolInfo = new SymbolInfo(yytext, "CONST_FLOAT");
                //yylval = (YYSTYPE) symbolInfo*;
                return CONST_FLOAT;
            }

%%

