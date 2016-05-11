t=timer('TimerFcn',@(x,y)odometria,'StartDelay',3,'ExecutionMode','fixedRate','Period',3,'TaskstoExecute',5);
        global j
global flag
flag=0;
j=0;
tic
start(t);
while flag==0
   pause(0.01)
    if flag==1
        display('YES');
    end
end
toc
