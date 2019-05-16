function c = rbincoeff (n,k),
% rolfe good recursion method

   if(k==0 || k==n), 
      c = 1; 
   else
      c = round( (n/k)*rbincoeff (n-1,k-1) );
   endif

endfunction
