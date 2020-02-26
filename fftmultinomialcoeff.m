function C = fftmultinomialcoeff (n,m)
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


  %switch m,
  %  case 2, c = [1 1]; 
  %  case 3, c = [1 1; 1 0];
  %  case 4, c(:,:,1) = [1 1; 1 0]; c(:,:,2) = [1 0; 0 0];
  %otherwise,
  %  error ('not implemented');
  %end

  %c = 1;
  %if m > 1, c(1,2) = 1; endif
  %if m > 2, sc = size(c); d=zeros(sc); d(1)=1; c(2,:)=d; endif %c(2,1) = 1; endif
  %if m > 3, c(1,1,2) = 1; endif
  %if m > 4, c(1,1,1,1) = 1; endif
  %c = 1;
  %if m > 1, c(1,2) = 1; endif
  %if m > 2, c(1,1,2) = 1; endif
  %if m > 3, c(1,1,1,2) = 1; endif
  %if m > 4, c(1,1,1,1,2) = 1; endif
  % ... and so on
 
  %c = vec ([0 0], m);
  %c(1) = 1;
  %for i=1:m-1, 
  %  c(2*i) = 1;
  %endfor

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

endfunction
