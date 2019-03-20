% % Extract features for our new metrics

clear all;
clc;

disp_file = 'CT_disparitymap';
data_file = 'Crosstalk_dataset';

%disp_file = 'Test_Disparitymap';
%data_file = 'Testing';

dfile = dir([disp_file,'/','*l_dsp.bmp']);
%dfile = dir([disp_file,'/','*l.jpg']);
Vdis_lr = []; Vpdis_lr = []; Vssim_lr = [];Vd = [];


Vsc = []; Vdc = [];Vpdc = []; 
Vdetac = [];Vdispc = [];Vdlogc = [];

max_disp = 150;
for fi = 1:length(dfile),
    if mod(fi-1,4)==0,
        cl = 0.001;
        disp = [];
        disp = double(imread([disp_file, '/', dfile(fi).name]));
         cimg1 = double(imread( [data_file,'/',dfile(fi).name(1:end-8),'.bmp']));
         cimg2 = double(imread( [data_file,'/',dfile(fi).name(1:end-9),'r.bmp']));
        %cimg1 = double(imread( [data_file,'/',dfile(fi).name]));
        %cimg2 = double(imread( [data_file,'/',dfile(fi).name(1:end-5),'r.jpg']));


        deta_map = max(abs(cimg2-cimg1),[],3);

        ddeta = mean2(deta_map);
        
        dlog = 1./log(sum(cimg1,3)+30);
        dlog_map = deta_map.*dlog;
        ddlog = mean2(dlog_map);

    else 
        cl = cl+0.05;

    end;
    disp2 = disp;
    disp2(cl*deta_map<8) = 0;

    disp_map = (deta_map/255).*disp2;

    ddisp = mean2(disp_map);
    
    %disp1 = disp;
    %disp1(ssim>0.97) = 0;

    Vdispc = [Vdispc;ddisp*sqrt(cl)];
    Vdlogc = [Vdlogc; ddlog*sqrt(cl)];
end;
%save Vdispc_newdb_T9.mat Vdispc;
%save Vdlogc_newdb_T5.mat Vdlogc;
save Vdispc_test_CT.mat Vdispc;
save Vdlogc_test_CT.mat Vdlogc;
