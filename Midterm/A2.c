#include<stdio.h>

void fibonacci(int n) {
    int fibo1 = 0;
    int fibo2 = 1;
    int fibo;

    // Print the first two Fibonacci numbers
    printf("%d ", fibo1);
    printf("%d ", fibo2);

    while(1) {
        fibo = fibo1 + fibo2;
        if (fibo > n) {
            break;
        }
        printf("%d ", fibo);
        fibo1 = fibo2;
        fibo2 = fibo;
    }
}

int main() {
    int n;
    printf("Enter a number: ");
    scanf("%d", &n);
    fibonacci(n);
    return 0;
}
