function c = ymodbincoeff(n,k,m)
%
%  compute the modular binomial coefficient 
%
%        /n\   n (n-1) (n-2) ... (n-k+1)
%  nCk = | | = -------------------------
%        \k/              k!
%
%  uses yannis manolopoulos iterative method and Fermat's little theorem
%
%  if k is a vector, compute all coefficients nCk 
%  if m is given, compute the modular m coefficient:  nCk mod m

   if nargin < 2 || isempty (k), k = [0:n]; endif;
   if nargin < 3, m = 1; endif
   if !isprime (m), error('a prime number is required'); endif
   k = min(k, n-k); % symmetry
   c = [];
   for i=1:length(k),
     if degreeof(n,m) > degreeof(k(i),m) + degreeof(n-k(i),m),
	c(i) = 0;
     else
	x = [n-k(i)+1:n]; y = [1:k(i)];
        num = modprod(x,m);
        den = modprod(y,m);
        c(i) = mod( num * mod(den^(m-2),m), m );
     endif
   endfor;

endfunction

function p = modprod(c,m)

   p = 1;
   for x = c,
     while mod(x,m)==0,
        x = x/m;
     endwhile
     p = mod(p*x,m);
   endfor;

endfunction

function r = degreeof(n,m)
    r = 0;
    s = m;
    while s <= n,
       r = r + floor(n/s);
       s = s*m;
    endwhile
endfunction


