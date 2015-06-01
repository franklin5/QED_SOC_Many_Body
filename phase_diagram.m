%% This is the program to determine the phase diagram according to the 
%    first order derivative of phi(y)
clear
clc
%close all
clf
% units are taken to be \hbar=m=k_B=1
kr = 0.22;
delta = 0.2;
aO = 0.01:0.1:5;
aT = 0.01:0.01:0.5; 
for nO = 1:length(aO)
    OmegaTilde = aO(nO);
omega_c = 1;
for nT = 1:length(aT)
T = aT(nT);
beta = 1/T;

maxKZ = 10;

eta = @(kz,y) sqrt((kr*kz+delta).^2+(OmegaTilde/2)^2*y);
S = @(y) quadgk(@(kz) exp(-beta*kz.^2/2)*2.*cosh(beta*eta(kz,y)),-maxKZ,maxKZ);
Q = @(y) beta*quadgk(@(kz) exp(-beta*kz.^2/2).*sinh(beta*eta(kz,y))*(OmegaTilde/2)^2./eta(kz,y),-maxKZ,maxKZ);
FirstOrder = @(y) -beta*omega_c+Q(y)./S(y);
[y0,fval]=fsolve(FirstOrder, 0.0, optimset('Display','off'));
y0
pQpy = @(y) beta*(OmegaTilde/2)^4*quadgk(@(kz) exp(-beta*kz.^2/2).*...
    (beta/2*cosh(beta*eta(kz,y))-...
    sinh(beta*eta(kz,y))/2./eta(kz,y))./(eta(kz,y).^2),-maxKZ,maxKZ);
SecondOrder = @(y) (pQpy(y).*S(y)-Q(y).^2)./(S(y).^2);
SecondOrder(y0)
phi = @(y) -beta*omega_c*y+log(S(y));
% figure(1)
% ay = 0:0.1:1;
% for y = ay
%     scatter(y,phi(y))
%     hold on
% end
% hold off
% xlabel('y')
% ylabel('\phi(y)')
    if y0>0
        photon(nO,nT) = y0;
    else
        photon(nO,nT) = 0;
    end
end
end
figure(4)
mesh(aO,aT,photon')
xlabel('\Omega')
ylabel('T')
zlabel('photon number')
%save phase_diagram.mat