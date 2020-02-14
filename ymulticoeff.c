#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>
#include <assert.h>

void gmpmultinomialcoefficient(mpq_t result, int* ks, int m, int n) {
   mpq_set_ui(result,1,1);
   mpq_t aux;
   mpq_init(aux);
   for(int i=1; i<m; ++i){
      for(int j=ks[i]; j>0; --j){
	 mpq_set_ui(aux,n--,j);
	 mpq_mul(result,result,aux);
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
  mpq_t mcoef;
  mpq_init(mcoef);
  mpz_t mcoefz, num, den;
  mpz_init(mcoefz); mpz_init(num); mpz_init(den);

  for(int i=0; i<m; ++i) {
     ks[i] = atoi(argv[i+1]);
     n += ks[i];
  }

  qsort (ks, m, sizeof(int), compare);
  gmpmultinomialcoefficient(mcoef, ks, m, n);
  
  mpq_get_num(num,mcoef);
  mpq_get_den(den,mcoef);
  mpz_div(mcoefz,num,den);
  mpz_out_str(stdout,10,mcoefz);

  mpq_clear(mcoef); 
  mpz_clear(mcoefz); mpz_clear(num); mpz_clear(den);
  free(ks);
  printf("\n");
  fflush(stdout);
  return 0;
}
