
    imshow(piso5,'InitialMagnification',33);
    hold on;
    plot(xref*57,57*(28.5-yref),'r');
    labels = cellstr(num2str([1:length(x)]') );
    plot(57*x,57*(28.5-y),'ro');
    text(57*x,57*(28.5-y),labels);
   
    figure
    imshow(piso5,'InitialMagnification',33);
    hold on;
    plot(xreal*57,57*(28.5-yreal),'b');
    labels = cellstr( num2str([1:length(x)]') );
    j=1;
    for i=1:div:length(xreal)
        xe(j)=xreal(i);
        ye(j)=yreal(i);
        j=j+1;
    end
    plot(57*xe,57*(28.5-ye),'bo');
    text(57*xe,57*(28.5-ye),labels);
    plot(57*x,57*(28.5-y),'ro');
    text(57*x,57*(28.5-y),labels);
    figure
    
    plot(teta_real,'b');
    hold on;
    plot(teta_ref,'r');
