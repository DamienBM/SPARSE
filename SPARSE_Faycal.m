close all;
%% Début programme
Im_elephant = im2double(imread('C:\Users\Damien\Documents\MATLAB\examen-TI\database\elephant_2.jpg'));
Im_golfcart = im2double(imread('C:\Users\Damien\Documents\MATLAB\examen-TI\database\golfcart.jpg'));

figure;
imshow(Im_elephant);
figure;
imshow(Im_golfcart);

Im_fft_elephant = fft2(Im_elephant);
Im_fft_golfcart = fft2(Im_golfcart);

phase_elephant = angle(Im_fft_elephant);
magnitude_elephant = abs(Im_fft_elephant);

phase_golfcart = angle(Im_fft_golfcart);
magnitude_golfcart = abs(Im_fft_golfcart);

Im_fft_test =(magnitude_elephant).*exp(0.6*1i*phase_elephant);

Im_result_test = ifft2(Im_fft_test);

figure;
imshow(abs(Im_result_test));



% Im_test = ones(512,512);
% 
% figure;
% imshow(Im_test);
% 
% Im_test_fft = fft2(Im_test);
% phase_test = angle(Im_test_fft);
% magnitude_test = abs(Im_test_fft);
% 
% Im_fft_ph_noire_mag_golfcart = magnitude_golfcart.*exp(1i*phase_test);
% Im_fft_ph_golfcart_mag_noire = magnitude_test .* exp(1i*phase_golfcart);
% 
% Im_result_ph_noire_mag_golfcart = ifft2(abs(Im_fft_ph_noire_mag_golfcart));
% Im_result_ph_golfcart_mag_noire = ifft2(abs(Im_fft_ph_golfcart_mag_noire));
% 
% figure;
% imshow(abs(Im_result_ph_noire_mag_golfcart));
% figure;
% imshow(abs(Im_result_ph_golfcart_mag_noire));
