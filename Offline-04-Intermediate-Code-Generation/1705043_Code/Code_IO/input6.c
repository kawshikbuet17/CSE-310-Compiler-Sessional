int a;
int b;
int c;

void relop_1(){
    a = 1;
    b = 2;
    c = 3;

    c = a < b;
    println(c);

    c = a <= b;
    println(c);

    c = a > b;
    println(c);

    c = a >= b;
    println(c);

    c = a == b;
    println(c);

    c = a != b;
    println(c);
}

void relop_2(){
    a = 2;
    b = 1;
    c = 3;

    c = a < b;
    println(c);

    c = a <= b;
    println(c);

    c = a > b;
    println(c);

    c = a >= b;
    println(c);

    c = a == b;
    println(c);

    c = a != b;
    println(c);
}

void relop_3(){
    a = 2;
    b = 2;
    c = 3;

    c = a < b;
    println(c);

    c = a <= b;
    println(c);

    c = a > b;
    println(c);

    c = a >= b;
    println(c);

    c = a == b;
    println(c);

    c = a != b;
    println(c);
}

void relop_4(){
    a = 2;
    b = 2;
    c = 3;

    if(a < b){
        c = a < b;
        println(c);
    }
    
    if(a <= b){
        c = a <= b;
        println(c);
    }
    

    if(a > b){
        c = a > b;
        println(c);
    }
    

    if(a >= b){
        c = a >= b;
        println(c);
    }
    
    if(a == b){
        c = a == b;
        println(c);
    }

    if(a != b){
        c = a != b;
        println(c);
    }
}

int main(){
    relop_1();
    relop_2();
    relop_3();
    relop_4();
}