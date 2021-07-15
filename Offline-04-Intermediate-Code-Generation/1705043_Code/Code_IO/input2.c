int a;

void if_1(){
	a = 10;
    if(5){
        println(a);
    }
}

void if_2(){
	a = 10;
    if(a){
        println(a);
    }
}

void if_3(){
	a = 10;
    if(0){
        println(a);
    }
}

void if_4(){
	a = 0;
    if(a){
        println(a);
    }
}

int main(){
    if_1();
    if_2();
    if_3();
	if_4();
}