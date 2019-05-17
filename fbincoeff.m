function c = fbincoeff(n,k), 

  if n > 0,
    l = [1:floor(n/3)+1]';
    c = round( (2^n/(n+1)) * (1+2*sum(cos(pi*l/(n+1)).^n.*cos(pi*l.*(2*k-n)./(n+1)), 1)) );
  else
    c = 1;
  endif

endfunction

