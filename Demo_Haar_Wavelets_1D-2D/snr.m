function snr = snr(signal,signal_err)
	
% SNR(signal,signal_err) computes the
% signal-noise ratio in dB
	
	snr = 10*log10(sum(sum(signal.^2))/sum(sum((signal-signal_err).^2)));
