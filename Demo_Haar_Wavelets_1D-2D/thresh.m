function [xthr,nbnull] = thresh(x,T)

% THRESH thresholds the vector x
% with respect to T and returns
% the threshold xthr and the number nbnull
% of zero coefficients.

	x_infT = find(abs(x)<=abs(T));
	xthr = x;
	xthr(x_infT) = zeros(size(x_infT));
	nbnull = prod(size(x_infT));
