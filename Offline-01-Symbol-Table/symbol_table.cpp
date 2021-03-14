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

    string getId()
    {
        return id;
    }

    int setChildCount(int n)
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
            cout<<"Inserted in ScopeTable# "<< id <<" at position "<< hashVal <<", " << hashTable[hashVal].size()-1 << endl;
            return true;
        }
        else
        {
            cout << "<" << symbol.getSymbolName()<< "," << symbol.getSymbolType() << "> already exists in current ScopeTable"<<endl;
            return false;
        }
    }

    bool Delete(string symbolName)
    {
        int hashVal = hashFunction(symbolName);
        SymbolInfo* location = Lookup(symbolName);
        if(location != NIL)
        {
            swap(*location, hashTable[hashVal][hashTable[hashVal].size()-1]);
            hashTable[hashVal].pop_back();
            return true;
        }
        else
            return false;
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

    void Print()
    {
        cout << "ScopeTable # " << id << endl;
        for(int i=0; i<totalBuckets; i++)
        {
            cout << i << " --> ";
            for(auto j : hashTable[i])
            {
                cout<< " < " << j.getSymbolName() << " : " << j.getSymbolType() << " >  ";
            }
            cout<<endl;
        }
    }
};


class SymbolTable
{
    vector<ScopeTable> scope;
    ScopeTable* previous;
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
        previous = current;
        temp = NIL;
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
        cout << "New ScopeTable with id " << current->getId() << " created" << endl;
    }

    void ExitScope()
    {
        cout<<"ScopeTable with id "<<current->getId()<<" removed"<<endl;
        current = current->getParentScope();
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
    void PrintAllTables()
    {
        temp = current;
        while(temp != NIL)
        {
            PrintCurrentTable(temp);
            temp = temp->getParentScope();
        }
    }
    void PrintCurrentTable(ScopeTable* st)
    {
        st->Print();
    }
};


int32_t main()
{
    int N;
    cin >> N;

    SymbolTable* st = new SymbolTable(N);
    char c;

    while(cin>>c)
    {
        string symbolName, symbolType;

        if(c == 'I')
        {
            cin>>symbolName>>symbolType;
            SymbolInfo* si = new SymbolInfo(symbolName, symbolType);
            st->Insert(*si);
        }

        else if(c == 'L')
        {
            cin>>symbolName;
            st->Lookup(symbolName);
        }

        else if(c == 'D')
        {
            cin>>symbolName;
            st->Remove(symbolName);
        }

        else if(c == 'P')
        {
            char p;
            cin >> p;
            if(p == 'A')
            {
                st->PrintAllTables();
            }

            else if(p == 'C')
            {
                st->PrintCurrentTable(st->getCurrentScope());
            }
        }

        else if(c == 'S')
        {
            st->EnterScope();
        }

        else if(c == 'E')
        {
            st->ExitScope();
        }
    }
}
