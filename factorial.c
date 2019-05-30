#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>
#include <assert.h>

void gmpfactorial(mpz_t result, int n) {
   mpz_set_ui(result,1);
   for(int i=1; i < n+1; i++)
      mpz_mul_ui(result,result,i);
}

int intfactorial(int n) {
   int f = 1;
   for(int i=1; i < n+1; i++)
      f = f*i;
   return f;
}

uint uintfactorial(int n) {
   uint f = 1;
   for(int i=1; i < n+1; i++)
      f = f*(uint)i;
   return f;
}

float floatfactorial(int n){
   float f = 1;
   for(int i=1; i < n+1; i++)
      f = f*(float)i;
   return f;
}

double doublefactorial(int n) {
   double f = 1;
   for(int i=1; i < n+1; i++)
      f = f*(double)i;
   return f;
}

int main(int argc, char *argv[]) {
  int n;
  double dfac;
  float ffac;
  int ifac;
  uint uifac;
  mpz_t mfrac;
  mpz_init(mfrac);

  if (argc > 1) 
    n = atoi( argv[1] );
  else
    n = 1;
  
  dfac = doublefactorial(n);
  ffac = floatfactorial(n);
  ifac = intfactorial(n);
  uifac = uintfactorial(n);
  gmpfactorial(mfrac, n); 

  printf("%d\t%d (%d bits)\t%u (%d bits)\t%.0f (%d bits)\t%.0lf (%d bits)\t", (int) n, ifac, 8*(int) sizeof(int), uifac, 8*(int) sizeof(uint), ffac, 8*(int) sizeof(float), dfac, 8*(int) sizeof(double));
  gmp_printf ("%Zd", mfrac);
  printf(" (%d bits)\n", 8*(int) sizeof(mfrac));

  mpz_clear(mfrac);
  return 0;
}
