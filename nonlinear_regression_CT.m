clear all;
clc;

% % %%%%%%%%%%%%%%%%fig6
load Vdlogc_test_CT.mat
load Vdispc_test_CT_8.mat
[data, text] = xlsread('Scores.xlsx');
mos = data(:,1);

X = [Vdispc,Vdlogc];
Y = mos;


% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fi = 1;

    beta0 = [0,0,0];
    BETA = []; R = []; J = []; COVB = []; MSE = [];

    X=X(:,2);
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





