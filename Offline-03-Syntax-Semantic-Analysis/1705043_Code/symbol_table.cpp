#include <bits/stdc++.h>
using namespace std;

#define NIL NULL


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
    string id;
    int totalBuckets;
    vector<SymbolInfo> *hashTable;
    ScopeTable* parentScope;
    int childCount;

public:
    ScopeTable(int N, string id)
    {
        totalBuckets = N;
        this->id = id;
        hashTable = new vector<SymbolInfo>[totalBuckets];
        parentScope = NIL;
        childCount = 0;
    }

    ~ScopeTable()
    {
        delete [] hashTable;
    }

    void makeParentScope(ScopeTable* parentScope)
    {
        this->parentScope = parentScope;
    }

    ScopeTable* getParentScope()
    {
        return parentScope;
    }

    string getId()
    {
        return id;
    }

    void setChildCount(int n)
    {
        childCount = n;
    }

    int getChildCount()
    {
        return childCount;
    }

    void setHashTableSize(int N)
    {
        this->totalBuckets = N;
    }

    int hashFunction(string str)
    {
        //cout<<"ScopeTable hashFunction"<<endl;
        int hashVal = 0;
        int sumAscii = 0;
        for(int i=0; i<str.length(); i++)
        {
            sumAscii += str[i];
        }
        hashVal = sumAscii % totalBuckets;
        //cout<<"hashVal "<<hashVal<<endl;
        return hashVal;
    }

    bool Insert(SymbolInfo symbol)
    {
        //cout<<"ScopeTable Insert"<<endl;
        bool found = LookupBoolean(symbol.getSymbolName());

        if(found == false)
        {
            int hashVal = hashFunction(symbol.getSymbolName());
            hashTable[hashVal].push_back(symbol);
            //cout<<"Inserted in ScopeTable# "<< id <<" at position "<< hashVal <<", " << hashTable[hashVal].size()-1 << endl;
            return true;
        }
        else
        {
            //cout << "<" << symbol.getSymbolName()<< "," << symbol.getSymbolType() << "> already exists in current ScopeTable"<<endl;
            return false;
        }
    }

    bool Delete(string symbolName)
    {
        int hashVal = hashFunction(symbolName);
        SymbolInfo* location = Lookup(symbolName);
        int index = -1;
        if(location != NIL)
        {
            for(int i=0; i<hashTable[hashVal].size(); i++)
            {
                if(hashTable[hashVal][i].getSymbolName()==symbolName)
                    index = i;

            }
            swap(*location, hashTable[hashVal][hashTable[hashVal].size()-1]);
            hashTable[hashVal].pop_back();
            cout<<"Deleted Entry "<<hashVal<<", "<<index<<" from current ScopeTable"<<endl;
            return true;
        }
        else
        {
            cout<<symbolName<<" not found"<<endl;
            return false;
        }

    }

    bool LookupBoolean(string symbolName)
    {
        int hashVal = hashFunction(symbolName);
        bool found = false;
        for(int i=0; i<hashTable[hashVal].size(); i++)
        {
            if(hashTable[hashVal][i].getSymbolName() == symbolName)
            {
                found = true;
                break;
            }
        }
        return found;
    }

    SymbolInfo* Lookup(string symbolName)
    {
        //cout<<"ScopeTable Lookup"<<endl;
        int hashVal = hashFunction(symbolName);
        SymbolInfo* temp = NIL;
        for(int i=0; i<hashTable[hashVal].size(); i++)
        {
            if(hashTable[hashVal][i].getSymbolName() == symbolName)
            {
                temp = &hashTable[hashVal][i];
                cout<<"Found in ScopeTable# "<< id <<" at position "<< hashVal <<", " << i << endl;
                break;
            }
        }
        return temp;
    }

    void Print(ofstream& log_file)
    {
        log_file << "ScopeTable # " << id << endl;
        for(int i=0; i<totalBuckets; i++)
        {
            if(hashTable[i].size()==0)
                continue;
            log_file << i << " --> ";
            for(auto j : hashTable[i])
            {
                log_file<< " < " << j.getSymbolName() << " , " << j.getSymbolType() << " >  ";
            }
            log_file<<endl;
        }
        log_file<<endl;
    }
};


class SymbolTable
{
    vector<ScopeTable> scope;

    ScopeTable* current;
    ScopeTable* temp;

    int totalBucket;
    string previousCount;
    int currentCount;

public:
    SymbolTable(int N)
    {
        totalBucket = N;
        previousCount = "1";
        current = new ScopeTable(totalBucket, previousCount);
        current->makeParentScope(NIL);
        temp = NIL;
    }

    ~SymbolTable()
    {
        delete current;
    }

    ScopeTable* getCurrentScope()
    {
        return current;
    }
    void EnterScope()
    {
        //cout<<"EnterScope currentCount "<<current<<endl;
        string newId = current->getId() + "." + to_string(current->getChildCount()+1);
        current->setChildCount(current->getChildCount()+1);
        temp = new ScopeTable(totalBucket, newId);
        temp->makeParentScope(current);
        current = temp;
        //cout << "New ScopeTable with id " << current->getId() << " created" << endl;
    }

    void ExitScope()
    {
        //cout<<"ScopeTable with id "<<current->getId()<<" removed"<<endl;
        temp = current->getParentScope();
        delete current;
        current = temp;
    }

    bool Insert(SymbolInfo symbol)
    {
        //cout<<"SymbolTable Insert"<<endl;
        return current->Insert(symbol);
    }

    bool Remove(string symbolName)
    {
        return current->Delete(symbolName);
    }

    SymbolInfo* Lookup(string symbolName)
    {
        //cout<<"SymbolTable Lookup"<<endl;
        SymbolInfo* x;
        temp = current;
        while(temp != NIL)
        {
            x = temp->Lookup(symbolName);
            if(x != NIL)
            {
                break;
            }
            else
            {
                temp = temp->getParentScope();
            }
        }
        if(x == NIL)
        {
            cout<<"Not found"<<endl;
        }
        return x;
    }
    void PrintAllTables(ofstream& log_file)
    {
        temp = current;
        while(temp != NIL)
        {
            PrintCurrentTable(temp, log_file);
            temp = temp->getParentScope();
        }
    }
    void PrintCurrentTable(ScopeTable* st, ofstream& log_file)
    {
        st->Print(log_file);
    }
};
