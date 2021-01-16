#include<stdio.h>
//
// gcc buffer.c -o buffer -fno-stack-protector -z execstack -no-pie -m32

void main(){
	char buffer[64];
	printf("Simples programa na linguagem C para explicar um estouro de buffer\n");
	printf("E como isso pode levar usado para modificar o fluxo normal do programa\n");


	printf("Entre com um nome:?");
	gets(buffer);
	printf("%s",buffer);
	
}
