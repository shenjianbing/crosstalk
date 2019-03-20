clear all;
clc;

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load Vdis_new.mat;
load Vpdis_new.mat;
load Vpsnr_new.mat;
load Vssim_new.mat;
load Vdispc_new.mat;
load Vdlogc_new.mat;
load data.mat

mos = data_new(:,25);

X = [Vdis_new, Vpdis_new, Vpsnr_new, Vssim_new, Vdispc_new, Vdlogc_new];
Y = mos;

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fi = 1;

    beta0 = [0,0,0];
    BETA = []; R = []; J = []; COVB = []; MSE = [];
    X=X(:,5)*0.1+X(:,6)*0.9;
    [BETA, R, J, COVB ,MSE] = nlinfit(X, Y, @mymodel, beta0) ;
    beta0 = BETA;        
    beta = beta0;
    fea = X;
    x=X;

    yhat = (beta(1)./(1+exp(-beta(2)*(x-beta(3)))));

    
    figure('color',[1,1,1]), plot(Y, yhat,'*');
    xlabel('MOS');
    ylabel('MOSp(Vdispc)');
    
     result=[Y,yhat];
    
    RMSE(fi) = sqrt((yhat-Y)'*(yhat-Y)/length(yhat));
    Spearman(fi) = corr(yhat, Y,'type','Spearman');
    Pearson(fi) = corr(yhat, Y,'type', 'Pearson');
    M = ['Pcor = ', num2str(Pearson(fi),'%1.3f');
         'Scor = ', num2str(Spearman(fi),'%1.3f');
         'RMSE = ', num2str(RMSE(fi),'%1.3f')];
    legend(M,'Location', 'SouthEast');







