clear all; close all; fftw('dwisdom','');
warning off;
% https://octave.org/doc/interpreter/Paging-Screen-Output.html
page_output_immediately (1);

top_n = 100;
times = 1E3;
med_elapsed_time = [];
min_elapsed_time = [];
legends = {};
cmethod = 0; % method counter

% yannis manolopoulos 
disp('yannis manolopoulos');
cmethod++;
t_yannis = [];
for n=1:top_n,
    for m=1:times,
	tstart = tic();
        for k=0:n, c = ybincoeff (n,k); endfor % 1 - duplicated to amortize the overhead of the loop
	for k=0:n, c = ybincoeff (n,k); endfor % 2
	for k=0:n, c = ybincoeff (n,k); endfor % 3
	for k=0:n, c = ybincoeff (n,k); endfor % 4
	for k=0:n, c = ybincoeff (n,k); endfor % 5
	telapsed = toc(tstart);
	t_yannis(n,m) = telapsed/5;
    endfor
    med_elapsed_time(n,cmethod) = median(t_yannis(n,:))/times;
    min_elapsed_time(n,cmethod) = min(t_yannis(n,:))/times;
endfor
legends = [legends, 'ybincoeff'];


% using gamma function
disp('gamma function');
cmethod++;
t_gamma = [];
for n=1:top_n,
    for m=1:times,
	tstart = tic();
        for k=0:n, c = gbincoeff (n,k); endfor % 1
        for k=0:n, c = gbincoeff (n,k); endfor % 2
        for k=0:n, c = gbincoeff (n,k); endfor % 3
        for k=0:n, c = gbincoeff (n,k); endfor % 4
        for k=0:n, c = gbincoeff (n,k); endfor % 5
        telapsed = toc(tstart);
        t_gamma(n,m) = telapsed/5;
    endfor
    med_elapsed_time(n,cmethod) = median(t_gamma(n,:))/times;
    min_elapsed_time(n,cmethod) = min(t_gamma(n,:))/times;
endfor
legends = [legends, 'gbincoeff'];

% fft
disp('dft');
cmethod++;
t_dft = [];
for n=1:top_n,
    for m=1:times,
        tstart = tic();
        for k=0:n, c = fbincoeff (n,k); endfor % 1
        for k=0:n, c = fbincoeff (n,k); endfor % 2
        for k=0:n, c = fbincoeff (n,k); endfor % 3
        for k=0:n, c = fbincoeff (n,k); endfor % 4
        for k=0:n, c = fbincoeff (n,k); endfor % 5
        telapsed = toc(tstart);
        t_dft(n,m) = telapsed/5;
    endfor
    med_elapsed_time(n,cmethod) = median(t_dft(n,:))/times;
    min_elapsed_time(n,cmethod) = min(t_dft(n,:))/times;
endfor
legends = [legends, 'fbincoeff'];

% fft
disp('fft');
cmethod++;
t_fft = [];
for n=1:top_n,
    for m=1:times,
        tstart = tic();
        for k=0:n, c = fftbincoeff (n,k); endfor % 1
        for k=0:n, c = fftbincoeff (n,k); endfor % 2
        for k=0:n, c = fftbincoeff (n,k); endfor % 3
        for k=0:n, c = fftbincoeff (n,k); endfor % 4
        for k=0:n, c = fftbincoeff (n,k); endfor % 5
        telapsed = toc(tstart);
        t_fft(n,m) = telapsed/5;
    endfor
    med_elapsed_time(n,cmethod) = median(t_dft(n,:))/times;
    min_elapsed_time(n,cmethod) = min(t_dft(n,:))/times;
endfor
legends = [legends, 'fftbincoeff'];

% rolfe good recursion method
disp('rolfe good recursion method');
cmethod++;
t_rolfe = [];
for n=1:top_n,
    for m=1:times,
        tstart = tic();
        for k=0:n, c = rbincoeff (n,k); endfor % 1
        for k=0:n, c = rbincoeff (n,k); endfor % 2
        for k=0:n, c = rbincoeff (n,k); endfor % 3
        for k=0:n, c = rbincoeff (n,k); endfor % 4
        for k=0:n, c = rbincoeff (n,k); endfor % 5
        telapsed = toc(tstart);
        t_rolfe(n,m) = telapsed/5;
    endfor
    med_elapsed_time(n,cmethod) = median(t_rolfe(n,:))/times;
    min_elapsed_time(n,cmethod) = min(t_rolfe(n,:))/times;
endfor
legends = [legends, 'rbincoeff'];

% prime factor cancellations
disp('prime factor cancellations');
cmethod++;
t_prime = [];
for n=1:top_n,
    for m=1:times,
        tstart = tic();
        for k=0:n, c = pfbincoeff (n,k); endfor % 1
        for k=0:n, c = pfbincoeff (n,k); endfor % 2
        for k=0:n, c = pfbincoeff (n,k); endfor % 3
        for k=0:n, c = pfbincoeff (n,k); endfor % 4
        for k=0:n, c = pfbincoeff (n,k); endfor % 5
        telapsed = toc(tstart);
        t_prime(n,m) = telapsed/5;
    endfor
    med_elapsed_time(n,cmethod) = median(t_prime(n,:))/times;
    min_elapsed_time(n,cmethod) = min(t_prime(n,:))/times;
endfor
legends = [legends, 'pfbincoeff'];

% Stirling's approach
disp('Stirlings');
cmethod++;
t_stir = [];
for n=1:top_n,
    for m=1:times,
        tstart = tic();
        for k=0:n, c = stirlingbincoeff (n,k); endfor % 1
        for k=0:n, c = stirlingbincoeff (n,k); endfor % 2
        for k=0:n, c = stirlingbincoeff (n,k); endfor % 3
        for k=0:n, c = stirlingbincoeff (n,k); endfor % 4
        for k=0:n, c = stirlingbincoeff (n,k); endfor % 5
        telapsed = toc(tstart);
        t_stir(n,m) = telapsed/5;
    endfor
    med_elapsed_time(n,cmethod) = median(t_prime(n,:))/times;
    min_elapsed_time(n,cmethod) = min(t_prime(n,:))/times;
endfor
legends = [legends, 'stirlings'];

lbl_norm = 'gbincoeff';
id_norm = find(not(cellfun('isempty',strfind(legends,lbl_norm))));
normalized_med_elapsed_time = (med_elapsed_time./(n+1)');
normalized_med_elapsed_time = normalized_med_elapsed_time./normalized_med_elapsed_time(:,id_norm);

disp('plot');
hf = figure ();
basename = 'benchmark';
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

n = [1:top_n];
p = semilogy(n,med_elapsed_time./(n+1)');
for ip = 1 : length(p),
  set(p(ip),'color',colours{ip},'linestyle',linestyle{ip},'linewidth',2);
  %set(p(ip),'color',colours{ip},'linestyle',linestyle{ip},'marker',markers{ip},'linewidth',2);
endfor
xlabel('n'); ylabel('avg time (ms)');
legend(legends,'location','northwest');
fname = cstrcat(basename,'_',num2str(times),extension);
print (hf, fname, "-dsvg");

%p = semilogx(n,normalized_med_elapsed_time);
p = loglog(n,normalized_med_elapsed_time,'linewidth',2);
for ip = 1 : length(p),
  set(p(ip),'color',colours{ip},'linestyle',linestyle{ip},'linewidth',2);
  %set(p(ip),'color',colours{ip},'linestyle',linestyle{ip},'marker',markers{ip},'linewidth',2);
endfor
xlabel('n'); ylabel(cstrcat('runtime relative to ',lbl_norm));
legend(legends,'location','northwest');
fname = cstrcat(basename,'_normalized_',num2str(times),extension);
print (hf, fname, "-dsvg");

fwname = cstrcat(basename,'_normalized_',num2str(times),'.dat');
save (fwname);
