%Extract features from our new dataset
clear all;
clc;
addpath 'SSIM_code';
disp_file = 'Test_Disparitymap';
data_file = 'Testing';

dfile = dir([disp_file,'/','*l.jpg']);
Vdis = []; Vpdis = []; Vssim = [];Vd = []; Vpsnr = [];

for fi = 1:length(dfile),    

        disp = [];
        disp = double(imread([disp_file, '/', dfile(fi).name]));
        ssim = ones(size(disp));
         if mod(fi-1,4)==0,
            img1 = double(imread( [data_file,'/',dfile(fi).name]));
            img3 = double(imread( [data_file,'/',dfile(fi).name(1:end-5),'r.jpg']));

            Ycbcrl = rgb2ycbcr(img1);
            Ycbcr3 = rgb2ycbcr(img3);

            Y1 = double(Ycbcrl(:,:,1));
            Y3 = double(Ycbcr3(:,:,1));
            L0 = (Y1 - 0.03*Y3)/(1-0.03^2);
            [mssim, ssim_map] = ssim_index(Y1, L0);
            
            Vpsnr = [Vpsnr; psnr(Y1, L0)];

 

        else 
            img2 = imread( [data_file,'/',dfile(fi).name(1:end-5),'r.jpg']);

            Ycbcr2 = rgb2ycbcr(img2);

            Y2 = double(Ycbcr2(:,:,1));
            [mssim, ssim_map] = ssim_index(L0, Y2);          

            Vpsnr = [Vpsnr; psnr(Y2, L0)];
         end;
         sx = (size(disp,1) - size(ssim_map,1))/2; 
         sy = (size(disp,2) - size(ssim_map,2))/2; 
         ssim((1+sx) : (end - sx),(1+sy) : (end - sy)) = ssim_map;

            Vssim = [Vssim; mean2(ssim_map)];


        val_dis = mean2(ssim.*(1-disp/255));

        disp(find(ssim>=0.977)) = 0; 

        val_pdis = mean2(ssim.*(1-disp/255));

        Vdis = [Vdis; val_dis];
        Vpdis = [Vpdis; val_pdis];

       
end;

save Vdis_newdb.mat Vdis;
save Vpdis_new.mat Vpdis;
save Vpsnr_new.mat Vpsnr;
save Vssim_new.mat Vssim;
      