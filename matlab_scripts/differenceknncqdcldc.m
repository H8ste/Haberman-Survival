clc
clear
clear classes 
close all;

load nutsbolts;
w1 = ldc(z);
w2 = qdc(z);
w3 = knnc(z);
figure()
subplot(3,1,1);scatterd(z);hold on;plotc(w1);
subplot(3,1,2);scatterd(z);hold on;plotc(w2);
subplot(3,1,3);scatterd(z);hold on;plotc(w3);
testc(z*w1)
testc(z*w2)
testc(z*w3)