top_n = 150;
elapsed_time = zeros(top_n+1,5);
countsn = zeros(top_n+1,5);
errorsn = zeros(top_n+1,5);
mcoefunctions = {'ymulticoeff','gmulticoeff','multicoeff','armulticoeff','vfmulticoeff'};
referencefile = 'multicoefftable_m3_max50.txt';
fid = fopen (referencefile);
while ! feof (fid),
  str = fgetl (fid);
  sp = strsplit (str);
  k = str2num (sp{1});
  r = str2num (sp{2});
  n = sum(k);
  for i=1:length(mcoefunctions),
     cmd = cstrcat (mcoefunctions{i},'([',num2str(k),'])');
     tic;
     c = eval(cmd);
     elapsed_time(n+1,i) += toc;
     countsn(n+1,i)++;
     errorsn(n+1,i)+=abs(r-c);
  endfor
endwhile
fclose (fid);

save -binary multicoeffbenchmarck.dat elapsed_time errorsn countsn;

hf = figure ();
semilogy(elapsed_time./countsn, 'linewidth',2);
xlabel('n'); ylabel('avg time (ms)'); xlim ([0 top_n])
legend(mcoefunctions,'location','northwest');
print (hf, "multicoeffbenchmarck_time.svg", "-dsvg");

hf2 = figure ();
nmin=30; nmax=100;
semilogy([nmin:nmax],errorsn(nmin+1:nmax+1,:)./countsn(nmin+1:nmax+1,:),'linewidth',2);
yt=get(gca,'ytick'); yt=yt(1:5:end); set(gca,'ytick',yt);
xlabel('n'); ylabel('log avg error'); xlim ([nmin nmax]);
legend(mcoefunctions,'location','northwest');
print (hf2, "multicoeffbenchmarck_error_a.svg", "-dsvg");

es = find( sum(errorsn,2) > 0, 1);
em = max(errorsn(nmax,:));
plot([nmin:nmax],log10(errorsn(nmin+1:nmax+1,:)./countsn(nmin+1:nmax+1,:)),'linewidth',2);
xlabel('n'); ylabel('log avg error'); xlim ([es nmax]); ylim ([log10(es) log10(em)]);
yt=get(gca,'ytick'); ylbl={}; for l=1:length(yt), ylbl{l}=cstrcat('10^{',num2str(yt(l)),'}'); endfor; 
set(gca,'yticklabel',ylbl);
legend(mcoefunctions,'location','northwest');
print (hf2, "multicoeffbenchmarck_error_b.svg", "-dsvg");


