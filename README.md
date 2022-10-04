# Wavelet-based Approach for Diagnosing Attention Deficit Hyperactivity Disorder (ADHD)
In this project, a noval method is proposed based the self-similar property of pupillary dynamics for early detection of ADHD. Self-similarity  is characterized in the wavelet domain by computing wavelet spectra. A distance variance based approach is proposed to compute wavelet spectra as it is more robust to noise and outliers. A set of localized discriminatory features are constructed and selected via a rolling window method to build classifiers. ADHD detection performance is evaluated by using three classifiers, Logistic Regression, Support Vector Machine, and k-nearrest neighbor. To compare performance of the proposed method, a feature engineering technique that uses features constructed in the original pupil diameter data domain is considered. More details about the feature engineering method can be found in ** Das et al., A Robust MAchine Learning based Framework for the Automated Detection of ADHD Using the Pupillometric Biomarkers and Time Series Analysis, Scientific Reports, 2021** (https://www.nature.com/articles/s41598-021-95673-5). Below a brief overview of the pupil data analysis procedure is presented. 


### Dataset
The dataset used in this project is available at, https://www.nature.com/articles/s41597-019-0037-2. More information about the dataset is given in the study, **Rojas-Líbano et al, A pupil size, eye-tracking and neuropsychological dataset from ADHD children during a cognitive task, Scientific Data, 2019**. 

**Pupil_dataset.mat** file contains the dataset; the dataset consists of  pupil diameter data collected from 50 children (28 cases and 22 control) during a  visuospatial working memory task. The dataset contains three pupil diameter data groups, namely ADHD-diagnosed children with and without medication and normal children. This project considered pupil diameter of the AHDHD-diagnosed children without medication and normal children. 


### Matlab Codes 
 **MatlabFunctions** folder contains matlab functions used in the project. You can run the project as follows.

1. Run **ReadAndSaveData.m** to compute feature matrixes for self-similarity and feature engineering methods

2. **Demo_1.m** computes the ROC curve and distribution of Hurst exponent

4. **Demo_2.m** presents classification of the proposed self-similarity and feature engineering approaches
