clear all; close all; fftw('dwisdom','');
% https://octave.org/doc/interpreter/Paging-Screen-Output.html
page_output_immediately (1); 

top_n = 100;
times = 1E3;
med_elapsed_time = [];
min_elapsed_time = [];
legends = {};
cmethod = 0; % method counter

disp('yannis manolopoulos');
cmethod++;
t_yannis = [];
for n=2:top_n,	
    tstart = tic();
    for m=1:times,
	tstart = tic();
        for k=0:n, c = ybincoeff (n,k); endfor % 1 - duplicated to amortize the overhead of the loop
	for k=0:n, c = ybincoeff (n,k); endfor % 2
	for k=0:n, c = ybincoeff (n,k); endfor % 3
	for k=0:n, c = ybincoeff (n,k); endfor % 4
	for k=0:n, c = ybincoeff (n,k); endfor % 5
	telapsed = toc(tstart);
	t_yannis(n-1,m) = telapsed/5;
    endfor
    med_elapsed_time(n-1,cmethod) = median(t_yannis(n-1,:))/times;
    min_elapsed_time(n-1,cmethod) = min(t_yannis(n-1,:))/times;
endfor
legends = [legends, 'ybincoeff'];

disp('gamma function');
cmethod++;
t_gamma = [];
for n=2:top_n,
    for m=1:times,
	tstart = tic();
	c = gbincoeff (n,[0:n]); % 1
	c = gbincoeff (n,[0:n]); % 2
	c = gbincoeff (n,[0:n]); % 3 
	c = gbincoeff (n,[0:n]); % 4
	c = gbincoeff (n,[0:n]); % 5
	telapsed = toc(tstart);
        t_gamma(n-1,m) = telapsed/5;
    endfor
    med_elapsed_time(n-1,cmethod) = median(t_gamma(n-1,:))/times;
    min_elapsed_time(n-1,cmethod) = min(t_gamma(n-1,:))/times;
endfor
legends = [legends, 'gbincoeff'];

disp('dft');
cmethod++;
t_dft = [];
for n=2:top_n,
    for m=1:times,
	tstart = tic();
	c = fbincoeff (n,[0:n]); % 1
	c = fbincoeff (n,[0:n]); % 2
	c = fbincoeff (n,[0:n]); % 3
	c = fbincoeff (n,[0:n]); % 4
	c = fbincoeff (n,[0:n]); % 5
	telapsed = toc(tstart);
	t_dft(n-1,m) = telapsed/5;
    endfor
    med_elapsed_time(n-1,cmethod) = median(t_dft(n-1,:))/times;
    min_elapsed_time(n-1,cmethod) = min(t_dft(n-1,:))/times;
endfor
legends = [legends, 'fbincoeff'];

disp('fft');
cmethod++;
t_fft = [];
for n=2:top_n,
    for m=1:times,
	tstart = tic(); % fftw('dwisdom',''); clear wisdom in each run makes no difference
        c = fftbincoeff(n); % 1
	c = fftbincoeff(n); % 2
	c = fftbincoeff(n); % 3
	c = fftbincoeff(n); % 4
	c = fftbincoeff(n); % 5
	telapsed = toc(tstart);
	t_fft(n-1,m) = telapsed/5;
    endfor
    med_elapsed_time(n-1,cmethod) = median(t_dft(n-1,:))/times;
    min_elapsed_time(n-1,cmethod) = min(t_dft(n-1,:))/times;
endfor
legends = [legends, 'fftbincoeff'];

if false,
disp('fft using wisdom');
cmethod++;
load fftwisdom.dat;
fftw ('dwisdom', wisdom);
t_fftw = [];
for n=2:top_n,
    for m=1:times,
	tstart = tic();
        c = fftbincoeff(n); % 1
	c = fftbincoeff(n); % 2 
	c = fftbincoeff(n); % 3
	c = fftbincoeff(n); % 4
	c = fftbincoeff(n); % 5
	telapsed = toc(tstart);
	t_fftw(n-1,m) = telapsed/5;
    endfor
    med_elapsed_time(n-1,cmethod) = median(t_fftw(n-1,:))/times;
    min_elapsed_time(n-1,cmethod) = min(t_fftw(n-1,:))/times;
endfor
legends = [legends, 'fftwbincoef'];
endif

disp('rolfe good recursion method');
cmethod++;
t_rolfe = [];
for n=2:top_n,
    for m=1:times,
	tstart = tic();
        for k=0:n, c = rbincoeff (n,k); endfor % 1
	for k=0:n, c = rbincoeff (n,k); endfor % 2
	for k=0:n, c = rbincoeff (n,k); endfor % 3
	for k=0:n, c = rbincoeff (n,k); endfor % 4
	for k=0:n, c = rbincoeff (n,k); endfor % 5
	telapsed = toc(tstart);
        t_rolfe(n-1,m) = telapsed/5;
    endfor
    med_elapsed_time(n-1,cmethod) = median(t_rolfe(n-1,:))/times;
    min_elapsed_time(n-1,cmethod) = min(t_rolfe(n-1,:))/times;
endfor
legends = [legends, 'rbincoeff'];

disp('prime factor cancellations');
cmethod++;
t_prime = [];
for n=2:top_n,
    for m=1:times,
	tstart = tic();
        for k=0:n, c = pfbincoeff (n,k); endfor % 1
	for k=0:n, c = pfbincoeff (n,k); endfor % 2
	for k=0:n, c = pfbincoeff (n,k); endfor % 3
	for k=0:n, c = pfbincoeff (n,k); endfor % 4
	for k=0:n, c = pfbincoeff (n,k); endfor % 5
	telapsed = toc(tstart);
        t_prime(n-1,m) = telapsed/5;
    endfor
    med_elapsed_time(n-1,cmethod) = median(t_prime(n-1,:))/times;
    min_elapsed_time(n-1,cmethod) = min(t_prime(n-1,:))/times;
endfor
legends = [legends, 'pfbincoeff'];

lbl_norm = 'gbincoeff';
id_norm = find(not(cellfun('isempty',strfind(legends,lbl_norm))));
normalized_med_elapsed_time = (med_elapsed_time./(n+1)');
normalized_med_elapsed_time = normalized_med_elapsed_time./normalized_med_elapsed_time(:,id_norm);
normalized_min_elapsed_time = (min_elapsed_time./(n+1)');
normalized_min_elapsed_time = normalized_min_elapsed_time./normalized_min_elapsed_time(:,id_norm);


disp('plot');
hf = figure ();
basename = 'benchmarkvector';
extension = '.svg'

sz_legend = length(legends);
% set colours
colours = {'r';'g';'b';'k';'c';'m'}; n_colours = length(colours);
if n_colours<sz_legend; colours = repmat(colours, ceil(sz_legend/n_colours), 1); end
colours = colours(1:1:sz_legend);
% set markers
markers = {'o';'+';'*';'s';'d';'v';'>';'h'}; n_markers = length(markers);
if n_markers<sz_legend; markers = repmat(markers, ceil(sz_legend/n_markers), 1); end
markers = markers(1:1:sz_legend);
% set linestyles
linestyle = {'-';'--';':';'-.'}; n_lines = length(linestyle);
if n_lines<sz_legend; linestyle = repmat(linestyle, ceil(sz_legend/n_lines), 1); end
linestyle = linestyle(1:1:sz_legend);

p = semilogy([2:top_n],med_elapsed_time);
for ip = 1 : length(p),
  set(p(ip),'color',colours{ip},'linestyle',linestyle{ip},'linewidth',2);
  %set(p(ip),'color',colours{ip},'linestyle',linestyle{ip},'marker',markers{ip},'linewidth',2);
endfor
xlabel('n'); ylabel('avg time (ms)');
legend(legends,'location','northwest');
fname = cstrcat(basename,'_',num2str(times),extension);
print (hf, fname, "-dsvg");

%p = semilogy([2:top_n],normalized_med_elapsed_time);
%p = loglog([2:top_n],normalized_med_elapsed_time);
p = loglog([2:top_n],normalized_min_elapsed_time);
for ip = 1 : length(p),
  set(p(ip),'color',colours{ip},'linestyle',linestyle{ip},'linewidth',2);
  %set(p(ip),'color',colours{ip},'linestyle',linestyle{ip},'marker',markers{ip},'linewidth',2);
endfor
ylim([0.8 10000]); xlim([2 100]);
xlabel('n'); ylabel(cstrcat('runtime relative to ',lbl_norm));
legend(legends,'location','northwest');
fname = cstrcat(basename,'_normalized_',num2str(times),extension);
print (hf, fname, "-dsvg");

fwname = cstrcat(basename,'_normalized_',num2str(times),'.dat');
save (fwname);
