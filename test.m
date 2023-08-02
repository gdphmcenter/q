function out =test(input)
    e=input(1);%从外部读取误差e和ce
    ce=input(2);

        k_e=3; 
        e = k_e*e;
        k_ce=30;
        ce=k_ce*ce;
        e_fuzzy=e;
        ce_fuzzy=ce;
        error_degree=memfunc(e_fuzzy);
        ce_degree=memfunc(ce_fuzzy);
    
    %     e_set=0
    %     ce_set=0;
    
    %     if e > 0.08
    %         e=e;
    %         ce=ce;
    %     else
    %         e_set=e;
    %         ce_set=ce;   
    %         e=e_set*0.35;
    %         ce=ce_set*0.5;
    %     end
    %     [error_degree,ce_degree] =fuzzye(e,ce);
    
        ratio_e=find(error_degree~=0);
        ratio_ce=find(ce_degree~=0);
        RULES=[1,1,7;
                       1,2,7;
                       1,3,7;
                       1,4,6;
                       1,5,6;
                       1,6,6;
                       1,7,5;
        
                       2,1,7;
                       2,2,7;
                       2,3,6;
                       2,4,6;
                       2,5,5;
                       2,6,5;
                       2,7,5;
                       
                       3,1,6;
                       3,2,6;
                       3,3,5;
                       3,4,5;
                       3,5,5;
                       3,6,5;% 4
                       3,7,5;% 4
        
                       4,1,5;
                       4,2,5;
                       4,3,5;
                       4,4,4;
                       4,5,3;
                       4,6,3;
                       4,7,3;
                       
                       5,1,4;
                       5,2,4;
                       5,3,3;
                       5,4,3;
                       5,5,3;
                       5,6,2;
                       5,7,2;
        
                       6,1,4;
                       6,2,3;
                       6,3,3;
                       6,4,3;
                       6,5,2;
                       6,6,2;
                       6,7,1;
        
                       7,1,3;
                       7,2,2;
                       7,3,1;
                       7,4,1;
                       7,5,1;
                       7,6,1;
                       7,7,1;       
            ];
        set=[];
        C=[];
        for i=1:length(ratio_e)
            for j=1:length(ratio_ce)
                aa=RULES((ratio_e(i)-1)*7+ratio_ce(j),3);%
                set=[set,aa];
            end
        end
        
        for i=1:length(set)
            C(i,:)=caseu(set(i));
        end
        
        
        w=[];
        for  i=1:length(ratio_e)
            for j=1:length(ratio_ce)
                w(end+1)=min(error_degree(ratio_e(i)),ce_degree(ratio_ce(j))); 
            end
        end 
        
        A=[];
        for i=1:length(w)
            A(i,:)=min(w(i),C(i,:));
        end
        Cs=[];
        for i=1:size(A,2)
            Cs(end+1)=max(A(:,i));
        end
    
        %解模糊
        U=[-3,-2,-1,0,1,2,3];
        fenzi=0;
        fenmu=0;
     
        for i=1:7
            fenzi=fenzi+U(i)*Cs(i);
        end
        for i=1:7
            fenmu=fenmu+Cs(i);
        end
        u_fuzzy=fenzi/fenmu;
        out=u_fuzzy;


    

  end
% %模糊化分7级，{-3,-2,-1....1,2,3}
% 
% error_degree=memfunc(e_fuzzy);
% ce_degree=memfunc(ce_fuzzy);
%  end


function degree=memfunc(e_fuzzy)
x=e_fuzzy;

NB=0;
NM=0;
NS=0;
ZE=0;
PS=0;
PM=0;
PB=0;
degree=[NB,NM,NS,ZE,PS,PM,PB];
if x>=-3 & x<-2
    NB=-x-2;
end

if x>-3 & x<-1
    if x>-3 & x<=-2
        NM=x+3;
    else
        NM=-x-1;
    end
end

if x>=-2 & x<0
    if x>=-2 & x<-1
        NS=x+2;
    else
        NS=-x;
    end
end

if x>=-1 & x<1
    if x>=-1 & x<0
        ZE=x+1;
    else
        ZE=-x+1;
    end
end


if x>=0 & x<2
    if x>=0 & x<1
        PS=x;
    else
        PS=-x+2;
    end
end



if x>=1 & x<3
    if x>=1 & x<2
        PM=x-1;
    else
        PM=-x+3;
    end
end
if x>=2 & x<=3
    PB=x-2;
end
degree=[NB,NM,NS,ZE,PS,PM,PB];

  end

