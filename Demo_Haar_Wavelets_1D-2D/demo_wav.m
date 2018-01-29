load signals
x = sig_reg;% Piece-wise regular
% x = sig_pol;% Piece-wise polynomial
% x = sig_cos;% Cosine

x = 1*x + 2*randn(size(x));

figure ; clf
y=mallat1d(x);
[yt,ynul]=thresh(y,3);
z=mallat1d(yt,'i');
plot(x);hold on;plot(z,'r');
    return

figure(1);
plot(x);axis tight
disp('Base signal')
% pause

%% One-level Haar decomposition
y = haar1d(x);
s = y(1:end/2);
d = y(end/2+1:end);
figure(1);
subplot(1,2,1)
plot(x);axis tight
xlabel('Signal');
subplot(2,2,2)
plot(s);axis tight
xlabel('Approximation');
subplot(2,2,4)
plot(d);axis tight
xlabel('Detail');
disp('One level Haar decomposition')
% pause

%% Several level wavelet decomposition
y = mallat1d(x,'f');
y2 = mallat1d(circshift(x,[0 -1]),'f');
x_est = mallat1d(y,'i');
x_est2 = mallat1d(y2,'i');
figure(1)
subplot(3,1,1)
plot(x);axis tight
subplot(3,1,2)
plot([y',y2']);axis tight
subplot(3,1,3)
plot(x-x_est);axis tight
pause

%% What is that?
y = mallat1d(x,'f');
x_est = mallat1d(x,'i');
figure(1)
subplot(3,1,1)
plot(x);axis tight
subplot(3,1,2)
plot(y);axis tight
subplot(3,1,3)
plot(x_est);axis tight
pause

%% Thresholding
threshold = 0;
figure(1);clf
y=mallat1d(x);
[yt,ynul]=thresh(y,threshold);
z=mallat1d(yt,'i');
subplot(2,1,1)
plot(x);hold on;plot(z,'r');;axis tight
subplot(2,1,2)
plot(x-z);;axis tight
pause
% 
im = malevitch([120 120],[403 403]);
%  load lena512
%  im = lena512;
im_wav = mallat2d(im);
im_wav(1:64,1:64) = 0;
subplot(1,2,1)
imagesc(im);colormap gray
subplot(1,2,2)
imagesc(im_wav);colormap gray

im_thres(im,1);

% im = malevitch([100,100],[400,400]);
im = crux(10);
im_comp(im)
