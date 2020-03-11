% ./multicoefftable.sh -n 20 -m 3 -p > multicoefftable_m3_max20.txt
referencefile = 'multicoefftable_m3_n20_all.txt';
times = 1E1;
bashcmd = cstrcat('cat ',referencefile,' | cut -d " " -f 1 | sort -n | uniq | tail -n 1');
[status, output] = system (bashcmd);
top_n = str2num (output);
bashcmf = cstrcat('cat ','head -n 1 ',referencefile,' | grep -E "(([0-9]+,)+[0-9]+)+" -o | awk -F, "{print NF}"');
[status, output] = system (bashcmd);
m = str2num (output);
mcoefunctions = {'ymulticoeff','gmulticoeff','multicoeff','armulticoeff','aymulticoeff','vfmulticoeff','fftmulticoeff','lemulticoeff'};
n_methods = length(mcoefunctions);
elapsed_time_avg = zeros(top_n+1,n_methods);
elapsed_time_med = zeros(top_n+1,n_methods);
elapsed_time_min = zeros(top_n+1,n_methods);
countsn = zeros(top_n+1,n_methods);
errorsn = zeros(top_n+1,n_methods);
% * ymulticoeff
%   use Yannis Manolopoulos iterative method
% 
% * gmulticoeff
%   use gamma function to express factorials
%
% > methods that use the multinomial expressed as a product of binomial coefficients
%           /                 \     /    \ /      \    /                     \
%           |        n        |     | n  | | n-k1 |    | n-k1-k2-...-k_{m-1} |
%           |                 |  =  |    | |      | ...|                     |
%           | k1, k2, ..., km |     | k1 | |  k2  |    |         km          |
%           \                 /     \    / \      /    \                     /
%
%   * multicoeff
%     compute each binomial using octave bincoeff function (uses gamma function)
%   > methods that use FFT to compute all binomial coefficients in a given level and use this result to
%     fasten the computation of the binomial coefficients using another method
%     * armulticoeff
%       uses Rolfe's good recurtion to compute the binomial coefficient, recurring until the known level
%       computed by the FFT
%     * aymulticoeff
%       use Yannis Manolopoulos iterative method to computed the binomial coefficient, given the coefficients
%       already known in a upper level (given by FFT)
%   * vfmulticoeff
%     each binomial coefficient is computed by FFT, then the multinomial coefficient might be computed by
%     the product in the Fourier domain
% * fftmulticoef
%   uses the n-dimensional FFT to compute the multinomial coefficients
% * lemulticoeff
%   use exponential of logarithm 

fid = fopen (referencefile);
while ! feof (fid),
  str = fgetl (fid);
  sp = strsplit (str);
  n = str2num (sp{1});
  k = str2num (sp{2});
  r = str2num (sp{3});
  disp(str);
  if n != sum(k), error('sum(k) and n do not match: %s',str); endif;
  parfor i=1:length(mcoefunctions),
     disp(mcoefunctions{i});
     cmd = cstrcat (mcoefunctions{i},'([',num2str(k),'])');
     runtimes = [];
     for t=1:times,
       tic;
       c = eval(cmd);
       c = eval(cmd);
       c = eval(cmd);
       c = eval(cmd);
       c = eval(cmd);
       runtimes(t) = toc/5;
     endfor
     %if elapsed_time_med(n+1,i) == 0, elapsed_time_med(n+1,i) = median(runtimes); else elapsed_time_med(n+1,i)=(elapsed_time_med(n+1,i)+median(runtimes))/2; endif;
     %if elapsed_time_min(n+1,i) == 0, elapsed_time_min(n+1,i) = min(runtimes); else elapsed_time_min(n+1,i)=(elapsed_time_min(n+1,i)+min(runtimes))/2; endif;
     %if elapsed_time_avg(n+1,i) == 0, elapsed_time_avg(n+1,i) = sum(runtimes)/times; else elapsed_time_avg(n+1,i)=(elapsed_time_avg(n+1,i)+sum(runtimes)/times)/2; endif;
     elapsed_time_med(n+1,i) += median(runtimes);
     elapsed_time_min(n+1,i) += min(runtimes);
     elapsed_time_avg(n+1,i) += sum(runtimes)/times;
     countsn(n+1,i)++;
     errorsn(n+1,i)+=abs(r-c);
     fflush(stdout);
  endparfor
endwhile
fclose (fid);

save -binary multicoeffbenchmarck.dat elapsed_time_avg elapsed_time_min elapsed_time_med errorsn countsn;

hf = figure ();
semilogy([0:top_n], elapsed_time_med./countsn, 'linewidth',2);
xlabel('n'); ylabel('time (ms)'); xlim ([0 top_n])
legend(mcoefunctions,'location','northwest');
print (hf, "multicoeffbenchmarck_time.svg", "-dsvg");

hf2 = figure ();
nmin=1; nmax=top_n;
semilogy([nmin:nmax],errorsn(nmin+1:nmax+1,:)./countsn(nmin+1:nmax+1,:),'linewidth',2);
yt=get(gca,'ytick'); yt=yt(1:5:end); set(gca,'ytick',yt);
xlabel('n'); ylabel('log avg error'); xlim ([nmin nmax]);
legend(mcoefunctions,'location','northwest');
print (hf2, "multicoeffbenchmarck_error_a.svg", "-dsvg");

es = find( sum(errorsn,2) > 0, 1);
if ! isempty (es),
  em = max(errorsn(nmax,:));
  plot([nmin:nmax],log10(errorsn(nmin+1:nmax+1,:)./countsn(nmin+1:nmax+1,:)),'linewidth',2);
  xlabel('n'); ylabel('log avg error'); xlim ([es nmax]); ylim ([log10(es) log10(em)]);
  yt=get(gca,'ytick'); ylbl={}; for l=1:length(yt), ylbl{l}=cstrcat('10^{',num2str(yt(l)),'}'); endfor; 
  set(gca,'yticklabel',ylbl);
  legend(mcoefunctions,'location','northwest');
  print (hf2, "multicoeffbenchmarck_error_b.svg", "-dsvg");
endif



%
% test execution time to compute all multinomial coefficients in a given level n
%
elapsed_time_all_avg = zeros(top_n+1,n_methods);
elapsed_time_all_med = zeros(top_n+1,n_methods);
elapsed_time_all_min = zeros(top_n+1,n_methods);
for n=1:top_n,
  parfor i=1:length(mcoefunctions),
     disp(mcoefunctions{i});
     cmd = cstrcat (mcoefunctions{i},'(',num2str(n),',',num2str(2),')');
     runtimes = [];
     for t=1:times,
       tic;
       c = eval(cmd);
       c = eval(cmd);
       c = eval(cmd);
       c = eval(cmd);
       c = eval(cmd);
       runtimes(t) = toc/5;
     endfor
     elapsed_time_all_med(n+1,i) += median(runtimes);
     elapsed_time_all_min(n+1,i) += min(runtimes);
     elapsed_time_all_avg(n+1,i) += sum(runtimes)/times;
     fflush(stdout);
  endparfor
endfor

save -binary multicoeffbenchmarck_all.dat elapsed_time_avg elapsed_time_min elapsed_time_med errorsn countsn elapsed_time_all_med elapsed_time_all_min elapsed_time_all_avg;


hf = figure ();
semilogy([0:top_n], elapsed_time_all_med, 'linewidth',2);
xlabel('n'); ylabel('time (ms)'); xlim ([0 top_n])
legend(mcoefunctions,'location','northwest');
print (hf, "multicoeffbenchmarck_time_all.svg", "-dsvg");

