a=div/15;
r=0.19;
if ready==1
    if i>floor(a*45) && i<floor(a*76)
        ind
        switch ind
            case 1
                %teta_real(i)=-pi/2;
                xreal(i)=8.25-r-so(ind)/1000;
            case 2
                %teta_real(i)=-pi/2+40*pi/180;
                xreal(i)=8.25-r-so(ind)/1000;
            case 3
                %teta_real(i)=-pi/2+60*pi/180;
                xreal(i)=8.25-r-so(ind)/1000;
            case 4
                %teta_real(i)=-pi/2+80*pi/180;
                xreal(i)=8.25-r-so(ind)/1000;
            case 5
                %teta_real(i)=-pi/2-80*pi/180;
                xreal(i)=6.65+r+so(ind)/1000;
            case 6
                %teta_real(i)=-pi/2-60*pi/180;
                xreal(i)=6.65+r+so(ind)/1000;
            case 7
                %teta_real(i)=-pi/2-40*pi/180;
                xreal(i)=6.65+r+so(ind)/1000;
            case 8 
                %teta_real(i)=-pi/2;
                xreal(i)=6.65+r+so(ind)/1000;
        end
    end

    if i>floor(a*91) && i<=floor(a*136)
%        so(1:4)=[5000 5000 5000 5000];
        [m,ind]=min(so);
        switch ind
            case 1
                yreal(i)=8.25-r-so(ind)/1000;
            case 2
                yreal(i)=8.25-r-so(ind)/1000;
            case 3
                yreal(i)=8.25-r-so(ind)/1000;
            case 4
                yreal(i)=8.25-r-so(ind)/1000;
            case 5
                yreal(i)=6.65+r+so(ind)/1000;
            case 6
                yreal(i)=6.65+r+so(ind)/1000;
            case 7
                yreal(i)=6.65+r+so(ind)/1000;
            case 8 
                yreal(i)=6.65+r+so(ind)/1000;
        end
    end

    if i>floor(a*151) && i<floor(a*196)
 %       so(1:4)=[5000 5000 5000 5000];
        [m,ind]=min(so);
        switch ind
            case 1
                xreal(i)=20.25+r+so(ind)/1000;
            case 2
                xreal(i)=20.25+r+so(ind)/1000;
            case 3
                xreal(i)=20.25+r+so(ind)/1000;
            case 4
                xreal(i)=20.25+r+so(ind)/1000;
            case 5
                xreal(i)=21.85-r-so(ind)/1000;
            case 6
                xreal(i)=21.85-r-so(ind)/1000;
            case 7
                xreal(i)=21.85-r-so(ind)/1000;
            case 8 
                xreal(i)=21.85-r-so(ind)/1000;
        end
    end

    if i>floor(a*211) && i<floor(a*252)
        switch ind
            case 1
                yreal(i)=20.25+r+so(ind)/1000;
            case 2
                yreal(i)=20.25+r+so(ind)/1000;
            case 3
                yreal(i)=20.25+r+so(ind)/1000;
            case 4
                yreal(i)=20.25+r+so(ind)/1000;
            case 5
                yreal(i)=21.85-r-so(ind)/1000;
            case 6
                yreal(i)=21.85-r-so(ind)/1000;
            case 7
                yreal(i)=21.85-r-so(ind)/1000;
            case 8 
                yreal(i)=21.85-r-so(ind)/1000;
        end
    end
end

if i==floor(a*76)
%     minimo=5000;
%     for i=2:7
%         if abs(yreal(i)+so(i)/1000*sin(teta_real(i)+(50-20*(i-2))*pi/180)-6.65)<minimo
%             minimo=yreal(i)+so(i)/1000*sin(teta_real(i)+(50-20*(i-2))*pi/180)
%             indice=i;
%         end
%     end
    yreal(i)=6.65+r+min(so(4:5))/1000;
    
end

if i<=floor(a*136)&& i>=floor(a*134)
%     minimo
%     for i=2:7
%         if abs(xreal(i)+so(i)/1000*cos(teta_real(i)+(50-20*(i-2))*pi/180)-21.85)<minimo
%             minimo=xreal(i)+so(i)/1000*cos(teta_real(i)+(50-20*(i-2))*pi/180)
%             indice=i;
%         end
%     end
    xreal(i)=21.85-r-min(so(4:5))/1000;
    teta_real(i)=0;
end

if i==floor(a*196)
%     minimo
%     for i=2:7
%         if abs(yreal(i)+so(i)/1000*sin(teta_real(i)+(50-20*(i-2))*pi/180)-21.85)<minimo
%             minimo=yreal(i)+so(i)/1000*sin(teta_real(i)+(50-20*(i-2))*pi/180)
%             indice=i;
%         end
%     end
    yreal(i)=21.85-r-min(so(4:5))/1000;
    teta_real(i)=pi/2;
end