function c = stirlingmulticoeff (k)
% use stirling's approximations for factorial
% n! ~ sqrt(2 pi n) (n/e)^n

  n = sum(k);
  m = length(k);
  c = (2*pi)^((1-m)/2) * n^(n+0.5) * prod ( k.^(-k-0.5) ); % using eq. 5

  % using eq. 6
  % n = sum(k);
  % m = length(k);
  % idz = find (k==0);
  % k(idz) = [];
  % H = - sum( (k./n) .* log(k./n) );
  % c = (2*pi)^((1-m)/2) * sqrt(n/prod(k)) * exp (n*H);

endfunction
