#include<stdio.h>
//
// gcc buffer.c -o buffer -fno-stack-protector -z execstack -no-pie -m32

void main(){
	char buffer[64];
	printf("This is not safe\n");

	printf("Whats Name: ?");
	gets(buffer);
	printf("%s",buffer);
	
}
