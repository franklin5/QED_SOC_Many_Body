%% This is the program to compute phi(y) function max
clear
clc
close all
% units are taken to be \hbar=m=k_B=1
kr = 0.22;
delta = 0;
OmegaTilde=3;
omega_c = 1;
T = 0.5; 
beta = 1/T;

maxKZ = 10;
S = @(y) quadgk(@(kz) exp(-beta*kz.^2/2)*2.*...
    cosh(beta*sqrt((kr*kz+delta).^2+(OmegaTilde/2)^2*y)),-maxKZ,maxKZ);
ay = 0:0.01:1;
phi = @(y) -beta*omega_c*y+log(S(y));
for y = ay
    scatter(y,phi(y))
    hold on
end
hold off
xlabel('y')
ylabel('\phi(y)')