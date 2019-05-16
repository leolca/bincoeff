function c = gbincoeff(n,k)

   c = round (exp (gammaln (n+1) - gammaln (k+1) - gammaln (n-k+1)));

endfunction
