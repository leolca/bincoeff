function c = aybincoeff (n,k,known),
% acelerated yannis iterative method
% known is the vector of all {n choose k} for a given n

   if(k==0 || k==n), 
      c = 1; 
   else
      n0 = length(known)-1;
      m = n-n0;
      if k-m+1 > 0,
         c = round (prod([n:-1:n0+1] ./ [k-m+1:k]) * known(k-m+1));
      else
	 c = round (prod([n:-1:n-k+1] ./ [1:k]));
      endif
   endif

endfunction
