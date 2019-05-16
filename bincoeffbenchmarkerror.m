top_n = 100;
errorscoeff = [];
refcoeff = csvread ('bincoefftable.txt');

% yannis manolopoulos 
errorscoeff(1,1)=0;
for n=2:top_n,
    c = [];
    for k=0:n,
        c(k+1) = ybincoeff (n,k);
    endfor
    errorscoeff(n,1) = sum(refcoeff(n+1,1:n+1) - c);
endfor

% using gamma function
errorscoeff(1,2)=0;
for n=2:top_n,
    c = gbincoeff (n,[0:n]);
    errorscoeff(n,2) = sum(refcoeff(n+1,1:n+1) - c);
endfor

% dft
errorscoeff(1,3)=0;
for n=2:top_n,
    c = fbincoeff (n,[0:n]);
    errorscoeff(n,3) = sum(refcoeff(n+1,1:n+1) - c);
endfor

% fft
errorscoeff(1,4)=0;
for n=2:top_n,
    c = fftbincoeff(n);
    errorscoeff(n,4) = sum(refcoeff(n+1,1:n+1) - c);
endfor

% rolfe good recursion method
errorscoeff(1,5)=0;
for n=2:top_n,
    c = [];
    for k=0:n,
        c(k+1) = rbincoeff (n,k);
    endfor
    errorscoeff(n,5) = sum(refcoeff(n+1,1:n+1) - c);
endfor

% prime factor cancellations
%            c = mbincoeff (n,k);

% prime factor cancellations
errorscoeff(1,6)=0;
for n=2:top_n,
    c = [];
    for k=0:n,
        c(k+1) = pfbincoeff (n,k);
    endfor
    errorscoeff(n,6) = sum(refcoeff(n+1,1:n+1) - c);
endfor


hf = figure ();
%plot([1:top_n],errorscoeff./[1:top_n]', 'linewidth',2);
start=50; semilogy([start:top_n],abs(errorscoeff(start:end,:)./[start:top_n]'), 'linewidth',2);
xlabel('n'); ylabel('log avg error');
legend('ybincoeff','gbincoeff','fbincoeff','fftbincoeff','rbincoeff','pfbincoeff','location','northwest');
print (hf, "benchmarckerror.svg", "-dsvg");
%print (hf, "benchmarckerror.pdf", "-dpdflatexstandalone");
%system ("pdflatex benchmarckerror");
