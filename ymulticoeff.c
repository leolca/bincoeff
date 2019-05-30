#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>
#include <assert.h>

void gmpmultinomialcoefficient(mpf_t result, int* ks, int m, int n) {
   mpf_set_ui(result,1);
   for(int i=1; i<m; ++i){
      for(int j=ks[i]; j>0; --j){
         mpf_mul_ui(result,result,n); n--;
	 mpf_div_ui(result,result,j);
      }
   }
}

// function to sort descending
int compare (const void * a, const void * b)
{
  return ( *(int*)b - *(int*)a );
}

int main(int argc, char *argv[]) {
  int m = argc-1;
  int n = 0;
  int *ks = malloc(m * sizeof(int));
  mpf_t mcoef;
  mpf_init(mcoef);
  mpf_t delta;
  mpf_init(delta);
  mpf_set_d(delta,0.5);

  for(int i=0; i<m; ++i) {
     ks[i] = atoi(argv[i+1]);
     n += ks[i];
  }

  qsort (ks, m, sizeof(int), compare);
  gmpmultinomialcoefficient(mcoef, ks, m, n);
  // rounding
  mpf_add(mcoef,mcoef,delta);
  mpf_floor(mcoef,mcoef);
  gmp_printf("%.0Ff\n", mcoef);

  mpf_clear(mcoef);
  free(ks);
  return 0;
}
