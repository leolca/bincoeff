#include <stdio.h>
#include<stdlib.h>

double factorial(int n) {
   double f = 1;
   for(int i=1; i < n+1; i++)
      f = f*(double)i;
   return f;
}

float ffactorial(int n) {
   float f = 1;
   for(int i=1; i < n+1; i++)
      f = f*(float)i;
   return f;
}

int main(int argc, char *argv[]) {
  int n;
  double f;
  float ff;
  if (argc > 1) 
    n = atoi( argv[1] );
  else
    n = 1;
  f = factorial(n);
  ff = ffactorial(n);
  printf("%.0f\t%.0lf\n", ff, f);
  return 0;
}
