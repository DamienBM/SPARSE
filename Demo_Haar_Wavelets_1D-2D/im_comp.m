function [size_lin,snr_lin,size_nonlin,snr_nonlin] = im_comp(imag)

	[L,L] = size(imag);
	nbpixels = L*L;
  timag = round(mallat2d(imag,'f'));
	zzorder = zigzag(L);
	
	%maxcoeff = max(max(abs(timag)));
	pccoeffkept = [0.9999,0.99,0.98,0.95,0.9,0.5,0.3,0.2,0.1,0.05];
	for index = 1:length(pccoeffkept)
		nbcoeff = floor(pccoeffkept(index)*nbpixels);
		timag_lin = zeros(L,L);
		timag_lin(zzorder(1:nbcoeff)) = timag(zzorder(1:nbcoeff));
		rimag_lin = round(mallat2d(timag_lin,'i'));
		snr_lin(index) = snr(imag,rimag_lin);
		timag_nonlin = take1st(timag,nbcoeff);
		rimag_nonlin = round(mallat2d(timag_nonlin,'i'));
		snr_nonlin(index) = snr(imag,rimag_nonlin);
	end
	
	figure 
	hold on
	plot(pccoeffkept,snr_lin)
	plot(pccoeffkept,snr_nonlin,'r')
	ylabel('SNR in dB');
	xlabel('Nb. of coefficients kept')
	legend('First coefficients, zz ordered','Biggest coefficients')
