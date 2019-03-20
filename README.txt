Implementation code for our CSVT 2018:
===========================================================================
J. Shen, Y. Zhang, Z. Liang,C. Liu, H. Sun, X. Hao, J. Liu, J. Yang and L. Shao, 
Robuststereoscopic crosstalk prediction,  
IEEE Trans. on Circuits and Systems for Video Technology, vol. 28, no. 5, pp. 1158-1168, 2018
========================================================================
If you use this software for research  purposes, please cite our papers.

INTRODUCTION
------------------------------------------------------------
This code implements our metrics.

*Please first download the data file from:  
* Unfold the Test_Disparitymap.zip into the folder:   crosstalk\Test_Disparitymap\*.jpg, *.bmp ;
* Unfold the Testing.zip into the folder:   crosstalk\Testing\*.jpg ;

Testing:                         our new dataset.

Test_Disparitymap:         disparity map of our new dataset

data.mat:                        the mean opinion scores of our new dataset

script Extract_new.m:            extract feature from our new dataset

script Extract_metrics:          extract image feature for our new  metrics                      

script nonlinear_regression_CT:   Evaluation our metrics on crosstalk stereoscopic dataset

script nonlinear_regression_new:  Evaluation our metrics our new dataset

script test SVM_new:    We use SVR to predict the crosstalk perception for our new dataset.

If you use this software for research  purposes, please cite our papers [1,2] in your resulting publication.
===========================================================================
1) J. Shen, Y. Zhang, Z. Liang,C. Liu, H. Sun, X. Hao, J. Liu, J. Yang and L. Shao, 
Robuststereoscopic crosstalk prediction,  
IEEE Trans. on Circuits and Systems for Video Technology, vol. 28, no. 5, pp. 1158-1168, 2018
2) J. Peng, J. Shen, and X. Li, High-order energies for stereo segmentation,  
IEEE Trans. on Cybernetics,  vol. 46, no. 7, pp. 1616-1627, 2016 

===========================================================================
Contact Information
===========================================================================
Email:
    shenjianbing@bit.edu.cn  
    shenjianbingcg@gmail.com

This code uses some public source codes from internet.
We thank all the authors for the release of their codes.