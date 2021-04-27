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
      
"if"        {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return IF;
            }
"else"      {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return ELSE;
            }
"for"       {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return FOR;
            }
"while"     {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return WHILE;
            }
"do"        {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return DO;
            }
"break"     {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return BREAK;
            }
"int"       {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return INT;
            }
"char"      {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return CHAR;
            }
"float"     {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return FLOAT;
            }
"double"    {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return DOUBLE;
            }
"void"      {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return VOID;
            }
"return"    {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return RETURN;
            }
"continue"  {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return CONTINUE;
            }
"println"|"printf"   {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return PRINTLN;
            }

"+"|"-"     {
                symbolInfo = new SymbolInfo(yytext, "ADDOP");
                yylval.si = symbolInfo;
                return ADDOP;
            }
"*"|"/"|"%" {
                symbolInfo = new SymbolInfo(yytext, "MULOP");
                yylval.si = symbolInfo;
                return MULOP;
            }
"++"|"--"   {
                symbolInfo = new SymbolInfo(yytext, "INCOP");
                yylval.si = symbolInfo;
                return INCOP;
            }
"<"|"<="|">"|">="|"=="|"!=" {
                                symbolInfo = new SymbolInfo(yytext, "RELOP");
                                yylval.si = symbolInfo;
                                return RELOP;
                            }
"="         {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return ASSIGNOP;
            }
"&&"|"||"   {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return LOGICOP;
            }
"!"         {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return NOT;
            }
"("         {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return LPAREN;
            }
")"         {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return RPAREN;
            }
"{"         {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return LCURL;
            }
"}"         {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return RCURL;
            }
"["         {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return LTHIRD;
            }
"]"         {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return RTHIRD;
            }
","         {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return COMMA;
            }
";"         {
                symbolInfo = new SymbolInfo(yytext, "token");
                yylval.si = symbolInfo;return SEMICOLON;
            }

{WHITESPACE}    {}
{NEWLINE}     {++lineCount;}
{IDENTIFIER}    {
                    symbolInfo = new SymbolInfo(yytext, "ID");
                    yylval.si = symbolInfo;
                    return ID;
                }
{INTEGER}   {
                symbolInfo = new SymbolInfo(yytext, "CONST_INT");
                yylval.si = symbolInfo;
                return CONST_INT;
            }
{FLOAT}     {
                symbolInfo = new SymbolInfo(yytext, "CONST_FLOAT");
                yylval.si = symbolInfo;
                return CONST_FLOAT;
            }

%%

