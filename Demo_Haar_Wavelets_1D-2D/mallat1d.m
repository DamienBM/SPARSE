function wsignal = mallat1d(signal,flag)

% MALLAT1D(signal)
% computes the forward (flag 'f') or inverse (flag 'i')
% wavelet transform of signal by applying
% the HAAR1D function recursively.
% Length of signal must be a power of 2.

	L = length(signal); 
	J = round(log(L)/log(2));
	if ( 2^J ~= L ) 
		error('Signal length is not a power of two');
	end
	if (nargin == 1) flag = 'f'; end

	% perform the multiresolution transform
	% limits to 3 levels by J-2
	if (flag == 'f')
		tab=J:-1:J-2;
	elseif (flag == 'i')
		tab=J-2:1:J;
	end
	wsignal = signal;
	for j=tab
		wsignal(1:2^j) = haar1d(wsignal(1:2^j),flag);
	end


