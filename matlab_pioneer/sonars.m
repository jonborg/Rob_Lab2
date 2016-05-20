if i>35 && i<76
    switch ind
        case 1
            teta_real(i)=-pi/2;
            xreal(i)=8.25-so(ind)/1000;
        case 2
            teta_real(i)=-pi/2+40*pi/180;
            xreal(i)=8.25-so(ind)/1000;
        case 3
            teta_real(i)=-pi/2+60*pi/180;
            xreal(i)=8.25-so(ind)/1000;
        case 4
            teta_real(i)=-pi/2+80*pi/180;
            xreal(i)=8.25-so(ind)/1000;
        case 5
            teta_real(i)=-pi/2-80*pi/180;
            xreal(i)=6.50+so(ind)/1000;
        case 6
            teta_real(i)=-pi/2-60*pi/180;
            xreal(i)=6.50+so(ind)/1000;
        case 7
            teta_real(i)=-pi/2-40*pi/180;
            xreal(i)=6.50+so(ind)/1000;
        case 8 
            teta_real(i)=-pi/2;
            xreal(i)=6.50+so(ind)/1000;
    end
end

if i>91 && i<136
    switch ind
        case 1
            teta_real(i)=0;
            yreal(i)=8.25-so(ind)/1000;
        case 2
            teta_real(i)=0+40*pi/180;
            yreal(i)=8.25-so(ind)/1000;
        case 3
            teta_real(i)=0+60*pi/180;
            yreal(i)=8.25-so(ind)/1000;
        case 4
            teta_real(i)=0+80*pi/180;
            yreal(i)=8.25-so(ind)/1000;
        case 5
            teta_real(i)=0-80*pi/180;
            yreal(i)=6.50+so(ind)/1000;
        case 6
            teta_real(i)=0-60*pi/180;
            yreal(i)=6.50+so(ind)/1000;
        case 7
            teta_real(i)=0-40*pi/180;
            yreal(i)=6.50+so(ind)/1000;
        case 8 
            teta_real(i)=0;
            yreal(i)=6.50+so(ind)/1000;
    end
end

if i>151 && i<196
    switch ind
        case 1
            teta_real(i)=pi/2;
            xreal(i)=20.25+so(ind)/1000;
        case 2
            teta_real(i)=pi/2+40*pi/180;
            xreal(i)=20.25+so(ind)/1000;
        case 3
            teta_real(i)=pi/2+60*pi/180;
            xreal(i)=20.25+so(ind)/1000;
        case 4
            teta_real(i)=pi/2+80*pi/180;
            xreal(i)=20.25+so(ind)/1000;
        case 5
            teta_real(i)=pi/2-80*pi/180;
            xreal(i)=22.5-so(ind)/1000;
        case 6
            teta_real(i)=pi/2-60*pi/180;
            xreal(i)=22.5-so(ind)/1000;
        case 7
            teta_real(i)=pi/2-40*pi/180;
            xreal(i)=22.5-so(ind)/1000;
        case 8 
            teta_real(i)=pi/2;
            xreal(i)=22.5-so(ind)/1000;
    end
end

if i>211 && i<247
    switch ind
        case 1
            teta_real(i)=pi;
            yreal(i)=20.25+so(ind)/1000;
        case 2
            teta_real(i)=pi+40*pi/180;
            yreal(i)=20.25+so(ind)/1000;
        case 3
            teta_real(i)=pi+60*pi/180;
            yreal(i)=20.25+so(ind)/1000;
        case 4
            teta_real(i)=pi+80*pi/180;
            yreal(i)=20.25+so(ind)/1000;
        case 5
            teta_real(i)=pi-80*pi/180;
            yreal(i)=22-so(ind)/1000;
        case 6
            teta_real(i)=pi-60*pi/180;
            yreal(i)=22-so(ind)/1000;
        case 7
            teta_real(i)=pi-40*pi/180;
            yreal(i)=22-so(ind)/1000;
        case 8 
            teta_real(i)=pi;
            yreal(i)=22-so(ind)/1000;
    end
end