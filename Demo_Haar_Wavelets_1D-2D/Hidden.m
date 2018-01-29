% HIDDEN
data = malevitch([121 121],[260 260]);imagesc(mal);
data = filter2(ones(5),data);
data_Trans = mallat2d(circshift(data,[1 1]),'f');imagesc(a)
n_Bin = 100;
figure(1)
subplot(1,2,1)
imagesc(data)
subplot(1,2,2)
imagesc(data_Trans)
figure(2)
subplot(1,2,1)
plot(hist(data(:),n_Bin))
subplot(1,2,2)
plot(hist(data_Trans(:),n_Bin))
