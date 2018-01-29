function [timage,snr_im,nbnull] = im_thres(image,T)
	
% IM_THRES(image,T) displays the transformed and difference image
% with respect to threshold T, and computes the snr vs.
% the % of non-zero remaining coefficients

	% rounding = 0: floating point coefficients
	% rounding = 1: integer coefficients
	% Look at the effects of both with T=0. Comments?
	rounding = 0;
	%rounding = 1;
  [thimage,nbnull] = thresh(mallat2d(image,'f'),T);
	
	% round thimage
	if (rounding == 1)
  thimage = round(thimage);
	end
	
	timage = mallat2d(thimage,'i');
	
	% round timage
	if (rounding == 1)
	timage = round(timage);
	end
snr_im = snr(image,timage);
	fprintf('%4.3f%% of non zero coefficients, SNR = %4.2f dB \n',...
					1-nbnull/prod(size(image)),snr_im);
	figure 
	colormap gray
	subplot(1,2,1)
	imagesc(timage)
	xlabel('Compressed image')
	subplot(1,2,2)
	imagesc(timage-image)
	xlabel('Difference image')
	colorbar
	
