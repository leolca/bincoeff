<script type="text/javascript" async src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-MML-AM_CHTML"</script>

# bincoeff
binomial coefficient computation

the following methods are available here:
1. Pascal recursion [pbincoeff.m](#pbincoeff) [download](pbincoeff.m)
2. Rolfe recursion  [rbincoeff.m](#rbincoeff) [download](rbincoeff.m)
3. 

## pbincoeff.m <a name="pbincoeff"></a>
$$ \binom{n}{k} = \binom{n-1}{k} + \binom{n-1}{k-1}. $$
```
octave:1> for n=0:10, for k=0:n, printf('%d\t',pbincoeff(n,k)); end; printf('\n'); end;
1	
1	1	
1	2	1	
1	3	3	1	
1	4	6	4	1	
1	5	10	10	5	1	
1	6	15	20	15	6	1	
1	7	21	35	35	21	7	1	
1	8	28	56	70	56	28	8	1	
1	9	36	84	126	126	84	36	9	1	
1	10	45	120	210	252	210	120	45	10	1	
```

## rbincoeff.m <a name="rbincoeff"></a>
$$ \binom{n}{k} = \frac{\prod_{i=n-k+1}^n i}{k!} = \frac{n}{k} \cdot \frac{\prod_{i=n-k+1}^{n-1} i}{k!} = \frac{n}{k} \binom{n-1}{k-1}  , \quad \text{for } k > 0 $$
```for n=0:10, for k=0:n, printf('%d\t',rbincoeff(n,k)); end; printf('\n'); end;
1	
1	1	
1	2	1	
1	3	3	1	
1	4	6	4	1	
1	5	10	10	5	1	
1	6	15	20	15	6	1	
1	7	21	35	35	21	7	1	
1	8	28	56	70	56	28	8	1	
1	9	36	84	126	126	84	36	9	1	
1	10	45	120	210	252	210	120	45	10	1	
```
