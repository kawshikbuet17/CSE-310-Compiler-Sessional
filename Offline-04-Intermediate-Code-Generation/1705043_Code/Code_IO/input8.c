int a;

void loop_1(){
    int i;
    int sum;
    sum = 0;
    for(i=0; i<5; i++){
        sum = sum + i;
    }
    println(sum);
}
void loop_2(){
    int i;
    int sum;
    a = 5;
    sum = 0;
    for(i=0; i<a; i++){
        sum = sum + i;
    }
    println(sum);
}

void loop_3(){
    int i;
    int sum;
    a = 5;
    sum = 0;
    for(i=0; i<a; i++){
        sum = sum + i;
        println(sum);
    }
}

int main(){
    loop_1();
    loop_2();
    loop_3();
}