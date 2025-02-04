close all;
clear all;
%% D�but programme

global nb_pixel_dct_block nb_pixel_fft_block P

nb_pixel_fft_block = 0;
nb_pixel_dct_block = 0;
P = 8; % valeur de la puissance de 2 dans les fonctions de blockproc
MIN=0;
MAX=10;

nb_bloc = 16; % exemple : nb_bloc = 2 => 2 blocs par ligne
compteur = 1;
limit = 2^8;

file = 'C:\Program Files\MATLAB\R2017b\toolbox\images\imdata\cameraman.tif';

Im = im2double(imread(file));
% Im = rgb2gray(Im);

% figure;
% imshow(Im);

taille = size(Im,1)*size(Im,2);

% avg_erreur_fft = zeros(MAX-MIN,1);
% avg_erreur_dct = zeros(MAX-MIN,1);
% 
% taux_compr_fft = zeros(MAX-MIN,1);
% taux_compr_dct = zeros(MAX-MIN,1);

% avg_erreur_fft_block = zeros(MAX-MIN,1);
% avg_erreur_dct_block = zeros(MAX-MIN,1);
% 
% taux_compr_fft_block = zeros(MAX-MIN,1);
% taux_compr_dct_block = zeros(MAX-MIN,1);

% Im_fft = fft2(Im);

% figure;
% imshow(log(abs(Im_fft)));

% Im_fft = fftshift(Im_fft);
% 
% Im_DCT = dct2(Im);

%% Boucle for pour DCT et TF globale (sur toute l'image) : m�thode classique
% tic;
% for k = MIN:MAX
%     P=k;
%     nb_pixel_fft_block = 0;
%     nb_pixel_dct_block = 0;
%     
%     A_dct_max = max(max(abs(Im_DCT)));
%     A_fft_max = max(max(abs(Im_fft)));
%     
%     seuil_fft = A_fft_max/(2^k);
%     seuil_dct = A_dct_max/(2^k);
% 
%     Im_fft_th = zeros(size(Im_fft,1),size(Im_fft,2));
%     Im_dct_th = zeros(size(Im_DCT,1),size(Im_DCT,2));
%     
%     nb_pixel_fft = 0;
%     nb_pixel_dct = 0;
% 
%     for i=1:size(Im_fft,1)
%         for j=1:size(Im_fft,2)
%             if(abs(Im_fft(i,j))>=seuil_fft)
%                 Im_fft_th(i,j) = Im_fft(i,j);
%                 nb_pixel_fft = nb_pixel_fft +1;
%             end
%         end
%     end
% 
%     for i=1:size(Im_DCT,1)
%         for j=1:size(Im_DCT,2)
%             if(abs(Im_DCT(i,j))>=seuil_dct)
%                 Im_dct_th(i,j) = Im_DCT(i,j);
%                 nb_pixel_dct = nb_pixel_dct +1;
%             end
%         end
%     end
%     
%     Im_ifft = ifftshift(Im_fft_th);
%     Im_ifft = ifft2(Im_ifft);
%     Im_iDCT = idct2(Im_dct_th);
% 
% %     figure;
% %     imshow(Im_ifft);
% % 
% %     figure;
% %     imshow(Im_iDCT);
% 
%     % Calcul d'erreur : erreur quadratique moyenne (non perceptuels)
% 
%     erreur_fft = (Im - Im_ifft).^2;
%     erreur_dct_block = (Im - Im_iDCT).^2;
% 
%     avg_erreur_fft(compteur,1) = mean(mean(erreur_fft));
%     avg_erreur_dct(compteur,1) = mean(mean(erreur_dct_block));
% 
%     taux_compr_dct(compteur,1) = taille/nb_pixel_dct;
%     taux_compr_fft(compteur,1) = taille/nb_pixel_fft;
%     
%     % Calcul block
%     
%     taille_block = size(Im,1)/nb_bloc;
% 
%     block = [taille_block taille_block];
%     
%     fun_anonym_fft = @(block_struct) fun_fft(block_struct);
%     Im_res_fft = blockproc(Im,block,fun_anonym_fft);%,'UseParallel',true);   
% 
%     fun_anonym_dct = @(block_struct) fun_dct(block_struct);
%     Im_res_dct = blockproc(Im,block,fun_anonym_dct);%,'UseParallel',true);
% 
%     erreur_fft_block = (Im - Im_res_fft).^2;
%     erreur_dct_block = (Im - Im_res_dct).^2;
% 
%     avg_erreur_fft_block(compteur,1) = mean(mean(erreur_fft_block));
%     avg_erreur_dct_block(compteur,1) = mean(mean(erreur_dct_block));
% 
% %     taux_compr_dct_block(compteur,1) = 1/(taille/(sum(nb_pixel_dct_block)))*100;
% %     taux_compr_fft_block(compteur,1) = 1/(taille/(sum(nb_pixel_fft_block)))*100;
%     
%     taux_compr_dct_block(compteur,1) = taille/nb_pixel_dct_block;
%     taux_compr_fft_block(compteur,1) = taille/nb_pixel_fft_block;
%     
%     compteur = compteur + 1;        
% end
% temps=toc;
%% Boucle pour DCT et TF locale (par bloc sur l'image) : m�thode �labor�e

while( nb_bloc < limit)
    
    taille_block = size(Im,1)/nb_bloc;
    block = [taille_block taille_block];
    
    fun_anonym_fft = @(block_struct) fun_fft(block_struct);
    Im_res_fft = blockproc(Im,block,fun_anonym_fft);%,'UseParallel',true);   

    fun_anonym_dct = @(block_struct) fun_dct(block_struct);
    Im_res_dct = blockproc(Im,block,fun_anonym_dct);%,'UseParallel',true);

    erreur_fft_block = (Im - Im_res_fft).^2;
    erreur_dct_block = (Im - Im_res_dct).^2;

    avg_erreur_fft_block(compteur,1) = mean(mean(erreur_fft_block));
    avg_erreur_dct_block(compteur,1) = mean(mean(erreur_dct_block));

%     taux_compr_dct_block(compteur,1) = 1/(taille/(sum(nb_pixel_dct_block)))*100;
%     taux_compr_fft_block(compteur,1) = 1/(taille/(sum(nb_pixel_fft_block)))*100;
    
    taux_compr_dct_block(compteur,1) = taille/nb_pixel_dct_block;
    taux_compr_fft_block(compteur,1) = taille/nb_pixel_fft_block;
    
    compteur = compteur + 1;
    nb_bloc = nb_bloc*2;
    
    nb_pixel_dct_block = 0;
    nb_pixel_fft_block = 0;

%     figure;
%     imshow(Im_res_fft);
% 
%     figure;
%     imshow(Im_res_dct);
end

%% Affichage de l'erreur
% figure;
% plot(1:10,avg_erreur_fft);
% ylabel('Valeur de l''erreur quadratique moyenne FFT');
% xlabel('Valeurs de k (1 � 10)');
% figure;
% plot(1:10,avg_erreur_dct);
% ylabel('Valeur de l''erreur quadratique moyenne DCT');
% xlabel('Valeurs de k (1 � 10)');

%% Affichage taux de compression

% figure;
% plot(1:10,taux_compr_fft);
% ylabel('Valeur du taux de compression FFT');
% xlabel('Valeurs de k (1 � 10)');
% figure;
% plot(1:10,taux_compr_dct);
% ylabel('Valeur du taux de compression DCT');
% xlabel('Valeurs de k (1 � 10)');

%% Courbe erreur vs taux de compression
% figure;
% plot(taux_compr_fft,avg_erreur_fft);
% xlabel('taux de compression : taille totale/nb pixel utile');
% ylabel('erreur moyenne quadratique');
% hold on;
% % figure;
% plot(taux_compr_dct,avg_erreur_dct);
% legend('FFT','DCT');

%% Affichage de l'erreur : block version
% figure;
% plot(1:7,avg_erreur_fft_block);
% ylabel('Valeur de l''erreur quadratique moyenne FFT par blocs');
% xlabel('Valeurs de nb_bloc allant de 1 � 64');
% figure;
% plot(1:7,avg_erreur_dct_block);
% ylabel('Valeur de l''erreur quadratique moyenne DCT par blocs');
% xlabel('Valeurs nb_bloc allant de 1 � 64');

%% Affichage taux de compression : block version

% figure;
% plot(1:7,taux_compr_fft_block);
% ylabel('Valeur du taux de compression FFT par blocs');
% xlabel('Valeurs de nb_bloc allant de 1 � 64');
% figure;
% plot(1:7,taux_compr_dct_block);
% ylabel('Valeur du taux de compression DCT par blocs');
% xlabel('Valeurs de nb_bloc allant de 1 � 64');

%% Courbe erreur vs taux de compression : block version
figure;
plot(taux_compr_fft_block,avg_erreur_fft_block);
xlabel('taux de compression');
ylabel('erreur moyenne quadratique');
hold on;
plot(taux_compr_dct_block,avg_erreur_dct_block);
legend('FFT','DCT');

%% Courbe erreur vs taux de compression : block version VS Na�ve
% figure;
% plot(taux_compr_fft_block,(avg_erreur_fft_block));
% xlabel('taux de compression');
% ylabel('erreur moyenne quadratique');
% hold on;
% plot(taux_compr_dct_block,(avg_erreur_dct_block));
% hold on;
% plot(taux_compr_fft(1:11,1),avg_erreur_fft(1:11,1));
% hold on;
% plot(taux_compr_dct(1:11,1),avg_erreur_dct(1:11,1));
% legend('FFT BLOCK','DCT BLOCK','FFT','DCT');

%% Function handle for blockproc
function M = fun_fft(block_struct) 
global nb_pixel_fft_block 
global P
Im_fft = fft2(block_struct.data);
seuil = max(max(abs(Im_fft)))/(2^P);
Im_fft_seuil_bw = (abs(Im_fft)>=seuil);
nb_pixel_fft_block = nb_pixel_fft_block + sum(sum(Im_fft_seuil_bw));
Im_fft_seuil = Im_fft_seuil_bw.*Im_fft;
M = ifft2(Im_fft_seuil);
end

function M = fun_dct(block_struct) 
global nb_pixel_dct_block 
global P
Im_dct = dct2(block_struct.data);
seuil = max(max(abs(Im_dct)))/(2^P);
Im_dct_seuil_bw = (abs(Im_dct)>=seuil);
nb_pixel_dct_block =  nb_pixel_dct_block + sum(sum(Im_dct_seuil_bw));
Im_dct_seuil = Im_dct_seuil_bw.*Im_dct;
M = idct2(Im_dct_seuil);
end