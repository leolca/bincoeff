function c = pbincoeff (n,k),
% pascal based method

   if(k==0 || k==n), 
      c = 1; 
   else
      c = pbincoeff (n-1,k-1) + pbincoeff (n-1,k);
   endif

endfunction
