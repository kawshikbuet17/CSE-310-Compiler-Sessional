int a;

void if_else_1(){
    int b;
	a = 10;
    b = 50;
    if(5){
        println(a);
    }else{
        println(b);
    }
}

void if_else_2(){
    int b;
	a = 10;
    b = 50;
    if(a){
        println(a);
    }else{
        println(b);
    }
}

void if_else_3(){
    int b;
	a = 10;
    b = 50;
    if(0){
        println(a);
    }else{
        println(b);
    }
}

void if_else_4(){
    int b;
	a = 0;
    b = 50;
    if(a){
        println(a);
    }else{
        println(b);
    }
}

int main(){
    if_else_1();
    if_else_2();
    if_else_3();
    if_else_4();
}