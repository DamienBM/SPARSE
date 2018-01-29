function timage = haar2d(image,flag)

% HAAR2D computes the forward (flag 'f' or none) and 
% inverse haar (flag 'i') transform of IMAGE
% 'f': output is timage = [s , d1 ; d2 d3]	
% 'i': output from   [s , d1 ; d2 d3] is original image
% IMAGE needs to be square, with even sides.

if (nargin == 1)
	flag = 'f';
end

[L L] = size(image); % image has to be square
timage = zeros(L,L);
 
% first transforms the rows
for i = 1:L
   timage(i,:) = haar1d(image(i,:),flag);
end
 
% then the columns
for j = 1:L
   timage(:,j) = haar1d(timage(:,j),flag);
end