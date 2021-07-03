int a;
int b;

void incop_1(){
    a = 1;
    b = 2;
    println(a);
    println(b);

    a++;
    b++;
    println(a);
    println(b);
}

void incop_2(){
    a = -1;
    b = -2;
    println(a);
    println(b);

    a++;
    b++;
    println(a);
    println(b);
}

void decop_1(){
    a = 1;
    b = 2;
    println(a);
    println(b);

    a--;
    b--;
    println(a);
    println(b);
}

void decop_2(){
    a = -1;
    b = -2;
    println(a);
    println(b);

    a--;
    b--;
    println(a);
    println(b);
}

int main(){
    incop_1();
    incop_2();
    decop_1();
    decop_2();
}