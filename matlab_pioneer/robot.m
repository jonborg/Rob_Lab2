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
        m=6000;
        pause(1);
        if i>45 && i<335
            sonars=pioneer_read_sonars()
            [m,ind]=min(sonars(1:8));
        end
        if m<400 && ready==1;
            ready=0;
            counter=0;
            stop(t);
%             delete(t);
              if (teta_real(i)<=-pi/4 && teta_real(i)>-3*pi/4)
                if ind<=4 %esquerda do robo
                    xref=xref-adjust;
                else
                    xref=xref+adjust;
                end
              end
              if teta_real(i)<=pi/4 && teta_real(i)>-pi/4
                if ind<=4 %esquerda do robo
                    yref=yref-adjust;
                else
                    yref=yref+adjust;
                end
              end
              if teta_real(i)<=3*pi/4 && teta_real(i)>pi/4
                if ind<=4 %esquerda do robo
                    xref=xref+adjust;
                else
                    xref=xref-adjust;
                end
              end
              if (teta_real(i)<=5*pi/4 && teta_real(i)>3*pi/4 )||(teta_real(i)<=-3*pi/4) 
                 if ind<=4 %esquerda do robo
                    yref=yref+adjust;
                else
                    yref=yref-adjust;
                end
              end
%             odom=pioneer_read_odometry();
%             world=[0 1 xreal(1); -1 0 yreal(1); 0 0 1]*[odom(1)/1000 odom(2)/1000 1]';
%             xreal(i)=world(1);
%             yreal(i)=world(2);
%             teta_real(i)=-pi/2+2*pi/4096*odom(3);
%             if teta_real(i-1)<0 && odom(3)>3072
%                teta_real(i)=teta_real(i)-2*pi; 
%             end
%                         
%             erro_rob(:,i)=erro(xref(i),yref(i),teta_ref(i),xreal(i),yreal(i),teta_real(i));
%             v(:,i)=Controller(vel,wref(i),erro_rob(:,i));
%             vels_rob(:,i)=[vel*cos(erro_rob(3,i));wref(i)]-v(:,i);
            %pioneer_set_controls(sp,round(vels_rob(1,i)*1000),round(vels_rob(2,i)*180/pi));
%             t=timer('TimerFcn','odometria','StartDelay',T);
%             start(t);
            flag=1;
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


