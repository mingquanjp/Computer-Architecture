/*Nhập mảng từ bàn phím. Sắp xếp các phần tử có giá trị dương tăng dần, các
phần tử còn lại giữ nguyên vị trí. Ví dụ: Nhập mảng [-1, 150, 190, 170, -2, -3,
160, 180], kết quả sau khi sắp xếp [-1, 150, 160, 170, -2, -3, 180, 190].
*/
#include<stdio.h>
int main(){
	int a[]= {1,6,3,10,2};
	for (int i=0 ; i<n-1;i++){
		for (int j=i+1;j<n;j++){
			if (a[i] > a[j]){
				int temp = a[i];
				a[i] = a[j];
				a[j] = temp;
			}
		}
	}
	for(int i=0;i<5;i++){
		printf("%d ", a[i]);
	}
}



