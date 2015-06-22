%% This is the program to compute phi(y) function max
% Rb, 2*pi/(773*10^-9)*sqrt(1.05*10^-34/85/1.67/10^-27/10^6) ~ 0.22
% K, 2*pi/(773*10^-9)*sqrt(1.05*10^-34/39/1.67/10^-27/10^6) ~ 0.33
% Na, 2*pi/(773*10^-9)*sqrt(1.05*10^-34/23/1.67/10^-27/10^6) ~ 0.42
% Li, 2*pi/(773*10^-9)*sqrt(1.05*10^-34/7/1.67/10^-27/10^6) ~ 0.77
clear
clc
% units are taken to be \hbar=m=k_B=1
kr = 0.22;
delta = 0;
OmegaTilde=3;
omega_c = 1; % --> equivalent to delta_R
T = 0.5; 
beta = 1/T;
maxKZ = 10;
eta = @(kz,y) sqrt((kr*kz+delta).^2+(OmegaTilde/2)^2*y);
S = @(y) quadgk(@(kz) exp(-beta*kz.^2/2)*2.*cosh(beta*eta(kz,y)),-maxKZ,maxKZ);
Q = @(y) beta*quadgk(@(kz) exp(-beta*kz.^2/2).*sinh(beta*eta(kz,y))*(OmegaTilde/2)^2./eta(kz,y),-maxKZ,maxKZ);
FirstOrder = @(y) -beta*omega_c+Q(y)./S(y);
[y0,fval]=fsolve(FirstOrder, 0.0, optimset('Display','off'));
ay = 0:0.01:2;
phi = @(y) -beta*omega_c*y+log(S(y));
pQpy = @(y) beta*(OmegaTilde/2)^4*quadgk(@(kz) exp(-beta*kz.^2/2).*...
    (beta/2*cosh(beta*eta(kz,y))-...
    sinh(beta*eta(kz,y))/2./eta(kz,y))./(eta(kz,y).^2),-maxKZ,maxKZ);
SecondOrder = @(y) (pQpy(y).*S(y)-Q(y).^2)./(S(y).^2);
for ny = 1:length(ay)
    y = ay(ny);
    phiy(ny) = phi(y);
end
plot(ay,phiy,'k','linewidth',2)
hold off
xlabel('y')
ylabel('\phi(y)')
title(['d^2\phi(y)/d y^2 |_{y_0}=', num2str(SecondOrder(y0)) ])
set(gca,'fontsize',16)