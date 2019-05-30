function c = vfmulticoeff (k),
% using Vandermonde's convolution and fft

   ks = sort(k,'descend');
   c = 1;
   n = sum(ks);
   C = fft( [1 1 zeros(1,n-1)] ).^ks(1);
   for i = 2:length(ks),
       C = C .* fft( [1 1 zeros(1,n-1)] ).^ks(i);
       cvec = round(real(ifft(C)));
       c = c*cvec(ks(i)+1);
   endfor

endfunction
