%% Final Model equations for fitting
function dy = acutemfit_eq_final(t,y,fitted_p,current_r18,current_z1,current_z2,current_z3,current_z4,current_z5,current_nsp1,current_nsp2,current_nsp3,current_nsp4,current_nsp5,current_nsp6,current_nsp7,current_nsp8,current_nsp9,current_nsp10,current_nsp11,current_nsp12,current_nsp13)
%% create a vector dy 6x1, six rows and one column
  dy = zeros(length(y),1);
% Write the equations
q=(1/12)/12; 
m=(0.0231)/12;%death rate per month from Mathers for Western Europe
N=8056;
d=1/3;
h=m+q;
param1 = fitted_p(1);

if t>=1 && t<44
param3=0;
elseif t>=44 && t<=60
param3=fitted_p(3);
end


%param2=p(2);%TRANSITION FROM HIGH TO LOW RISK
if t>=1 && t<44 
    param2=0.005; 
elseif t>=44 && t<=60
    param2=fitted_p(2);
end

u=10;
a=0.34;
w=current_r18;
r=26;

if t>=1 && t<45
 z=current_z1; 
elseif t>=45 && t<=48
 z=current_z2; 
elseif t>=48 && t<52
 z=current_z3; 
elseif t>=52 && t<55
   z=current_z4;
elseif t>=55 && t<=60 
   z=3291;
   z=current_z5; 
end

%Proportion with adequate syringe coverage in past month (95% CI):
   if t>=1 && t<36
    nsp=0.0;
   elseif t>=36 && t<37
    nsp=0.05;
   elseif t>=37 && t<38
     nsp=current_nsp1;
  elseif t>=38 && t<39
    nsp=current_nsp2;
   elseif t>=39 && t<40
    nsp=current_nsp3; 
   elseif t>=40 && t<41
        nsp=current_nsp4;
   elseif t>=41 && t<42
     nsp=current_nsp5;
   elseif t>=42 && t<43
    nsp=current_nsp6; 
   elseif t>=43 && t<44
      nsp=current_nsp7;
   elseif t>=44 && t<45
     nsp=current_nsp8;
   elseif t>=45 && t<=47
      nsp=current_nsp9; 
   elseif t>47 && t<50
   nsp=current_nsp10;
   elseif t>=50 && t<54
   nsp=current_nsp11;
   elseif t>=54 && t<57
   nsp=current_nsp12;
   elseif t>=57 && t<=60
   nsp=current_nsp13;
   end
nsp_r=(1-nsp)+nsp*a;

r=26;
w=current_r18;
%TRANSMISSION PER MONTH PERIOD
lamda0=param1*((r*y(2)+y(3)+w*y(4))/N);
lamda1=u*param1*((r*y(6)+y(7)+w*y(8))/N);

  dy(1)=h*(1-z)*N-lamda0*nsp_r*y(1)-(m+q)*y(1)+param2*y(5);%S0
  dy(2)=lamda0*nsp_r*y(1)-(d+m+q)*y(2)+param2*y(6);%H0
  dy(3)=d*y(2)-(m+q+param3)*y(3)+param2*y(7);%I0 
  dy(4)=param3*y(3)-(m+q)*y(4)+param2*y(8);%A0
  dy(5)=h*z*N-lamda1*nsp_r*y(5)-(m+q)*y(5)-param2*y(5);% S1 
  dy(6)=lamda1*nsp_r*y(5)-param2*y(6)-(d+m+q)*y(6);%H1
  dy(7)=d*y(6)-(m+q)*y(7)-param2*y(7)-(param3/1.69)*y(7);%I1
  dy(8)=(param3/1.69)*y(7)-(m+q+param2)*y(8);%A1
    %end
end

