function c = armulticoeff (n,m),
%  Compute the multinomial coefficient using acelerated fft rolfe good recursion method
%
%       /           \ 
%       |     n     | 
%  c =  | k1 ... km |
%       \           /
%
%  c = armulticoeff (k)
%  where k is an array k = [k1 k2 ... km] and 
%  n is simplicity given by the sum: n = sum(k)
% 
%  c = armulticoeff (n,m)
%  computes all multinomials at level n
%  (m=2 for binomials, m=3 for trinomials, etc)


if nargin < 2,
   k = n;
   ks = sort(k,'descend');
   n0 = ks(1)+ks(2);
   c0 = fftbincoeff(n0);
   c = c0(ks(2)+1);
   for i=3:length(k),
       c *= arbincoeff (sum(ks(1:i)), ks(i), c0);
   endfor
else,
   r = npermutek([0:n],m);
   id = find ( sum(r,2) == n);
   r = r(id,:);
   c = [];
   for i = 1:size(r,1),
     c(i) = armulticoeff (r(i,:));
   endfor
   c = c';
endif

endfunction
