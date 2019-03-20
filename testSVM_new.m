clear all;
clc;

load Vdis_new.mat;
load Vpdis_new.mat;
load Vpsnr_new.mat;
load Vssim_new.mat;
load Vdispc_new.mat;
load Vdlogc_new.mat;
load data.mat
mos = data_new(:,25);
X = [Vdis_new, Vpdis_new, Vpsnr_new, Vssim_new, Vdispc_new, Vdlogc_new];
Y =mos;
label = Y;
features = [X(:,5)];
cnum = length(label);

for fi = 1:1,

 fea = features;

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

            [predicted_label,accu(:,jj), prob_estimates] ...
                = svmpredict(ts_label, ts_fea, model);

            rmse_sub(jj) = sqrt((predicted_label - ts_label)'*(predicted_label - ts_label)/length(ts_label));
            coeff_spearman(jj) = corr(ts_label, predicted_label,'type','Spearman');
            coeff_pearson(jj) = corr(ts_label, predicted_label,'type', 'Pearson');
     
        end;

        spear_coeff(ii) = mean(coeff_spearman);
        pear_coeff(ii) = mean(coeff_pearson);
        mserror(ii) = mean(rmse_sub);

    end;
    RMSE(fi) = mean(mserror(:));
    Pearson(fi) = mean(pear_coeff);
    Spearman(fi) = mean(spear_coeff);
end;


    