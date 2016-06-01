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
    while flag~=2
        pause(0.01);
        if flag==1
            if i==1
                odomp=[0 0 0];
            else
                odomp=odom;
                
            end
            odom=pioneer_read_odometry;

            world=[0 1 ; -1 0 ]*[(odom(1)-odomp(1))/1000 (odom(2)-odomp(2))/1000]';     
            xreal(i+1)=xreal(i)+world(1);
            yreal(i+1)=yreal(i)+world(2);
            dif=odom(3)-odomp(3);
            if dif>3000
                odomp(3)=odomp(3)+4096;
                dif=odom(3)-odomp(3);
            end
            if dif<-3000
                odom(3)=odom(3)+4096;
                dif=odom(3)-odomp(3);
            end
            teta_real(i+1)=teta_real(i)+2*pi/4096*dif;
            delete(t);
            flag=2;
        end
    end
end
