% function z = pso(Ta)
%ga
% Ta=[3.72707894014626	1.10752362001113	4.37087350645854	2.49040650576188	2.19633260598253	2.34155150843504];
%pso
% Ta=[3.07498234366284	1.53323397294466	5	5	3.11567109171364	2.58263596632509];
% qnm
 Ta=[4.99999947308311	3.770964263290299	4.99999993233407	4.99999899282161	4.99999946712563	4.99994568289722];
% Ta=[1 1 1 1 1 1];
uu1=[0];%
acc1=0;%
uu4=[0];
acc4=0;
account_fitness1=0;
account_fitness2=0;
  Fitness1=[];
   Fitness2=[];
sys1 = tf([0.0071534],[45.478,1],'ioDelay',12.8);%
sys1=c2d(sys1,1);
a1=cell2mat(sys1.Numerator);
b1=cell2mat(sys1.Denominator);

sys4 = tf([-0.011139],[92.667,1],'ioDelay',84.668);
sys4=c2d(sys4,1);
a4=cell2mat(sys4.Numerator);
b4=cell2mat(sys4.Denominator);
e_log=[]; 
fitadd=0;

uu2=[];
acc2=0;
sys2 = tf([0.0042703],[472.46,1],'ioDelay',49.188);%
sys2=c2d(sys2,1);
a2=cell2mat(sys2.Numerator);
b2=cell2mat(sys2.Denominator);

uu3=[];
acc3=0;
sys3 = tf([0.0032152],[186.89,1],'ioDelay',83.37);
sys3=c2d(sys3,1);
a3=cell2mat(sys3.Numerator);
b3=cell2mat(sys3.Denominator);
preset=1;
error=0-preset;
e=[];
e2=[];
chu=[];
for i =1:1000
        e(i)=error*Ta(1);
        e2(i)=error;
        if i ==1
            de=0;
        else
            de=(e2(i)-e2(i-1));
        end

        if i ==1
            ec=0;
        else
            ec=(e(i)-e(i-1))*Ta(2);
        end
        u1=test([e(i),ec])*Ta(3)*test2(e2(i),de);
        u2=test([e(i),ec])*Ta(4)*test2(e2(i),de);
        u3=test([e(i),ec])*Ta(5)*test2(e2(i),de);
        u4=test([e(i),ec])*Ta(6)*test2(e2(i),de);
%         u1=test([e(i),ec])*Ta(3);
%         u2=test([e(i),ec])*Ta(4);
%         u3=test([e(i),ec])*Ta(5);
%         u4=test([e(i),ec])*Ta(6);

        acc1=acc1+u1;
        acc2=acc2+u2;
        acc3=acc3+u3;
        acc4=acc4+u4;

        if acc1<0
            acc1=0;
        end
        if acc1>1000
            acc1=1000;
        end

        if error <= 0
            u4=-u4;%
             acc4=acc4+u4;
            if acc4 >100
            acc4=100;
            end
            if acc4<50
            acc4=50;
            end
        else
            u4=abs(u4);
             acc4=acc4+u4;
        if acc4 >100
            acc4=100;
        end
        if acc4<10
            acc4=10;
        end
        end

        if acc2 >1000
            acc2=1000;
        end
        if acc2<0
            acc2=0;
        end
        if acc3 >1000
            acc3=1000;
        end
        if acc3<0
            acc3=0;
        end
        uu2(end+1)=acc2;
        uu3(end+1)=acc3;
        uu1(end+1)=acc1;
        uu4(end+1)=acc4;
        Y1=filter(a1,b1,uu1);
        Y4=filter(a2,b2,uu4);
        Y2=filter(a2,b2,uu2);
        Y3=filter(a3,b3,uu3);
        out_air=Y1(end)+Y2(end)+Y3(end)+Y4(end);
        chu(end+1)=out_air;
        error=out_air-preset;
        e_log(end+1)=abs(error);
        fitadd=fitadd+trapz(e_log);
%         account_fitness1=account_fitness1+abs(error)*i+abs(de)*i;
%          Fitness1(end+1)=account_fitness1;
%          account_fitness2=account_fitness2+abs(error)*350;
%          Fitness2(end+1)=account_fitness2;
%          fitadd=fitadd+Fitness1(end)+Fitness2(end);
end
z=fitadd;
figure(1);plot(chu);
