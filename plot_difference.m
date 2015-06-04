%% comparing the two results with and without SOC
% clear
% clc
% close all
% load phase_diagram.mat 
% photonkr = photon';
% clear photon
% load phase_diagram_kr_0.mat
% photon0 = photon';
% surf(aO,aT,photon0-photonkr)
% xlabel('\Omega')
% ylabel('T')
% zlabel('photon number difference = n_{kr=0}-n_{kr=0.22} ')
%axis([0 max(aO) 0 max(aT) 0 max(max(photon))])

%% Plotting the phase boundary in two cases
clear
clc
close all
load phase_diagram.mat 
photonkr = photon;
clear photon
load phase_diagram_kr_0.mat
photon0 = photon;
clear photon
load phase_diagram_delta_0.mat
photonD = photon;
clear photon
%
% Tckr = zeros(1,length(aO));
% for nO = 1:length(aO)
%     OmegaTilde = aO(nO);
%     for nT = 1:length(aT)
%         T = aT(nT);
%         if photonkr(nO,nT)>0
%             Tckr(nO) = T;
%             break;
%         end
%     end
% end           
% %
% Tck0 = zeros(1,length(aO));
% for nO = 1:length(aO)
%     OmegaTilde = aO(nO);
%     for nT = 1:length(aT)
%         T = aT(nT);
%         if photon0(nO,nT)>0
%             Tck0(nO) = T;
%             break;
%         end
%     end
% end
% figure(1)
% plot(aO,Tckr,'r--',aO,Tck0,'b')
% xlabel('\Omega_c')
% ylabel('T_c')
% legend('k_r=0.22','k_r=0')
%
Ockr = 100*ones(1,length(aT));
for nT = 1:length(aT)
    T = aT(nT);
    for nO = 1:length(aO)
        OmegaTilde = aO(nO);
        if photonkr(nO,nT)>0
            Ockr(nT) = OmegaTilde;
            break;
        end
    end
end            
%
Ock0 = zeros(1,length(aT));
for nT = 1:length(aT)
    T = aT(nT);
    for nO = 1:length(aO)
        OmegaTilde = aO(nO);
        if photon0(nO,nT)>0
            Ock0(nT) = OmegaTilde;
            break;
        end
    end
end 
OckD = 100*ones(1,length(aT));
for nT = 1:length(aT)
    T = aT(nT);
    for nO = 1:length(aO)
        OmegaTilde = aO(nO);
        if photonD(nO,nT)>0
            OckD(nT) = OmegaTilde;
            break;
        end
    end
end 
figure(2)
set(gca,'fontsize',16)
plot(aT,Ockr,'ro',aT,Ock0,'b',aT,OckD,'k.')
xlabel('k_B T_c')
ylabel('\Omega_c/\omega')
legend('k_r=0.22','k_r=0','Dicke')
axis([0 max(aT) 0 3])