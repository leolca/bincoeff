# bincoeff
binomial coefficient computation

the following methods are available here:
1. Pascal recursion [pbincoeff.m](#pbincoeff) [download](pbincoeff.m)
2. Rolfe recursion  [rbincoeff.m](#rbincoeff) [download](rbincoeff.m)
3. 

## pbincoeff.m <a name="pbincoeff"></a>
![img](imgs/pbincoeff.png)
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
![img](imgs/rbincoeff.png)
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
