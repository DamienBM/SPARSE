clear all
% Malevitch_Beg = [65 65];Malevitch_End = [358 358];
% data = malevitch(Malevitch_Beg,Malevitch_End);

Crux_Width = 16;
data = crux(Crux_Width);

load lena512;
data = lena512 ;
Length_Zero_Pad = 16;
data(1:Length_Zero_Pad,:) = 0;
data(:,end-Length_Zero_Pad+1:end) = 0;
data(end-Length_Zero_Pad+1:end,:) = 0;
data(:,1:Length_Zero_Pad) = 0;

% %% For 1-level algorithm
Data_Transform = haar2d(data,'f');
Data_Transform_Inv = haar2d(Data_Transform,'i');

%% For Mallat algorithm
% Data_Transform = mallat2d(data,'f');
% Data_Transform_Inv = mallat2d(Data_Transform,'i');

Circ_Shift = [1,1];
data2 = circshift(data,Circ_Shift) ;
%% For 1-level algorithm
% Data_Transform2 = haar2d(data2,'f');

% %% For Mallat algorithm
Data_Transform_Mal = mallat2d(data,'f');
Data_Transform_Mal_Inv = mallat2d(Data_Transform_Mal,'i');
Data_Transform_Mal2 = mallat2d(data2,'f');
Data_Transform__Mal_Inv2 = mallat2d(Data_Transform_Mal2,'i');

%% Display
figure(1)
imagesc(data);colormap('gray')

figure(2)
imagesc(Data_Transform);colormap('gray')

figure(3)
imagesc(Data_Transform_Inv);colormap('gray')

figure(4)
subplot(2,2,1)
imagesc(Data_Transform_Mal);colormap('gray')
subplot(2,2,2)
imagesc(Data_Transform_Mal2);colormap('gray')
subplot(2,2,3)
imagesc(data);colormap('gray')
subplot(2,2,4)
imagesc(data2);colormap('gray')

% figure(5)
% subplot(1,2,1)
% imagesc(Data_Transform(end/2+1:end,end/2+1:end));colormap('gray')
% subplot(1,2,2)
% imagesc(Data_Transform2(end/2+1:end,end/2+1:end));colormap('gray')

