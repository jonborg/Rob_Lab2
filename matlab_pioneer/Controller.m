function [v] = Controller(vel,wref,erro_rob)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    damp=0.7;
    g=3;
    wn=sqrt(wref^2+g*(vel)^2);
    K1=2*damp*wn;
    K2=g*abs(vel);
    K3=K1;
    K=[-K1 0 0; 0 -sign(vel)*K2 -K3];
    v=K*erro_rob;

end

