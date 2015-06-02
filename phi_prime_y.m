%% This is the program to determine the first order derivative of phi(y)
clear
clc
%close all
clf
% units are taken to be \hbar=m=k_B=1
kr = 0;
delta = 0.2;
OmegaTilde = 1.5;
% for OmegaTilde=0:0.1:5
omega_c = 1;
T = 0.1;
 for T = 0.01:0.01:0.5
beta = 1/T;

maxKZ = 10;

eta = @(kz,y) sqrt((kr*kz+delta).^2+(OmegaTilde/2)^2*y);
S = @(y) quadgk(@(kz) exp(-beta*kz.^2/2)*2.*cosh(beta*eta(kz,y)),-maxKZ,maxKZ);
Q = @(y) beta*quadgk(@(kz) exp(-beta*kz.^2/2).*sinh(beta*eta(kz,y))*(OmegaTilde/2)^2./eta(kz,y),-maxKZ,maxKZ);
FirstOrder = @(y) -beta*omega_c+Q(y)./S(y);
[y0,fval]=fsolve(FirstOrder, 0.0, optimset('Display','iter'));
y0
pQpy = @(y) beta*(OmegaTilde/2)^4*quadgk(@(kz) exp(-beta*kz.^2/2).*...
    (beta/2*cosh(beta*eta(kz,y))-...
    sinh(beta*eta(kz,y))/2./eta(kz,y))./(eta(kz,y).^2),-maxKZ,maxKZ);
SecondOrder = @(y) (pQpy(y).*S(y)-Q(y).^2)./(S(y).^2);
SecondOrder(y0)
phi = @(y) -beta*omega_c*y+log(S(y));
% figure(1)
% ay = 0:0.01:1;
% for y = ay
%     scatter(y,phi(y))
%     hold on
% end
% hold off
% xlabel('y')
% ylabel('\phi(y)')
% title(['d^2\phi(y)/d y^2 =', num2str(SecondOrder(y0)) ])
% figure(2)
% hold on
% if y0>0
%     scatter(OmegaTilde,y0)
% else
%     scatter(OmegaTilde,0)
% end
% hold off
% end
% set(gca,'fontsize',16)
% xlabel('Tavis cummings \Omega')
% ylabel('average photon number')
% title(['k_BT = ',num2str(T)])
figure(3)
hold on
if y0>0
    scatter(T,y0)
else
    scatter(T,0)
end
hold off
end
set(gca,'fontsize',16)
xlabel('Temperature')
ylabel('average photon number')
title(['Tavis Cummings \Omega = ',num2str(OmegaTilde)])