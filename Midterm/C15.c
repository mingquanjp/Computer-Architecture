#include<stdio.h>
#include<string.h>
int main(){
	char A[100];
	char B[200];
	int C[10]={0};
	scanf("%s",A);
	scanf("%s",B);
	printf("%s\n",A);
	printf("%s\n",B);
	for(int i=0;i<strlen(A);i++){
		if (A[i] >= '0' && A[i] <'10'){
			C[A[i]-'0']++;
		
		
	}
	}
	for(int i=0;i<strlen(B);i++){
		if(B[i] >='0' && B[i] <'10'){
			C[B[i]- '0']++;
			
		}
	}
	for(int i=0;i<10;i++){
		if(C[i] == 0){
			printf("%d ",i);
		}
	}
	return 0;
	
}