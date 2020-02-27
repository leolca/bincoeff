function c = arbincoeff (n,k,known),
% acelerated rolfe good recursion method
% known is the vector of all {n choose k} for a given n

   if(k==0 || k==n), 
      c = 1; 
   else
      n0 = length(known)-1;
      m = n-n0;
      if m == 0,
	 c = known(k+1);
      else
	 c = round( (n/k)*arbincoeff (n-1,k-1,known) );
      endif
   endif

endfunction
