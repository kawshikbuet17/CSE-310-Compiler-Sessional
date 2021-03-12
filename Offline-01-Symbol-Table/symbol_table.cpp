#include <bits/stdc++.h>
using namespace std;

#define NIL NULL
#define int long long

class SymbolInfo
{
    string symbolName;
    string symbolType;

public:
    SymbolInfo(string symbolName, string symbolType)
    {
        this->symbolName = symbolName;
        this->symbolType = symbolType;
    }

    void setSymbolName(string symbolName)
    {
        this->symbolName = symbolName;
    }

    string getSymbolName()
    {
        return symbolName;
    }

    void setSymbolType(string symbolType)
    {
        this->symbolType = symbolType;
    }

    string getSymbolType()
    {
        return symbolType;
    }
};


class ScopeTable
{
    int id;
    int totalBuckets;
    vector<SymbolInfo> *hashTable;
    ScopeTable* parentScope;

public:
    ScopeTable(int N)
    {
        totalBuckets = N;
        hashTable = new vector<SymbolInfo>[totalBuckets];
    }

    ~ScopeTable()
    {
        delete hashTable;
    }

    void makeParentScope(ScopeTable* parentScope)
    {
        this->parentScope = parentScope;
    }

    ScopeTable* getParentScope()
    {
        return parentScope;
    }

    void setHashTableSize(int N)
    {
        this->totalBuckets = N;
    }

    int hashFunction(string str)
    {
        int hashVal = 0;
        int sumAscii = 0;
        for(int i=0; i<str.length(); i++)
        {
            sumAscii += str[i];
        }
        hashVal = sumAscii % totalBuckets;
        return hashVal;
    }

    bool Insert(SymbolInfo symbol)
    {
        SymbolInfo* location = NIL;
        location = Lookup(symbol);
        if(location == NIL)
        {
            int hashVal = hashFunction(symbol.getSymbolName());
            hashTable[hashVal].push_back(symbol);
            return true;
        }
        else
            return false;
    }

    bool Delete(SymbolInfo symbol)
    {
        int hashVal = hashFunction(symbol.getSymbolName());
        SymbolInfo* location = Lookup(symbol);
        if(location != NIL)
        {
            swap(*location, hashTable[hashVal][hashTable[hashVal].size()-1]);
            hashTable[hashVal].pop_back();
            return true;
        }
        else
            return false;
    }

    SymbolInfo* Lookup(SymbolInfo symbol)
    {
        int hashVal = hashFunction(symbol.getSymbolName());
        SymbolInfo* temp = NIL;
        for(int i=0; i<hashTable[hashVal].size(); i++)
        {
            if(hashTable[hashVal][i].getSymbolName() == symbol.getSymbolName() && hashTable[hashVal][i].getSymbolType() == symbol.getSymbolType())
            {
                temp = &hashTable[hashVal][i];
                break;
            }
        }
        return temp;
    }

    Print();
};


class SymbolTable
{
    vector<ScopeTable> scope;
    ScopeTable* previous;
    ScopeTable* current;
    ScopeTable* temp;
    int totalBucket;

public:
    EnterScope()
    {
        temp = new ScopeTable(totalBucket);
        current = temp;
        current->makeParentScope(previous);
    }

    ExitScope()
    {
        previous = current;
        current = NIL;
    }

    bool Insert(SymbolInfo symbol)
    {
        return current->Insert(symbol);
    }

    bool Remove(SymbolInfo symbol)
    {
        return current->Delete(symbol);
    }

    SymbolInfo* Lookup(SymbolInfo symbol)
    {
        temp = current;
        while(temp != NIL)
        {
            if(temp->Lookup(symbol) != NIL)
            {
                break;
            }
            else
            {
                temp = temp->getParentScope();
            }
        }
        return temp->Lookup(symbol);
    }
    PrintAllTables();
    PrintCurrentTable();
};


int32_t main()
{
    int N;
    cin>>N;
    while(1)
    {

    }
}
