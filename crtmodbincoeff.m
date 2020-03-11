function c = crtmodbincoeff(n,k,m,method)
%
%  compute the modular binomial coefficient 
%
%              /n\         n (n-1) (n-2) ... (n-k+1)
%  nCk mod m = | | mod m = ------------------------- mod m
%              \k/                     k!
%
%  uses Chinese remainder theorem
%  m must have square-free prime factors
%  may use Lucas's theorem or Fermat's Little theorem
%
%  if k is a vector, compute all coefficients nCk 

   if nargin < 2 || isempty (k), k = [0:n]; endif;
   if nargin < 3, m = 1; endif
   if nargin < 4, method = 'ymodbincoeff'; endif
   mf = factor(m);
   if length(mf) != length(unique(mf)), error('m must be composed of square-free prime factors!'); endif;

   k = min(k, n-k); % symmetry

   c = zeros(1,length(k));
   cr = [];
   if strcmp(method,'ymodbincoeff'),
      for mi = 1:length(mf),
          cr(mi,:) = ymodbincoeff(n,k,mf(mi));
      endfor
   else, % lucas
      for mi = 1:length(mf),
          cr(mi,:) = lucasmodbincoeff(n,k,mf(mi));
      endfor
   endif
   M = prod(mf);
   for j=1:size(cr,1),
       [r, s, t] = extended_gcd( floor(M/mf(j)), mf(j) );
       c += floor((cr(j,:)*s*M)/mf(j));
   endfor
   c = mod(c, M);

endfunction


