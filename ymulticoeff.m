function c = ymulticoeff (n,m)
%  Compute the multinomial coefficient using Yannis method
%
%       /           \ 
%       |     n     | 
%  c =  | k1 ... km |
%       \           /
%
%  c = ymulticoeff (k)
%  where k is an array k = [k1 k2 ... km] and 
%  n is simplicity given by the sum: n = sum(k)
% 
%  c = ymulticoeff (n,m)
%  computes all multinomials at level n
%  (m=2 for binomials, m=3 for trinomials, etc)

   if nargin < 2, 
      k = n; 
      n = sum(k);
      k = sort(k, 'descend');
      d = [];
      for i = 2:length(k), d = [d 1:k(i)]; endfor;
      d = sort(d); % avoid overflow
      c = round(prod([k(1)+1:n]./d));
   else,
      r = npermutek([0:n],m);
      id = find ( sum(r,2) == n);
      r = r(id,:);
      c = [];
      for i = 1:size(r,1),
          c(i) = ymulticoeff (r(i,:));
      endfor
      c = c';
   endif

endfunction
