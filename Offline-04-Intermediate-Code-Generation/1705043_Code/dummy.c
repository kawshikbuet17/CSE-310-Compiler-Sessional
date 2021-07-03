int a;
int b;
void logicop_2(){
    int b;
    int c;
	a = 11;
    b = 22;
    c = 33;
    if(a && 0){
        a = 1;
        println(a);
    }
    else if(10 && a){
        b = 2;
        println(b);
    }
    else{
        c = 3;
        println(c);
    }
}
int main(){
    logicop_2();
}