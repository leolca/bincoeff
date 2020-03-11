function c = pascalmodbincoeff(n,k,m)
%
%  compute the modular binomial coefficient 
%
%        /n\   n (n-1) (n-2) ... (n-k+1)
%  nCk = | | = -------------------------
%        \k/              k!
%
%  uses Pascal's recursion and modular arithmetics properties 
%
%  if k is a vector, compute all coefficients nCk 
%  if m is given, compute the modular m coefficient:  nCk mod m

   if nargin < 2 || isempty (k), k = [0:n]; endif;
   if nargin < 3, m = 1; endif
   k = min(k, n-k); % symmetry
   c = [];
   for i=1:length(k),
       if k(i) < 0 || k(i) > n, c(i) = 0;
       elseif n==0 || k(i)==n, c(i) = 1; 
       else c(i) = mod(mod(pascalmodbincoeff(n-1,k(i)-1,m),m) + mod(pascalmodbincoeff(n-1,k(i),m),m),m);
       endif
   endfor;

endfunction



