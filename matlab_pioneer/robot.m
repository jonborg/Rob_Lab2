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
        pause(0.1);
        if flag==1
            if i==1
                odomp=[0 0 0];
            else
                odomp=odom;
            end
            odom=pioneer_read_odometry;
            while odom(3)>=4096
                odom(3)=odom(3)-4096;
            end
            world=[0 1 ; -1 0 ]*[(odom(1)-odomp(1))/1000 (odom(2)-odomp(2))/1000]';     
            xreal(i+1)=xreal(i)+world(1);
            yreal(i+1)=yreal(i)+world(2);
            teta_real(i+1)=teta_real(i)+2*pi/4096*(odom(3)-odomp(3));
            if teta_real(i)<0 && odom(3)>3072
               teta_real(i+1)=teta_real(i+1)-2*pi; 
            end
            delete(t);
        end
    end
end