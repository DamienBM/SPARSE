function index = zigzag(size)
	
% ZIGZAG(size) returns the zigzag order index
% for a size x size square matrix
	
	index = 1:size*size;
	[j,i] =  meshgrid(1:size);
	i = i(:);
	j = j(:);
	iplusj = i + j;
	even_ind = (rem(iplusj,2) == 0);
	odd_ind = ~even_ind;
	j(even_ind) = 	j(even_ind);
	j(odd_ind) = 	i(odd_ind);
	[nouse,tags] = sortrows([iplusj,j]);
	index = index(tags);