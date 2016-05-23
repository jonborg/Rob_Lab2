function [erro_rob] = erro(xref,yref,teta_ref,xreal,yreal,teta_real)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    delta_x=xref-xreal;
    delta_y=yref-yreal;
       while teta_real > 2*pi
        teta_real=teta_real-2*pi;
    end
    while teta_real< -2*pi
        teta_real=teta_real+2*pi;
    end
    delta_teta=teta_ref-teta_real;
    erro_rob=[cos(teta_real) sin(teta_real) 0; -sin(teta_real) cos(teta_real) 0; 0 0 1]*[delta_x delta_y delta_teta]';
    

end

