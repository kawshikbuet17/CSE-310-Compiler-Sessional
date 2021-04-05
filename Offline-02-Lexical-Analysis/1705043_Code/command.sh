flex -o 1705043.c 1705043.l
g++ 1705043.c -lfl -o 1705043.out
./1705043.out sample_input1.txt
kompare -c 1705043_token.txt sample_token1.txt
