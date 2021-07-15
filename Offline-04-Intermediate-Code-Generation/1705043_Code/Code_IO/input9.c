void array_1(){
    int a[3];
    int b;
    a[2] = -10;
    b = a[2];
    println(b);
}

void array_2(){
    int arr[10];
    int i;
    int b;
    for(i=0; i<10; i++){
        arr[i] =  i;
        b = arr[i];
        println(b);
    }
}

void array_3(){
    int arr[10];
    int i;
    int b;
    for(i=0; i<10; i++){
        arr[i] =  1;
    }
    for(i=0; i<10; i++){
        arr[i] = arr[i];
        b = arr[i];
        println(b);
    }
}

void array_4(){
    int arr2[10];
    int i;
    int b;
    for(i=0; i<10; i++){
        arr2[i] =  1;
    }
    for(i=0; i<10; i++){
        arr2[i] = arr2[i]+arr2[i];
        b = arr2[i];
        println(b);
    }
}

int main(){
    array_4();
}