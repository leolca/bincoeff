function c = gmulticoeff(n,m)
%  Compute the multinomial coefficient using gamma function
%
%       /           \ 
%       |     n     | 
%  c =  | k1 ... km |
%       \           /
%
%  c = gmulticoeff (k)
%  where k is an array k = [k1 k2 ... km] and 
%  n is simplicity given by the sum: n = sum(k)
% 
%  c = gmulticoeff (n,m)
%  computes all multinomials at level n
%  (m=2 for binomials, m=3 for trinomials, etc)



  if nargin < 2,
    k = n;
    c = round (exp (gammaln (sum(k)+1) - sum(gammaln(k+1)) ));
  else,
    r = npermutek([0:n],m);
    id = find ( sum(r,2) == n);
    r = r(id,:);
    c = [];
    for i = 1:size(r,1),
      c(i) = gmulticoeff (r(i,:));
    endfor
    c = c';
  endif
endfunction
