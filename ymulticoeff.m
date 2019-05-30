function c = ymulticoeff (k)
   n = sum(k);
   k = sort(k, 'descend');
   d = [];
   for i = 2:length(k), d = [d 1:k(i)]; endfor;
   d = sort(d); % avoid overflow
   c = round(prod([k(1)+1:n]./d));
endfunction
