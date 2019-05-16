function c = pfbincoeff (n, k)
% prime factorization

  k = min(n-k,k); % use symmetry
  i = (n-k+1):n;
  for l=k:-1:2,
     lp = factor(l);
     for p = lp,
	 id = find(mod(i,p) == 0, 1, 'last');
	 i(id) = i(id)/p;
     endfor
  endfor;
  c = prod(i, 'native');

endfunction
