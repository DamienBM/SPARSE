function wimage = mallat2d(image,flag)

% MALLAT2D(image,flag)
% computes the forward (flag 'f') or inverse (flag 'i')
% wavelet transform of image by applying
% the HAAR2D function recursively
% Image must be square, with power of 2 sides
% Decomposition is limited to 3 levels

	[L,C] = size(image);
	J = round(log(L)/log(2));
%   J = 5;
	if (( 2^J ~= L ) | (L ~=C))
		error('Image size is not a power of two, or is not a square');
	end
	if (nargin == 1) flag = 'f'; end

	% perform the multiresolution transform
	% limited to 4 levels by J-2
	if (flag == 'f')
		Jtab=J:-1:J-2;
	elseif (flag == 'i')
		Jtab=J-2:1:J;
	end
	wimage = image;
	for j=Jtab
		wimage(1:2^j,1:2^j) = haar2d(wimage(1:2^j,1:2^j),flag);
	end

