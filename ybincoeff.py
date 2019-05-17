#!/usr/bin/env python
from bigfloat import *
import sys

def ybincoeff(n,k,p):
  with precision(p) + RoundTowardZero:
     k = min(k, n-k) # symmetry
     c = 1;
     num = range(n-k+1, n+1)
     den = range(1,k+1)
     for i in range(0, k):
         c = c * num[i]/den[i]
     return c


if __name__== "__main__":
  if len(sys.argv) > 2:
     n = int(sys.argv[1])
     k = int(sys.argv[2])
  if len(sys.argv) == 4:
     p = int(sys.argv[3])
  else:
     p = 100

  c = ybincoeff(n,k,p)
  print '%d' % c


