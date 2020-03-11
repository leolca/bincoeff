function c = sievemodbincoeff(n,k,m)
%  compute the modular binomial coefficient
%
%              /n\         n (n-1) (n-2) ... (n-k+1)
%  nCk mod m = | | mod m = ------------------------- mod m
%              \k/                     k!
%
%  if k is a vector, compute all coefficients nCk
%  if m is given, compute the modular m coefficient:  nCk mod m
%  uses a Sieve of Eratosthenes an compute the influence of each prime p
%  when decomposing m to compute the nCk mod m

   if nargin < 2 || isempty (k), k = [0:n]; endif;
   if nargin < 3, m = 1; endif
   k = min(k, n-k); % symmetry
   if length(k) > 1,
       c  = [];
       for i=1:length(k),
	   c(i) = sievemodbincoeff(n,k(i),m);
       endfor
   else
      c = 1;
      % Sieve of Eratosthenes
      sieve = zeros(1,n+1);
      for p=2:n,
          if !sieve(p),
   	     for i=p:p:n,
	         sieve(i)=1;
	     endfor
	     for pow=p.^[1:floor(log(n)/log(p))],
	         cnt = floor(n/pow) - floor(k/pow) - floor((n-k)/pow);
	         for j=0:cnt-1,
	   	     c *= p;
		     c = mod(c,m);
	         endfor
	     endfor
          endif
      endfor
   endif


