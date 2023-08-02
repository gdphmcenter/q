%  function z=PSO_PID(Ta1)
data=xlsread('C:test.xls');
preset2=21; 
jinfeng=data(:,1);
Input_air=medfilt1(jinfeng);
Input_air=smoothdata(Input_air,'gaussian',20);
Input_air=Input_air(1:8700);
chufeng=data(:,2);
Out_air=medfilt1(chufeng);
Out_air=Out_air(1:8700);
Fitness1=[];
Fitness2=[];
account_fitness1=0;
account_fitness2=0;
accounte=0;
%  Ta1=[19.9355839855743	6.60865270440891	20	19.9653334506800];%
   Ta1=[20	5.77912079196740	20	20]; %pso-qnm 
%   Ta1=[15.4790476672858	8.84505707710188	19.7809411038007	19.4465021494986];%ga 
kp1=0;
ki1=0;
kd1=0;
kp2=0;
ki2=0;kd2=0; 
% Ta=[1 1 1 1]
fid=[0];
global chu;
chu=water(18.5,8700);
 Y5=0;
e=[];
y=[];
YY5=[];
e2=[];
%2路
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

uu5=[];
sys5 = tf([-1.1914],[8.6006,1]);
sys5=c2d(sys5,1);
a5=cell2mat(sys5.Numerator);
b5=cell2mat(sys5.Denominator);

e_log=[];
fitadd=0;
bb=[];
error=Out_air(1)-preset2;
e(1)=error;
error=Out_air(2)-preset2;
 savee=[];
% for i =1:length(Input_air)-60
for i =2:6400
            if i>3000

            preset2=23;
        end
        e2(i)=error;

        if i ==1
            de=0;
        else
            de=(e2(i)-e2(i-1));
        end
        e(i)=error*Ta1(1);
        ec=(e(i)-e(i-1))*Ta1(2);
        u2=test([e(i),ec])*Ta1(3)*test2(e2(i),de);
        u3=test([e(i),ec])*Ta1(4)*test2(e2(i),de);
%         u2=test([e(i),ec])*Ta1(3);
%         u3=test([e(i),ec])*Ta1(4);

    accounte=accounte+e2(i);
    acc2=acc2+u2-kp1*e2(i)-ki1*accounte+kd1*de;
    if acc2 >1000
        acc2=1000;
    end
    if acc2<0
        acc2=0;
    end
    acc3=acc3+u3-kp2*e2(i)-ki2*accounte+kd2*de;
    if acc3 >1000
        acc3=1000;
    end
    if acc3<0
        acc3=0;
    end
    value_tem=[Input_air(i)-chu(i)];
    uu5(end+1)=value_tem; 
     uu2(end+1)=acc2;
      uu2=floor(uu2);
     uu3(end+1)=acc3;
     uu3=floor(uu3);
    Y2=filter(a2,b2,uu2);
    Y3=filter(a3,b3,uu3);
    Y5=filter(a5,b5,uu5);
    y(i)=Y2(end)+Y3(end)+Y5(end)+Input_air(i);
    error=y(i)-preset2;
    savee(end+1)=error;
   e_log(end+1)=abs(error);
    account_fitness1=account_fitness1+abs(error)*i+abs(de)*i;
     Fitness1(end+1)=account_fitness1;
     account_fitness2=account_fitness2+abs(error)*767;
     Fitness2(end+1)=account_fitness2;
     fitadd=fitadd+Fitness1(end)+Fitness2(end);
end
%3:8
    z=fitadd;
% end
biao=[];
for i=1:6500
    biao(end+1)=21;
end
y(1)=Out_air(1);
figure(1);
plot(biao,'r','LineWidth',2);hold on
plot(y,'b','LineWidth',2);
axis([-inf,inf,20.5,24.5]);
hold off 
figure(25);
plot(uu2,'r');hold on
plot(uu3,'b');
score_y=0;
error_y=y(1000:end)-21;
for j =1:length(error_y)
   if abs(error_y(j)) <=0.01
        score_y=score_y+1;
   end
end
score=score_y/length(error_y);


    
 
