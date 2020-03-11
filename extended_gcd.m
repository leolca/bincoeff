function [r1, u1, v1] = extended_gcd(a, b)

  r1 = a; r2 = b; u1 = 1; v1 = 0; u2 = 0; v2 = 1;
  while (r2 != 0),
    q = floor(r1 / r2); 
    r3 = r1; u3 = u1; v3 = v1;
    r1 = r2; u1 = u2; v1 = v2;
    r2 = r3 - q * r2; u2 = u3 - q * u2; v2 = v3 - q * v2;
  endwhile

endfunction
