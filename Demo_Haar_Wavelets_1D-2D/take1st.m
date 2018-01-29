function signal1st = take1st(signal,nb1st)
	
% TAKE1ST(signal,nb1st) return SIGNAL zeroed out
% except for the nb1st largest samples.
	
	sig_size = size(signal);
	signal_l = reshape(signal,prod(sig_size),1);
	[signal_sort,index] = sort(abs(signal_l));
	index = flipud(index);
	signal_sort = flipud(signal_sort);
	signal1st = zeros(size(signal_l));
	signal1st(index(1:nb1st))=signal(index(1:nb1st));
	signal1st = reshape(signal1st,sig_size);
