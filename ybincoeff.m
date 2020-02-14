function c = ybincoeff(n,k)
%
%  compute the binomial coefficient 
%
%        /n\   n (n-1) (n-2) ... (n-k+1)
%  nCk = | | = -------------------------
%        \k/              k!
%
%  uses yannis manolopoulos iterative method
%
%  if k is a vector, compute all coefficients nCk 

   if nargin < 2 || isempty (k), k = [0:n]; endif;
   if n>47, warning ('possible loss of precision'); endif
   if n < k || n < 0 || k < 0, c = 0; 
   else,
     k = min(k, n-k); % symmetry
     c = [];
     for i=1:length(k),
       c(i) = round( prod( [n-k(i)+1:n] ./ [1:k(i)] ) );
     endfor;
   endif;

endfunction
