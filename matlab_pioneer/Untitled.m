odo=0;
sp=serial_port_start();
pioneer_set_controls(sp,100,0);
t=timer('TimerFcn','odo==1;odometry=pionner_odometry()''StartDelay',4);
start(t);
while odo==0
    odo
end
odo=0;
pioneer_set_controls(sp,-100,0);
t=timer('TimerFcn','odo==1;odometry=pionner_odometry()''StartDelay',4);
start(t);
while odo==0
    odo
end
pioneer_set_controls(sp,0,0);
delete(t);
serial_port_stop(sp);