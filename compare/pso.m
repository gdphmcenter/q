%% QNPSO and adjustment%%
% function z = pso(Ta)
% qnm
 Ta=[4.99999947308311	3.770964263290299	4.99999993233407	4.99999899282161	4.99999946712563	4.99994568289722 4.67289723123422	4.782312489722 3.789682312489722];
uu1=[0];
acc1=0;
uu4=[0];
acc4=0;
account_fitness1=0;
account_fitness2=0;
Fitness1=[];
Fitness2=[];
sys1 = tf([0.0071534],[45.478,1],'ioDelay',12.8);
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
sys2 = tf([0.0042703],[472.46,1],'ioDelay',49.188);
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
        if i == 1000
            disturb = 1000;
        else
            disturb= 0;
        end
        u1=fuzzy([e(i),ec])*Ta(3)*fuzzy_adjust(e2(i),de)+disturb;
        u2=fuzzy([e(i),ec])*Ta(4)*fuzzy_adjust(e2(i),de)+disturb;
        u3=fuzzy([e(i),ec])*Ta(5)*fuzzy_adjust(e2(i),de)+disturb;
        u4=fuzzy([e(i),ec])*Ta(6)*fuzzy_adjust(e2(i),de)+disturb;
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
            u4=-u4;
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
hold on

%% original%%
 Ta=[1 1 1 1 1 1 1 1 1];
uu1=[0];
acc1=0;
uu4=[0];
acc4=0;
sys1 = tf([0.0071534],[45.478,1],'ioDelay',12.8);
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
sys2 = tf([0.0042703],[472.46,1],'ioDelay',49.188);
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
        u1=fuzzy([e(i),ec])*Ta(3);
        u2=fuzzy([e(i),ec])*Ta(4);
        u3=fuzzy([e(i),ec])*Ta(5);
        u4=fuzzy([e(i),ec])*Ta(6);
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
            u4=-u4;
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
end
z=fitadd;
figure(1);plot(chu);

%% PSO %%
 Ta=[3.07498234366284	1.53323397294466	5	5	3.11567109171364	2.58263596632509 2.632497235422	4.21384124489722 4.1231912312489722];
uu1=[0];
acc1=0;
uu4=[0];
acc4=0;
sys1 = tf([0.0071534],[45.478,1],'ioDelay',12.8);
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
sys2 = tf([0.0042703],[472.46,1],'ioDelay',49.188);
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
        u1=fuzzy([e(i),ec])*Ta(3);
        u2=fuzzy([e(i),ec])*Ta(4);
        u3=fuzzy([e(i),ec])*Ta(5);
        u4=fuzzy([e(i),ec])*Ta(6);
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
            u4=-u4;
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

end
z=fitadd;
figure(1);plot(chu);


%% GA%%
Ta=[3.72707894014626	1.10752362001113	4.37087350645854	2.49040650576188	2.19633260598253	2.34155150843504 2.37289723123422	1.232312489722 4.725682312489722];
uu1=[0];
acc1=0;
uu4=[0];
acc4=0;
sys1 = tf([0.0071534],[45.478,1],'ioDelay',12.8);
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
sys2 = tf([0.0042703],[472.46,1],'ioDelay',49.188);
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
        u1=fuzzy([e(i),ec])*Ta(3);
        u2=fuzzy([e(i),ec])*Ta(4);
        u3=fuzzy([e(i),ec])*Ta(5);
        u4=fuzzy([e(i),ec])*Ta(6);
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
            u4=-u4;
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

end
z=fitadd;
figure(1);plot(chu);


%% QNPSO %%
 Ta=[4.99999947308311	3.770964263290299	4.99999993233407	4.99999899282161	4.99999946712563	4.99994568289722 3.47289723123422	5.782312489722 3.789682312489722];
uu1=[0];
acc1=0;
uu4=[0];
acc4=0;
account_fitness1=0;
account_fitness2=0;
Fitness1=[];
Fitness2=[];
sys1 = tf([0.0071534],[45.478,1],'ioDelay',12.8);
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

        u1=fuzzy([e(i),ec])*Ta(3);
        u2=fuzzy([e(i),ec])*Ta(4);
        u3=fuzzy([e(i),ec])*Ta(5);
        u4=fuzzy([e(i),ec])*Ta(6);
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
            u4=-u4;
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

end
z=fitadd;
figure(1);plot(chu);
legend('QNPSO-Dynamicadjustment', 'origin','PSO', 'GA','QNPSO');


%% README
% Simulation Scenario Overview
% In this simulation scenario, we consider a system composed of five distinct transfer functions, each representing different components of the system: the water valve, the water heater, two air heaters, and the coil. Our primary objective is to simulate the unit step response for an air temperature increment of 1 degree.
% 
% Methodology
% To navigate the complexities of simulating the complete system, especially the intricacies introduced by the inclusion of the coil, we adopt a simplified yet effective approach. We aggregate the responses of four key components—the water valve, the water heater, and the two air heaters—to approximate the total output response. This methodology serves as an initial screening tool for evaluating various control strategies and optimization algorithms. It allows us to sidestep the challenges of directly simulating the entire system, providing a streamlined avenue for preliminary analysis.
% 
% Purpose and Application
% This simulation code is crafted explicitly for the preliminary screening of control strategies through unit step response analysis. It is a strategic tool designed to facilitate the initial selection of controllers and optimization techniques by offering insights into their potential performance in a simplified model.
% 
% Integration with Real-world Data
% To enhance the realism and applicability of our simulations, the thesis incorporates simulations based on real-world data. These simulations aim to mirror actual environmental conditions and control responses observed in prototype testing. Such an approach ensures that our theoretical models are grounded in practical realities, offering a bridge between abstract simulation and tangible implementation.And experiments on real prototypes are also conducted in the paper.
% 
% Confidentiality Notice
% It is important to note that, due to the confidentiality of the data involved, we are unable to provide specific details about the real-world data and the actual control implementations used in our simulations. This confidentiality is paramount to preserving the integrity and proprietary nature of the information. 
%For convenience, we can use the optimization algorithm directly from the toolbox