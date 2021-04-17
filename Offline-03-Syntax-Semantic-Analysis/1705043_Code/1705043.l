%option noyywrap

%x str
%x strSlash

%x slashStar
%x slashSlash
%x slashSlashSlash
%{
#include<bits/stdc++.h>
using namespace std;
#include "symbol_table.cpp"


int lineCount = 1;
int errorCount = 0;
char buf[100000];
char buf2[100000];
char *s;
char *s2;

int lineStart = 0;
bool finished = true;

ofstream token_file("1705043_token.txt");
ofstream log_file("1705043_log.txt");
SymbolTable* symboltable = new SymbolTable(7);


void PrintKeyword(string token, string lexeme, int lineNo){
        token_file <<"<" << token<< "> ";
        log_file << "Line no " << lineNo <<  ": Token "<<"<" << token << ">  Lexeme " << lexeme << " found" << endl;
    
}

void PrintOperator(string token, string lexeme,  int lineNo){

    token_file <<"<" << token <<", "<<lexeme<<"> ";
    log_file << "Line no " << lineNo <<  ": Token "<<"<" << token << ">  Lexeme " << lexeme << " found" << endl;
    if(lexeme=="{"){
        symboltable->EnterScope();
        }
    else if(lexeme=="}"){
        symboltable->ExitScope();
    }
}

void PrintIdentifier(string token, string lexeme, int lineNo){
    token_file <<"<" << token <<", "<<lexeme<<"> ";
    log_file << "Line no " << lineNo <<  ": Token "<<"<" << token << ">  Lexeme " << lexeme << " found" << endl;
    
    SymbolInfo* symbol = new SymbolInfo(lexeme, token);
    bool inserted = symboltable->Insert(*symbol);
    if(inserted != false)
        symboltable->PrintAllTables(log_file);
    else
        log_file<<lexeme<<" already exists in current ScopeTable"<<endl;
}


void PrintComment(int lineNo, bool error){
    if(error){
        log_file << "Line no " << lineNo << "Unfinished Comment " << buf << " found" << endl;
        memset(buf, 0, sizeof(buf));
        memset(buf2, 0, sizeof(buf2));
    }
    else{
        log_file << "Line no " << lineNo << ": Token "<< "<COMMENT>" <<" Lexeme " << buf << " found" << endl;
        memset(buf, 0, sizeof(buf));
        memset(buf2, 0, sizeof(buf2));
    }
}

void PrintString(int lineNo){
    token_file <<"<STRING, "<< buf2 << " > ";
    log_file << "Line no " << lineNo << ": Token "<< "<STRING>" <<" Lexeme " << buf << " found --><STRING, "<<buf2 <<"> "<< endl;
    memset(buf, 0, sizeof(buf));
    memset(buf2, 0, sizeof(buf2));
}

void PrintConstChar(string lexeme, char c, int lineNo){
    token_file << "<CHAR_CONST, "<< c <<" > ";
    log_file << "Line no " << lineNo << ": Token "<< "<CHAR_CONST>" <<" Lexeme " << lexeme << " found --> <CHAR_CONST, "<< c <<"> "<< endl;
    SymbolInfo* symbol = new SymbolInfo(lexeme, "CHAR_CONST");
    bool inserted = symboltable->Insert(*symbol);
    if(inserted != false)
        symboltable->PrintAllTables(log_file);
    else
        log_file<<lexeme<<" already exists in current ScopeTable"<<endl;
}

%}

DIGIT [0-9]
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]*
LETTER [a-zA-Z]
ALPHANUMERIC [a-zA-Z0-9]
NEWLINE \r?\n
WHITESPACE [ \t]


INTEGER {DIGIT}+

FLOAT ({DIGIT}+\.?{DIGIT}*|\.{DIGIT}+)([Ee][+-]?{DIGIT}+)?

CHARCTER_LITERAL \'((\\n)|(\\t)|(\\\\)|(\\\')|(\\\")|(\\a)|(\\f)|(\\r)|(\\b)|(\\v)|(\\0)|{ALPHANUMERIC})\'

TOO_MANY_DECIMAL {DIGIT}+\.{DIGIT}+\.({DIGIT}|\.)*

ILL_FORMED_NUMBER ({DIGIT}+\.?{DIGIT}*|\.{DIGIT}+)[Ee][+-]?{DIGIT}*\.({DIGIT}+)?

INVALID_PREFIX {DIGIT}+{ALPHANUMERIC}+

CHARACTER_CONSTANT_ERROR \'({WHITESPACE}|{ALPHANUMERIC}|(\\))+\'

UNFINISHED_CHARACTER_ERROR \'((\\n)|(\\t)|(\\\\)|(\\\')|(\\a)|(\\f)|(\\r)|(\\b)|(\\v)|(\\0)|{ALPHANUMERIC})*

EMPTY_CHARACTER_ERROR \'\'

UNRECOGNIZED_CHARACTER .

%%
 
\"      {
            BEGIN (str);
            memset(buf, 0, sizeof(buf));
            memset(buf2, 0, sizeof(buf2));
            s = buf;
            s2 = buf2;
            *s++ = '\"';
            *s2++ = '\"';
            lineStart = lineCount;
            finished = false;
        }
        
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
{WHITESPACE}    {}


\/\*         {
                BEGIN(slashStar);
                memset(buf, 0, sizeof(buf));
                memset(buf2, 0, sizeof(buf2));
                s= buf;
                *s++ = '/';
                *s++ = '*';
                lineStart = lineCount;
                finished = false;
             }
             
<slashStar>\r?\n        {
                        *s++ = *yytext; 
                        ++lineCount;
                    }
<slashStar>\*\/        {
                            *s++ = '*'; 
                            *s++ = '/'; 
                            BEGIN(INITIAL); 
                            *s=0; 
                            PrintComment(lineStart, false); 
                            finished = true;
                        }
<slashStar>. {*s++ = *yytext;}


\/\/    {
            BEGIN (slashSlash);
            s= buf;
            *s++ = '/';
            *s++ = '/';
            lineStart = lineCount;
        }
<slashSlash>\\  {
                    BEGIN (slashSlashSlash); 
                    *s++ = '\\';
                }
<slashSlash>\r?\n  {
/*                     *s++ = *yytext;  */
                    lineCount++; 
                    BEGIN(INITIAL); 
                    *s=0; 
                    PrintComment(lineStart, false);
                    finished = true;
                }
                    
<slashSlash>. {*s++ = *yytext; }
<slashSlashSlash>\r?\n {
                        *s++ = *yytext; 
                        lineCount++; 
                        BEGIN(slashSlash);
                    }
<slashSlashSlash>. {
                    *s++ = *yytext; 
                    BEGIN(slashSlash);
                }

                

{NEWLINE}     {++lineCount;}
{IDENTIFIER}    {PrintIdentifier("ID", yytext, lineCount);}
{INTEGER}   {PrintIdentifier("CONST_INT", yytext, lineCount);}
{FLOAT}     {PrintIdentifier("CONST_FLOAT", yytext, lineCount);}

{CHARCTER_LITERAL}  {
                        char temp = yytext[2];
                        char c;
                        if(yytext[1]=='\\'){
                            if(temp=='n'){c='\n';}
                            else if(temp=='t'){c='\t';}
                            else if(temp=='a'){c='\a';}
                            else if(temp=='f'){c='\f';}
                            else if(temp=='b'){c='\b';}
                            else if(temp=='v'){c='\v';}
                            else if(temp=='r'){c='\r';}
                            else if(temp=='0'){c='\0';}
                            else if(temp=='\\'){c='\\';}
                            else if(temp=='\''){c='\'';}
                            else if(temp=='\"'){c='\"';}
                        }
                        else {c=yytext[1];}
                        
                        PrintConstChar(yytext, c, lineCount);
                    }

{TOO_MANY_DECIMAL}  {
                        log_file<<"Error at line no "<<lineCount<<" : Too many decimal points  "<<yytext<<endl; 
                        ++errorCount;
                    }

{ILL_FORMED_NUMBER} {
                        log_file<<"Error at line no "<<lineCount<<" : Ill formed number  "<<yytext<<endl; 
                        ++errorCount;
                    }

{INVALID_PREFIX}    {
                        log_file<<"Error at line no "<<lineCount<<" : Invalid prefix on ID or invalid suffix on Number "<<yytext<<endl; 
                        ++errorCount;
                    }

{CHARACTER_CONSTANT_ERROR}  {
                                log_file<<"Error at line no "<<lineCount<<" : Multi character constant error "<<yytext<<endl; 
                                ++errorCount;
                            }

{UNFINISHED_CHARACTER_ERROR}    {
                                    log_file<<"Error at line no "<<lineCount<<" : Unterminated character "<<yytext<<endl; 
                                    ++errorCount;
                                }

{EMPTY_CHARACTER_ERROR}     {
                                log_file<<"Error at line no "<<lineCount<<" : Empty character constant error"<<yytext<<endl; 
                                ++errorCount;
                            }
                            
<str>\\    {
                *s++ = '\\';
                BEGIN (strSlash);    
            }

<strSlash>[ntafbvr0\\\'\"]    {
                                    *s++ = *yytext;
                                    char temp = yytext[0];
                                    if(temp=='n'){*s2++='\n';}
                                    else if(temp=='t'){*s2++='\t';}
                                    else if(temp=='a'){*s2++='\a';}
                                    else if(temp=='f'){*s2++='\f';}
                                    else if(temp=='b'){*s2++='\b';}
                                    else if(temp=='v'){*s2++='\v';}
                                    else if(temp=='r'){*s2++='\r';}
                                    else if(temp=='0'){*s2++='\n';}
                                    else if(temp=='\\'){*s2++='\\';}
                                    else if(temp=='\''){*s2++='\'';}
                                    else if(temp=='\"'){*s2++='\"';}
                                    BEGIN (str);
                            }
<strSlash>\r?\n    {
                    ++lineCount;
                    *s++ = *yytext; 
                    BEGIN(str);
                }
                
<strSlash>.     {
                    *s++ = *yytext;
                    *s2++ = *yytext;
                    BEGIN (str);
                }
<str>\"     {
                *s++ = '\"';
                *s2++ = '\"';
                *s = 0;
                *s2 = 0;

                BEGIN (INITIAL);
                PrintString(lineStart);
                finished = true;   
                memset(buf, 0, sizeof(buf));
                memset(buf2, 0, sizeof(buf2));
            }
            
<str>\r?\n     {
                *s = 0;
                *s2 = 0;
                lineCount++;
                BEGIN (INITIAL);
                 
                finished = true;
                log_file<<"Error at line no "<<lineStart<<" : Unterminated String "<<buf<<endl; 
                ++errorCount;
                memset(buf, 0, sizeof(buf));
                memset(buf2, 0, sizeof(buf2));
            }

<str>.      {
                *s++ = *yytext;
                *s2++ = *yytext;
            }
 

 
<<EOF>> {
            if(finished==false){
                log_file<<"Error at line no "<<lineStart<<" : Unterminated Comment "<<buf<<endl; 
                ++errorCount;
                memset(buf, 0, sizeof(buf));
                memset(buf2, 0, sizeof(buf2));
            }

            symboltable->PrintAllTables(log_file);
            log_file<<"Total lines : "<<lineCount<<endl;
            log_file<<"Total errors : "<<errorCount<<endl;
            return 0;
        }
        
{UNRECOGNIZED_CHARACTER}    {
                                log_file<<"Error at line no "<<lineCount<<" : Unrecognized character "<<yytext<<endl; 
                                ++errorCount;
                            }

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
