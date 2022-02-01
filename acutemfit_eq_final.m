%% Final Model equations for fitting
function dy = acutemfit_eq_final(t,y,fitted_p,current_r18,current_z1,current_z2,current_z3,current_z4,current_z5,current_nsp1,current_nsp2,current_nsp3,current_nsp4,current_nsp5,current_nsp6,current_nsp7,current_nsp8,current_nsp9,current_nsp10,current_nsp11,current_nsp12,current_nsp13)
%% create a vector dy 6x1, six rows and one column
  dy = zeros(length(y),1);
% Write the equations
%S0->y(1),
q=(1/12)/12; %9 OR 15 YEARS FOR SENSITIVITY ANALYSIS
m=(0.0231)/12;%death rate per month from Mathers for Western Europe
N=8056;
d=1/3;%0.6;%1/2;
%v=1/180;
%h=m*(y(1)+y(5)+y(2)+y(6)+y(3)+y(7))/N+q+v*(y(4)+y(8))/N;
h=m+q;

param1 = fitted_p(1);

%param3=p(3)=g_low &g_low=1.69*g_high;%THERAPY for LOW RISK
if t>=1 && t<44%UNTIL july 2012
param3=0;
elseif t>=44 && t<=60
param3=fitted_p(3);
end


%param2=p(2);%TRANSITION FROM HIGH TO LOW RISK
if t>=1 && t<44 %[01/09-07/12)
    param2=0.005; %elseif t>=25 && t<43%[01/11,06/12  %param2=0.02
elseif t>=44 && t<=60%[08/12-12/13)
    param2=fitted_p(2);
end

u=10;%7.9;
a=0.34;%ASPINALL-2014-->VANA CHANGED IT AT 23/03/21!!! from 0.48 to 0.66 and to 0.42 at sensitivity analysis;
w=current_r18;%0.42;%(0.25 to 0.75) Uniform
r=26;%18;%current_r19;
%z=z_actual;
%RDS weighted-frequency of HIGH RISK-injecting FOR NEW injectors-> ALL PARTICIPANTS
%INSERT 95%CI'S FOR THE NSP

%z=0.289+(0.615-0.289)*rand;% z=0.4464403;% 
if t>=1 && t<45
 z=current_z1; 
elseif t>=45 && t<=48
%AL       z=0.4375;%0.3704;
 z=current_z2; %z=0.2588797 %z=0.143+(0.421-0.143)*rand%   
elseif t>=48 && t<52
%AL       z=3167;%0.26;
   z=current_z3;   %z=0.2751241%z(i)=0.122+(0.509-0.122)*rand;
elseif t>=52 && t<55
%AL       z=3521;%0.3070;
   z=current_z4; %   z=0.1620331%z(i)=0.096+(0.261-0.096)*rand;%
elseif t>=55 && t<=60  %%% AL - The end timepoint is t=17, right?
%AL       z=3291;%0.2818;
   z=current_z5; %   z=0.2020201%z(i)=0.109+(0.344-0.109)*rand;%
end
%end
%RDS WEIGHTED-percentage OF RECEIVED SYRINGES THROUGH PREVENTION ACTIVITIES PAST MONTH for ALL participants/SYPSA JID 2017
%RESULTS FROM LINEAR REGRESSION MODEL FROM 2009-2011 (1-45)
 
   if t>=1 && t<36
    nsp=0.0;
   elseif t>=36 && t<37%-->12/11 NSP BOOST
    nsp=0.05;
   elseif t>=37 && t<38
     nsp=current_nsp1;% nsp=0.0918889;
%ADEQUATE SYRINGE COVERAGE-RDS WEIGHTED :
      %nsp=0.061111;
   elseif t>=38 && t<39
    nsp=current_nsp2;% nsp=0.1337778;
    %nsp=0.072222;
   elseif t>=39 && t<40
    nsp=current_nsp3;  %nsp=0.1756667;
        %nsp=0.083333;
   elseif t>=40 && t<41
        nsp=current_nsp4;%nsp=0.2175556;
      % nsp=0.094444;
   elseif t>=41 && t<42
     nsp=current_nsp5; % nsp=0.2594444;
      % nsp=0.1055556;
   elseif t>=42 && t<43
    nsp=current_nsp6;   %nsp=0.3013333;
       %nsp=0.1166667;
   elseif t>=43 && t<44
      nsp=current_nsp7; %nsp=0.3432222;
      % nsp=0.1277778;
   elseif t>=44 && t<45
     nsp=current_nsp8;% nsp=0.3851111;
       %nsp=0.1388889;
   elseif t>=45 && t<=47
      nsp=current_nsp9;  %A'ROUND->nsp=0.367+(0.488-0.367)*rand;
       %nsp=0.427;
       %nsp=0.15;
   elseif t>47 && t<50
   nsp=current_nsp10; % nsp=0.327; %nsp=0.275+(0.378-0.275)*rand;% 
      %nsp=0.201;
   elseif t>=50 && t<54
   nsp=current_nsp11; % nsp=0.436;nsp=0.373+(0.498-0.373)*rand;
       %nsp=0.288;
   elseif t>=54 && t<57
   nsp=current_nsp12;%nsp=0.317;nsp=0.263+(0.37-0.263)*rand;
      % nsp=0.138;
   elseif t>=57 && t<=60
   nsp=current_nsp13; %nsp=0.323;nsp=0.277+(0.368-0.277)*rand;
       %nsp=0.204;
   end
nsp_r=(1-nsp)+nsp*a;

%nsp_r=0.18;
%if t>=1 && t<44%UNTIL july 2012
%elseif t>=44 && t<=60
%end
r=26;%r=current_r19;%23;%26;18;
w=current_r18;
%TRANSMISSION PER MONTH PERIOD
lamda0=param1*((r*y(2)+y(3)+w*y(4))/N);
lamda1=u*param1*((r*y(6)+y(7)+w*y(8))/N);
%CONSIDER I HAVE MOVEMENT ONLY FROM HIGH TO LOW STATES
    %for i=1:iterations
    %current_z=z(i);
  dy(1)=h*(1-z)*N-lamda0*nsp_r*y(1)-(m+q)*y(1)+param2*y(5);%S0
  dy(2)=lamda0*nsp_r*y(1)-(d+m+q)*y(2)+param2*y(6);%H0
  dy(3)=d*y(2)-(m+q+param3)*y(3)+param2*y(7);%I0 +param3*y(5)
  dy(4)=param3*y(3)-(m+q)*y(4)+param2*y(8);%A0
  dy(5)=h*z*N-lamda1*nsp_r*y(5)-(m+q)*y(5)-param2*y(5);% S1 -param3*y(5);
  dy(6)=lamda1*nsp_r*y(5)-param2*y(6)-(d+m+q)*y(6);%H1
  dy(7)=d*y(6)-(m+q)*y(7)-param2*y(7)-(param3/1.69)*y(7);%I1
  dy(8)=(param3/1.69)*y(7)-(m+q+param2)*y(8);%A1
    %end
end

%LOW RISK(0)
%d/dt(S0) = h*(1-freq)*N - lamda0*nsp_r*S0 - (m+q+itta)*S0+k*S1
%d/dt(I0)=lamda0*nsp_r*S0-(m+q+itta)*I0+k*I1-g0*I0
%d/dt(A0)=g0*I0-(m+q+itta)*A0+k*A1
%HIGH RISK (1)
%d/dt( S1 ) =h*freq*N -lamda1*nsp_r*S1 - (m+q+k)*S1 +itta*S0 
%d/dt( I1 ) = lamda1*nsp_r*S1-(m+q+k)*I1+itta*I0-g1*I1
%d/dt(A1) = g1*I1-(m+q+k)*A1+itta*A0