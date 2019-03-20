function yhat = mymodel(beta, x)
yhat = (beta(1)./(1+exp(-beta(2)*(x-beta(3)))));
