function c = lucasmodbincoeff(n,k,m)
%
%  compute the modular binomial coefficient 
%
%              /n\         n (n-1) (n-2) ... (n-k+1)
%  nCk mod m = | | mod m = ------------------------- mod m
%              \k/                     k!
%
%  uses Lucas's theorem 
%  for given n and k, a congruence relation holds
%  nCk mod m = \prod_{i=0}^k n_iCk_i mod m
%
%  if k is a vector, compute all coefficients nCk 
%  if m is given, compute the modular m coefficient:  nCk mod m

   if nargin < 2 || isempty (k), k = [0:n]; endif;
   if nargin < 3, m = 1; endif
   if !isprime (m), error('a prime number is required'); endif
   k = min(k, n-k); % symmetry
   if length(k) > 1,
      c = [];
      for i=1:length(k),
          c(i) = lucasmodbincoeff(n,k(i),m);
      endfor
   else
      % use Luca's Theorem
      if n < m && k < m,
         c = mod(ybincoeff(n,k),m);
      else, 
         c = 1;
         ns = xinbasem (n,m);
         ks = xinbasem (k,m);
         ks = [ks zeros(1,length(ns)-length(ks))];
         for i = 1 : length(ns),
    	     c = mod( c * lucasmodbincoeff(ns(i),ks(i),m), m); 
         endfor;
      endif;
   endif;

endfunction

function xm = xinbasem (x,m)
    l = floor(log(x)/log(m));
    xm = zeros(1,l+1);
    for i=l:-1:0,
	xm(i+1) = floor(x/m^i);
	x -= xm(i+1)*m^i;
    endfor
endfunction

