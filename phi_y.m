%% This is the program to compute phi(y) function max
% Rb, 2*pi/(773*10^-9)*sqrt(1.05*10^-34/85/1.67/10^-27/10^6) ~ 0.22
% K, 2*pi/(773*10^-9)*sqrt(1.05*10^-34/39/1.67/10^-27/10^6) ~ 0.33
% Na, 2*pi/(773*10^-9)*sqrt(1.05*10^-34/23/1.67/10^-27/10^6) ~ 0.42
% Li, 2*pi/(773*10^-9)*sqrt(1.05*10^-34/7/1.67/10^-27/10^6) ~ 0.77
clear
clc
close all
% units are taken to be \hbar=m=k_B=1
kr = 0.22;
delta = 0;
OmegaTilde=3;
omega_c = -1; % --> equivalent to delta_R
T = 0.5; 
beta = 1/T;

maxKZ = 10;
S = @(y) quadgk(@(kz) exp(-beta*kz.^2/2)*2.*...
    cosh(beta*sqrt((kr*kz+delta).^2+(OmegaTilde/2)^2*y)),-maxKZ,maxKZ);
ay = 0:0.1:50;
phi = @(y) -beta*omega_c*y+log(S(y));
for y = ay
    scatter(y,phi(y))
    hold on
    drawnow
end
hold off
xlabel('y')
ylabel('\phi(y)')