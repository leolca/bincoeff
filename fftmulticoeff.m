function C = fftmulticoeff (n,m,rtype)
%  Compute the multinomial coefficient using FFT
%
%       /           \
%       |     n     |
%  c =  | k1 ... km |
%       \           /
%
% C = fftmulticoeff (n,m)
% C = fftmulticoeff (n,m,rtype)
%
% Computes all multinomial coefficients at level n 
% where m is the multinomial dimension (m=2 for binomial,
% m=3 for trinomial, etc).
%
% rtype might be 'array' or 'matrix'.
%
% C = fftmulticoeff ([k1 k2 ... km])
% Returns only a specific binomial coefficient n choose k1, ..., km.
% m = length([k1, ..., km]) and n = sum([k1, ..., km])
%
  if nargin == 1,
     k = n;
     m = length(k);
     n = sum(k);
  endif

  c = zeros(2^(m-1),1);
  if m > 2,
     c = reshape(c,2*ones(1,m-1));
  endif;
  c(1) = 1;
  for i = 0:m-2,
    c(2^i+1) = 1;
  endfor

  if m > 2,
     C = real(round(ifftn( fftn(c,(n+1)*ones(1,m-1)).^(n) )));
  else,
     C = real(round(ifft( fft(c,n+1).^(n) )));
  endif

  if exist ('k') && !isempty (k),
     idx = sum(k(2:end).*(n+1).^[0:length(k)-2])+1;
     C = C(idx);
  endif

  if nargin < 3,
     rtype = 'array';
  endif     
  if length(C) > 1,
     if !strcmp (rtype, 'matrix'),
	idx = find (C > 0);
        C = C(idx);
     endif
  endif

endfunction
