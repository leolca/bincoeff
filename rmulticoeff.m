function c = rmulticoeff(k)

  if any(k < 0), c = 0;
  elseif sum(k == 0) == length(k)-1, c = 1; 
  else 
  c = 0;
  for i=1:length(k),
    c += rmulticoeff([ k(1:i-1), k(i)-1, k(i+1:end) ] );
  endfor;
  endif

endfunction
