%% Final Model equations-Baseline Scenario:fit up to 06/12 and then projection to see the impact of prevention programmes such as OST/NSP/HAART
function dy = mfit_eq_final_base(t,y,fitted_parameter_beta,current_z1,current_nsp9)
% create a vector dy 6x1, six rows and one column
  dy = zeros(length(y),1);
% Write the equations
%S0->y(1),
q=(1/12)/12; 
m=(0.0235)/12;%death rate per month from Mathers
h=m+q;
N=8056;
param1 = fitted_parameter_beta;
%g=0.0;%baseline scenario:no therapy
%if t>=1 && t<41 %consider from 08/11-08/12 that there is no HAART
%    p(3)=0;
%elseif t>=42 && t<=60 %estimate only this part
%    p(3);
%end

%kappa=0%baseline scenario:no transition between two states
%if t>=1 && t<41
%  p(2)=0;
%elseif t>=42 && t<=60
% p(2);
%end

%w = 0.42;
k=0.005;
u = 7.9;
psi=0.48;
%psi_ost=0.5;
%RDS frequency of HIGH RISK-injecting FOR NEW injectors->ALL PARTICIPANTS

%z=0.4464403;% consider it's the same during all period based on Aristotle's data\
 z=current_z1; 
   
%AL       z=0.4375;%0.3704;

%RDS percentage OF RECEIVED SYRINGES THROUGH PREVENTION ACTIVITIES PAST MONTH
%for ALL participants/ASSUME ZERO UP TO 12/11 WHERE THERE WAS A BOOST OF
%NSP:ASSUME 20% UNTIL O6/12 OR 40%
 
if t>=1 && t<36
    nsp=0.0;
elseif t>=36 && t<=60 %apo t=36:12/11-->BOOST NSP until t=42:06/12
    nsp=current_nsp9;%0.427;
end
nsp_r=(1-nsp)+nsp*psi;

%TRANSMISSION PER MONTH PERIOD
lamda0=param1*y(2)/N;
lamda1=u*param1*y(4)/N;
%CONSIDER NO MOVEMENT FROM HIGH TO LOW STATES(k=0) &NO THERAPY(g=0)
  dy(1)=h*(1-z)*N-lamda0*nsp_r*y(1)-(m+q)*y(1)+k*y(3);
  dy(2)=lamda0*nsp_r*y(1)-(m+q)*y(2)+k*y(4);
  dy(3)=h*z*N-lamda1*nsp_r*y(3)-(m+q+k)*y(3);
  dy(4)=lamda1*nsp_r*y(3)-(m+q+k)*y(4);
end

%LOW RISK(0)
%d/dt(S0) = h*(1-freq)*N - lamda0*nsp_r*S0 - (m+q+itta)*S0+k*S1
%d/dt(I0)=lamda0*nsp_r*S0-(m+q+itta)*I0+k*I1-g0*I0
%d/dt(A0)=g0*I0-(m+q+itta)*A0+k*A1
%HIGH RISK (1)
%d/dt( S1 ) =h*freq*N -lamda1*nsp_r*S1 - (m+q+k)*S1 +itta*S0 
%d/dt( I1 ) = lamda1*nsp_r*S1-(m+q+k)*I1+itta*I0-g1*I1
%d/dt(A1) = g1*I1-(m+q+k)*A1+itta*A0