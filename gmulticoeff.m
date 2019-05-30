function c = gmulticoeff(k)

   c = round (exp (gammaln (sum(k)+1) - sum(gammaln(k+1)) ));

endfunction
