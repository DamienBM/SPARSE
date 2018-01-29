function tsignal = haar1d(signal,flag)

% HAAR1D computes the forward (flag 'f' or none) and 
% inverse haar (flag 'i')transform of SIGNAL
% 'f': output is smooth (s) followed by detail (d) splitting:
%      tsignal = [s d] 
% 'i': output from  [s d] is original signal
% The length of SIGNAL needs to be even.

if (nargin == 1)
	flag = 'f';
end

sig_size = size(signal);
sig_length = max(sig_size);
tsignal = zeros(sig_size);

% forward transform
if (flag == 'f')
% subsample into even and odd
odd  = signal(1:2:sig_length);
even = signal(2:2:sig_length);
% compute s and d according to the classical scheme
s = (odd + even)/sqrt(2);
d = (odd - even)/sqrt(2);
% concatenate
tsignal(1:sig_length/2) = s;
tsignal(sig_length/2+1:sig_length) = d;

% inverse transform
elseif (flag == 'i')
% get s and d
s = signal(1:sig_length/2);
d = signal(sig_length/2+1:sig_length);

% recover odd and even according to the classical scheme
odd  = (s + d)/sqrt(2);
even = (s - d)/sqrt(2);

% allocate memory and upsampling
tsignal(1:2:sig_length) = odd;
tsignal(2:2:sig_length) = even;
end