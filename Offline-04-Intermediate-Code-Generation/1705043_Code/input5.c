int a;

void logicop_1(){
    int b;
	a = 11;
    b = 22;
    if(5 && 10){
        a = 1;
        println(a);
    }
    else if(10 && 0){
        b = 2;
        println(b);
    }
}

void logicop_2(){
    int b;
    int c;
	a = 11;
    b = 22;
    c = 33;
    a = b && c;
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

void logicop_3(){
    int b;
    int c;
	a = 11;
    b = 22;
    c = 33;
    if(0 && 1){
        a = 1;
        println(a);
    }
    else if(10 && 10){
        b = 2;
        println(b);
    }
    else{
        c = 3;
        println(c);
    }
}

void logicop_4(){
    int b;
    int c;
	a = 0;
    b = 22;
    c = 33;
    if(a && 1){
        a = 1;
        println(a);
    }
    else if(b && 0){
        b = 2;
        println(b);
    }
    else{
        c = 3;
        println(c);
    }
}

void logicop_5(){
    int b;
    int c;
	a = 0;
    b = 0;
    c = 33;
    if(a && 1){
        a = 1;
        println(a);
    }
    else if(b && 10){
        b = 2;
        println(b);
    }
    else{
        c = 3;
        println(c);
    }
}

void logicop_6(){
    int b;
	a = 11;
    b = 22;
    if(5 || 10){
        a = 1;
        println(a);
    }
    else if(10 || 0){
        b = 2;
        println(b);
    }
}

void logicop_7(){
    int b;
    int c;
	a = 11;
    b = 22;
    c = 33;
    if(a || 0){
        a = 1;
        println(a);
    }
    else if(10 || a){
        b = 2;
        println(b);
    }
    else{
        c= 3;
        println(c);
    }
}

void logicop_8(){
    int b;
    int c;
	a = 11;
    b = 22;
    c = 33;
    if(0 || 0){
        a = 1;
        println(a);
    }
    else if(10 || 10){
        b = 2;
        println(b);
    }
    else{
        c = 3;
        println(c);
    }
}

void logicop_9(){
    int b;
    int c;
	a = 0;
    b = 22;
    c = 33;
    if(a || 1){
        a = 1;
        println(a);
    }
    else if(b || 0){
        b = 2;
        println(b);
    }
    else{
        c = 3;
        println(c);
    }
}

void logicop_10(){
    int b;
    int c;
	a = 0;
    b = 0;
    c = 33;
    if(a || 1){
        a = 1;
        println(a);
    }
    else if(b || 10){
        b = 2;
        println(b);
    }
    else{
        c = 3;
        println(c);
    }
}

void logicop_11(){
    int b;
    int c;
	a = 0;
    b = 0;
    c = 33;
    if(a || 0){
        a = 1;
        println(a);
    }
    else if(b || 0){
        b = 2;
        println(b);
    }
    else{
        c = 3;
        println(c);
    }
}

void logicop_12(){
    int b;
    int c;
	a = 0;
    b = 0;
    c = 33;
    if(0 || a){
        a = 1;
        println(a);
    }
    else if(0 || b){
        b = 2;
        println(b);
    }
    else{
        c = 3;
        println(c);
    }
}

int main(){
    logicop_1();
    logicop_2();
    logicop_3();
    logicop_4();
    logicop_5();
    logicop_6();
    logicop_7();
    logicop_8();
    logicop_9();
    logicop_10();
    logicop_11();
    logicop_12();
}