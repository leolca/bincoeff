function c = vfmulticoeff (n,m),
%  Compute the multinomial coefficient using Vandermonde's convolution and fft 
%
%       /           \ 
%       |     n     | 
%  c =  | k1 ... km |
%       \           /
%
%  c = vfmulticoeff (k)
%  where k is an array k = [k1 k2 ... km] and 
%  n is simplicity given by the sum: n = sum(k)
% 
%  c = vfmulticoeff (n,m)
%  computes all multinomials at level n
%  (m=2 for binomials, m=3 for trinomials, etc)

  if nargin < 2,
    k = n;
    ks = sort(k,'descend');
    c = 1;
    n = sum(ks);
    C = fft( [1 1 zeros(1,n-1)] ).^ks(1);
    for i = 2:length(ks),
      C = C .* fft( [1 1 zeros(1,n-1)] ).^ks(i);
      cvec = round(real(ifft(C)));
      c = c*cvec(ks(i)+1);
    endfor
  else
    r = npermutek([0:n],m);
    id = find ( sum(r,2) == n);
    r = r(id,:);
    c = [];
    for i = 1:size(r,1),
      c(i) = vfmulticoeff (r(i,:));
    endfor
    c = c';
  endif

endfunction
