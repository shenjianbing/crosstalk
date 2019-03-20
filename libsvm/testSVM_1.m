% % clear all;
% % clc;
% [NUM TITLE CONTENT] = xlsread('Scores.xlsx');
% MOS = NUM(:,1);
% % load lum_ratio_l.mat;
% load Vssim_threshold.mat;
% load Vdis_threshold.mat;
% load Vpdis_threshold.mat;
% load Vpsnr72.mat;
% load Vd.mat;
% % load feature1.mat;
% load lum_diff_all.mat;

% cnum = length(MOS);
% label = MOS;

% for i = 1:cnum,
%     lum_diff(i) = feature(i).lum_diff;
% %     lum_diff1(i) = feature(i).lum_diff1;
%     mdisp(i) = feature(i).maxdisp;
% end;
% load pp.mat;
% features = [Vssim, Vpsnr, Vdis, Vpdis,Vd];
% features = [Vdc, Vdcc, Vpdc, Vpdcc];

% load Vdis_threshold.mat;
% load Vpdis_threshold.mat;
% load Vpsnr.mat;
% load Vssim.mat;
% 
% load Vdispc_test.mat;
% load Vdlogc_test.mat;
[data, text] = xlsread('score.xls');
mos = data(:,25);
X = [Vdis, Vpdis, Vpsnr, Vssim, Vdispc, Vdlogc];
Y_ = [mos(5:32);mos(37:56);mos(61:76);mos(81:84);mos(89:92);];
X_ = [X(5:32,:);X(37:56,:);X(61:76,:);X(81:84,:);X(89:92,:)];
label = Y_;
features = [X_(:,4), X_(:,5)];
cnum = length(label);

parfor fi = 1:1,
%     fea = [];
%     if fi <= 5,
 %   fea = [features(:,fi)];
 fea = features;
%     else
% 
%             fea = [features(:,fi-5),p];
% 
%     end;
    mserror = [];
    spear_coeff = [];
    pear_coeff = [];
    for ii = 1:100,
        rand_idx = [];
        rand_idx = randperm(cnum);
        ts_num = floor(0.1*cnum);
        accu = [];coeff_spearman = [];coeff_pearson = []; rmse_sub = [];
        X = []; Y = [];
        for jj = 1:10,
            tr_fea = []; tr_label = []; ts_fea = []; ts_label = []; tr_idx = []; ts_idx = [];
            
            if jj == 10,
                ts_idx = rand_idx((jj-1)*ts_num+1:end);
                tr_idx = rand_idx(1:(jj-1)*ts_num);
            else
                ts_idx = rand_idx((jj-1)*ts_num+1:jj*ts_num);
                tr_idx = [rand_idx(1:(jj-1)*ts_num),rand_idx(jj*ts_num+1:end)];
            end;
            tr_fea = fea(tr_idx,:);
            tr_label = label(tr_idx);
            ts_fea = fea(ts_idx,:);
            ts_label = label(ts_idx);
        
            model = svmtrain( tr_label, tr_fea, '-s 3 -t 2');
%             [predicted_label, accu(:,jj), prob_estimates] ...
%                 = svmpredict(ts_label, ts_fea, model);
            [predicted_label,accu(:,jj), prob_estimates] ...
                = svmpredict(ts_label, ts_fea, model);
%             X = [X; ts_label];
%             Y = [Y; predicted_label];
            rmse_sub(jj) = sqrt((predicted_label - ts_label)'*(predicted_label - ts_label)/length(ts_label));
            coeff_spearman(jj) = corr(ts_label, predicted_label,'type','Spearman');
            coeff_pearson(jj) = corr(ts_label, predicted_label,'type', 'Pearson');
     
        end;
%         mserror(ii) = sqrt(mean(accu(2)));          
        spear_coeff(ii) = mean(coeff_spearman);
        pear_coeff(ii) = mean(coeff_pearson);
        mserror(ii) = mean(rmse_sub);
%         mserror(ii) = sqrt((X-Y)'*(X-Y)/length(X));
%         spear_coeff(ii) = corr(X,Y,'type','Spearman');
%         pear_coeff(ii) = corr(X,Y,'type','Pearson');
    end;
    RMSE(fi) = mean(mserror(:));
    Pearson(fi) = mean(pear_coeff);
    Spearman(fi) = mean(spear_coeff);
end;


    