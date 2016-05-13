if mode==0
    vels_world(:,i)=[cos(teta_real(i)) 0; sin(teta_real(i)) 0; 0 1]*vels_rob(:,i);
    xreal(i+1)=xreal(i)+T*vels_world(1,i);
    yreal(i+1)=yreal(i)+T*vels_world(2,i);
    teta_real(i+1)=teta_real(i)+T*vels_world(3,i);
end


if mode==1
    t=timer('TimerFcn','odometria','StartDelay',T);
    pioneer_set_controls(sp,round(vels_rob(1,i)*1000),round(vels_rob(2,i)*180/pi));
    start(t);
    while flag==0
        pause(0.5);
        sonars=pioneer_read_sonars()
        [m,ind]=min(sonars(1:8));
        if m<300 
            stop(t);
            delete(t);
            pioneer_set_controls(sp,round(vels_rob(1,i)*1000),round(20*(ind-4.5)));
            pause(1);
            pioneer_set_controls(sp,round(vels_rob(1,i)*1000),round(vels_rob(2,i)*180/pi));
            t=timer('TimerFcn','odometria','StartDelay',T);
            start(t);
        end
        if flag==1
            odom=pioneer_read_odometry;
            while odom(3)>=4096
                odom(3)=odom(3)-4096;
            end
            world=[0 1 xreal(1); -1 0 yreal(1); 0 0 1]*[odom(1)/1000 odom(2)/1000 1]';
             
            xreal(i+1)=world(1);
            yreal(i+1)=world(2);
            teta_real(i+1)=-pi/2+2*pi/4096*odom(3);
            if teta_real(i)<0 && odom(3)>3072
               teta_real(i+1)=teta_real(i+1)-2*pi; 
            end
            plot(xreal(i+1),yreal(i+1),'bo',xref(i+1),yref(i+1),'ro');
            delete(t);
        end
    end
end


