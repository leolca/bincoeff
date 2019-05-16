top_n = 100;
times = 3E1;
elapsed_time = [];

% yannis manolopoulos 
for n=2:top_n,
    tic;
    for m=1:times,
        for k=0:n,
            c = ybincoeff (n,k);
        endfor
    endfor
    elapsed_time(n-1,1) = toc/times;
endfor

% using gamma function
for n=2:top_n,
    tic;
    for m=1:times,
	c = gbincoeff (n,[0:n]);
    endfor
    elapsed_time(n-1,2) = toc/times;
endfor

% dft
for n=2:top_n,
    tic;
    for m=1:times,
	c = fbincoeff (n,[0:n]);
    endfor
    elapsed_time(n-1,3) = toc/times;
endfor

% fft
for n=2:top_n,
    tic;
    for m=1:times,
        c = fftbincoeff(n);
    endfor
    elapsed_time(n-1,4) = toc/times;
endfor

% rolfe good recursion method
for n=2:top_n,
    tic;
    for m=1:times,
        for k=0:n,
            c = rbincoeff (n,k);
        endfor
    endfor
    elapsed_time(n-1,5) = toc/times;
endfor

% prime factor cancellations
%for n=2:top_n,
%    tic;
%    for m=1:times,
%        for k=0:n,
%            c = mbincoeff (n,k);
%        endfor
%    endfor
%    elapsed_time(n-1,5) = toc/times;
%endfor

% prime factor cancellations
for n=2:top_n,
    tic;
    for m=1:times,
        for k=0:n,
            c = pfbincoeff (n,k);
        endfor
    endfor
    elapsed_time(n-1,6) = toc/times;
endfor


hf = figure ();
semilogy(elapsed_time, 'linewidth',2);
xlabel('n'); ylabel('avg time (ms)');
legend('ybincoeff','gbincoeff','fbincoeff','fftbincoeff','rbincoeff','pfbincoeff','location','northwest');
print (hf, "benchmarckvec.svg", "-dsvg");
%print (hf, "benchmarckvec.pdf", "-dpdflatexstandalone");
%system ("pdflatex benchmarckvec");
