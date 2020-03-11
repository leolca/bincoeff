function multicoeffparallelbenchmark (referencefile, themcoefunction)
% ./multicoefftable.sh -n 20 -m 3 -p > multicoefftable_m3_max20.txt
% referencefile = 'multicoefftable_m3_n20_all.txt';
times = 1E1;
bashcmd = cstrcat('cat ',referencefile,' | cut -d " " -f 1 | sort -n | uniq | tail -n 1');
[status, output] = system (bashcmd);
top_n = str2num (output);
bashcmf = cstrcat('cat ','head -n 1 ',referencefile,' | grep -E "(([0-9]+,)+[0-9]+)+" -o | awk -F, "{print NF}"');
[status, output] = system (bashcmd);
m = str2num (output);
mcoefunctions = {'ymulticoeff','gmulticoeff','multicoeff','armulticoeff','aymulticoeff','vfmulticoeff','fftmulticoeff','lemulticoeff'};
idfunction = find (strcmp (mcoefunctions,themcoefunction) == 1);
if isempty(idfunction), error('multinomial function not found'); endif
elapsed_time_avg = zeros(top_n+1,1);
elapsed_time_med = zeros(top_n+1,1);
elapsed_time_min = zeros(top_n+1,1);
countsn = zeros(top_n+1,1);
errorsn = zeros(top_n+1,1);
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
  %disp(str);
  if n != sum(k), error('sum(k) and n do not match: %s',str); endif;
     cmd = cstrcat (mcoefunctions{idfunction},'([',num2str(k),'])');
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
     elapsed_time_med(n+1,1) += median(runtimes);
     elapsed_time_min(n+1,1) += min(runtimes);
     elapsed_time_avg(n+1,1) += sum(runtimes)/times;
     countsn(n+1,1)++;
     errorsn(n+1,1)+=abs(r-c);
     fflush(stdout);
endwhile
fclose (fid);

%
% test execution time to compute all multinomial coefficients in a given level n
%
elapsed_time_all_avg = zeros(top_n+1,1);
elapsed_time_all_med = zeros(top_n+1,1);
elapsed_time_all_min = zeros(top_n+1,1);
for n=1:top_n,
  parfor i=1:length(mcoefunctions),
     cmd = cstrcat (mcoefunctions{idfunction},'(',num2str(n),',',num2str(2),')');
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
     elapsed_time_all_med(n+1,1) += median(runtimes);
     elapsed_time_all_min(n+1,1) += min(runtimes);
     elapsed_time_all_avg(n+1,1) += sum(runtimes)/times;
     fflush(stdout);
  endparfor
endfor

outfilename = cstrcat ('multicoeffparallelbenchmark_',mcoefunctions{idfunction},'.dat');

save('-binary',outfilename,'elapsed_time_avg','elapsed_time_min','elapsed_time_med','errorsn','countsn','elapsed_time_all_med','elapsed_time_all_min','elapsed_time_all_avg');

endfunction
