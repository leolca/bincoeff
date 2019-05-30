function c = multicoeff (k), 
  c=1; 
  for i=1:length(k), 
      c*=bincoeff(sum(k(1:i)),k(i)); 
  endfor; 
endfunction
