function c = ybincoeff(n,k)

   k = min(k, n-k); % symmetry
   c = round( prod( [n-k+1:n] ./ [1:k] ) );

endfunction
