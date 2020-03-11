function c = multicoeff (n,m), 
%  Compute the multinomial coefficient using product of binomials
%
%       /           \ 
%       |     n     | 
%  c =  | k1 ... km |
%       \           /
%
%  c = multicoeff (k)
%  where k is an array k = [k1 k2 ... km] and 
%  n is simplicity given by the sum: n = sum(k)
% 
%  c = multicoeff (n,m)
%  computes all multinomials at level n
%  (m=2 for binomials, m=3 for trinomials, etc)

  if nargin < 2,
    k = n;
    c=1; 
    for i=1:length(k), 
      c*=bincoeff(sum(k(1:i)),k(i)); 
    endfor;
  else
    r = npermutek([0:n],m);
    id = find ( sum(r,2) == n);
    r = r(id,:);
    c = [];
    for i = 1:size(r,1),
      c(i) = multicoeff (r(i,:));
    endfor
    c = c';
  endif 
endfunction
