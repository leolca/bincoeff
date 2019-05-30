function c = armulticoeff (k),
% acelerated fft rolfe good recursion method

   ks = sort(k,'descend');
   n0 = ks(1)+ks(2);
   c0 = fftbincoeff(n0);
   c = c0(ks(2)+1);
   for i=3:length(k),
       c *= arbincoeff (sum(ks(1:i)), ks(i), c0);
   endfor

endfunction
