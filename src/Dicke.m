%% This is the program to determine the Dicke phase diagram according to the 
%    transedantal equation
clear
clc
%close all
clf
% units are taken to be \hbar=m=k_B=1
kr = 0.22;
delta = 0.2;
aO = 0.01:0.03:3;
aT = 0.01:0.01:1; 
for nO = 1:length(aO)
    OmegaTilde = aO(nO);
omega_c = 1; % --> equivalent to delta_R
for nT = 1:length(aT)
T = aT(nT);
beta = 1/T;

maxKZ = 10;

eta = @(y) sqrt(1+(OmegaTilde/2/delta)^2*y);
S = @(y) 2*cosh(beta*delta*eta(y));
FirstOrder = @(y) -delta*omega_c/(OmegaTilde)^2*8+tanh(beta*delta*eta(y))./eta(y);
[y0,fval]=fsolve(FirstOrder, 0.0, optimset('Display','off'));
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
set(gca,'fontsize',16)
imagesc(aO,aT,photon')
xlabel('\Omega/\omega')
ylabel('k_B T')
set(gca,'YDir','normal')
%zlabel('photon number')
%axis([0 max(aO) 0 max(aT) 0 max(max(photon))])
axis([0 max(aO) 0 max(aT)])
colorbar
colormap(hot)
title('photon number')
%save Dicke.mat


