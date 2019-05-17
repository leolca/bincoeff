function c = fftbincoeff(n,k)
  c = round(real(ifft(fft( [1 1 zeros(1,n-1)] ).^n))); 
  c = c(1:n+1); % fix for n=0
  if nargin > 1, c = c(k+1); endif
endfunction
