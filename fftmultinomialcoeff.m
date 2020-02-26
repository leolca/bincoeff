function C = fftmultinomialcoeff (n,m,rtype)
%
% C = fftmultinomialcoeff (n,m)
%
% Computes all multinomial coefficients at level n 
% where m is the multinomial dimension (m=1 for binomial,
% m=2 for trinomial, etc).
%
% C = fftmultinomialcoeff ([k1 k2 ... km])
% Returns only a specific binomial coefficient n choose k1, ..., km.
% m = length([k1, ..., km]) and n = sum([k1, ..., km])
%
  if nargin == 1,
     k = n;
     m = length(k);
     n = sum(k);
  endif

  c=zeros(1,2^m);
  if m > 1,
     c=reshape(c,2*ones(1,m));
  endif;
  c(1)=1;
  for i=0:m-1,
    c(2^i+1)=1;
  endfor

  if m > 1,
     C = real(round(ifftn( fftn(c,(n+1)*ones(1,m)).^(n) )));
  else,
     C = real(round(ifft( fft(c,n+1).^(n) )));
  endif

  if exist ('k') && !isempty (k),
     idx = idx=sum(k(2:end).*(n+1).^[0:length(k)-2])+1;
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
