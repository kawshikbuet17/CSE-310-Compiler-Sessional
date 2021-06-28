int a;

void if_else_if_1(){
    int b;
	a = 10;
    b = 50;
    if(5){
        println(a);
    }
    else if(10){
        println(b);
    }
}

void if_else_if_2(){
    int b;
    int c;
	a = 10;
    b = 50;
    c = 100;
    if(a){
        println(a);
    }
    else if(10){
        println(b);
    }
    else{
        println(c);
    }
}

void if_else_if_3(){
    int b;
    int c;
	a = 10;
    b = 50;
    c = 100;
    if(0){
        println(a);
    }
    else if(10){
        println(b);
    }
    else{
        println(c);
    }
}

void if_else_if_4(){
    int b;
    int c;
	a = 0;
    b = 50;
    c = 100;
    if(a){
        println(a);
    }
    else if(b){
        println(b);
    }
    else{
        println(c);
    }
}

void if_else_if_5(){
    int b;
    int c;
	a = 0;
    b = 0;
    c = 100;
    if(a){
        println(a);
    }
    else if(b){
        println(b);
    }
    else{
        println(c);
    }
}

int main(){
    if_else_if_1();
    if_else_if_2();
    if_else_if_3();
    if_else_if_4();
    if_else_if_5();
}