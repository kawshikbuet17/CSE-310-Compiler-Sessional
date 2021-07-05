$$->code += ";for i=0 start\n";
							$$->code += $3->code;
							$$->code += ";for i=0 end\n";
							string label1 = newLabel();
							string label2 = newLabel();
							$$->code += label1+":\n";
							$$->code += ";i<10 start\n";
							$$->code += $4->code;
							$$->code += ";i<10 end\n";
							$$->code += "CMP AX, 0\n";
							$$->code += "JE "+label2+"\n";

							$$->code += $7->code;
							$$->code += ";i++ start\n";
							$$->code += $5->code;
							$$->code += ";i++ end\n";
							$$->code += "JMP "+label1+"\n";
							$$->code += label2 + ":\n";



void loop_2(){
    int i;
    int sum;
    a = 10;
    sum = 0;
    for(i=0; i<a; i++){
        sum = sum + i;
    }
    println(sum);
}

void loop_3(){
    int i;
    int sum;
    a = 10;
    sum = 0;
    for(i=0; i<a; i++){
        sum = sum + i;
        println(sum);
    }
}