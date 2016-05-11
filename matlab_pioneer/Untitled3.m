teta_real(1)=-pi/2;
T=[1 1 1]
for i=1:3
    i
    global flag;
    flag=0;
    t=timer('TimerFcn',@(x,y)odometria,'StartDelay',T(i));
    tic
    start(t);
    while flag==0
        pause(0.01)
        if flag==1
            toc
            display('done')
            delete(t);
        end
    end
end