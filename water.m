     function chu=water(preset1,time)
%    function z =water(Ta)
% preset1=18.5;
%  time=8800;
Fitness1=[];
Fitness2=[];
data=xlsread('C:test.xls');
jinshui=data(:,3);
Input_water=medfilt1(jinshui);
Input_water = smoothdata(Input_water,'gaussian',20);
Output_water=data(:,4);
global chu;
chu=[];
e=[];
e2=[];
uu1=[0];
acc1=0;
uu4=[0];
acc4=50;
account_fitness1=0;
account_fitness2=0;
 sys1 = tf([0.0071534],[45.478,1],'ioDelay',12.8);
sys1=c2d(sys1,1);
a1=cell2mat(sys1.Numerator);
b1=cell2mat(sys1.Denominator);
sys2 = tf([-0.011139],[92.667,1],'ioDelay',84.668);
sys2=c2d(sys2,1);
a2=cell2mat(sys2.Numerator);
b2=cell2mat(sys2.Denominator);
e_log=[]; 
fitadd=0; 
    error=Output_water(1)-preset1;
    e(1)=error;
    error=Output_water(2)-preset1;
%       Ta=[3.75774955637241	1.34828521003268	20	8.12180179895838];%PSO 
%    Ta=[2.42397773723800	2.69720994228156	20	8.10373953394719];%PSO+QNM 
     Ta=[2.83454579798795	2.37288583878556	20	6.05416847484497];  %PSO+QNM
%      Ta=[10.3513159329846 0.822047461365962 14.6176930035965 6.31154180539206];%GA
%  Ta=[1 1 1 1];
kp=0.0;
ki=0.0;
kd=0.0;
    accounte=0;
    for i =2:time
        e2(i)=error;
        accounte=accounte+e2(i);
        if i ==1
            de=0;
        else
            de=(e2(i)-e2(i-1));
        end
        
        e(i)=error*Ta(1);
        ec=(e(i)-e(i-1))*Ta(2);
%         u1=test([e(i),ec])*Ta(3);
%         u4=test([e(i),ec])/5*Ta(4);
        u1=test([e(i),ec])*(Ta(3)*test2(e2(i),de));
        u4=test([e(i),ec])/5*(Ta(4)*test2(e2(i),de));
         acc1=acc1+u1-kp*e2(i)-ki*accounte+kd*de; 
        if acc1<0
            acc1=0;
        end
        if acc1>1000
            acc1=1000;
        end

        if error <= 0
            u4=-u4;
             acc4=acc4+u4+kp*e2(i)+ki*accounte-kd*de;
            if acc4 >100
            acc4=100;
            end
            if acc4<50
            acc4=50;
            end
        else
            u4=abs(u4);
             acc4=acc4+u4-kp*e2(i)-ki*accounte+kd*de;
            if acc4 >100
                acc4=100;
            end
            if acc4<50
                acc4=50;
            end
        end
        uu1(end+1)=acc1;
        uu1=floor(uu1);
        uu4(end+1)=acc4;
        uu4=floor(uu4);
        Y1=filter(a1,b1,uu1);
        Y4=filter(a2,b2,uu4);

         out_water=Y1(end)+Y4(end)+Input_water(i);
        chu(end+1)=out_water;
        error=out_water-preset1;
        e_log(end+1)=abs(error);
%        fitadd=fitadd+trapz(e_log); 
         account_fitness1=account_fitness1+abs(error)*i+abs(de)*i;
         Fitness1(end+1)=account_fitness1;
         account_fitness2=account_fitness2+abs(error)*767;
         Fitness2(end+1)=account_fitness2;
         fitadd=fitadd+Fitness1(end)+Fitness2(end);
%1:2的配置
    end
    chu=chu(50:end);
    z=fitadd;
    Output_water=Output_water(1:6500)';
