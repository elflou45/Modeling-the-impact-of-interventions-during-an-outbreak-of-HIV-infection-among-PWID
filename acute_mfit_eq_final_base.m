%% Final Model equations-Baseline Scenario:fit up to 06/12 and then projection to see the impact of prevention programmes such as OST/NSP/HAART
function dy = mfit_eq_final_base(t,y,fitted_parameter_beta,current_z1,current_nsp9)
% create a vector dy 6x1, six rows and one column
dy = zeros(length(y),1);
q=(1/12)/12; 
m=(0.0231)/12;%death rate per month from Mathers
h=m+q;
N=8056;
param1 = fitted_parameter_beta;
k=0.005;
u = 7.9;
psi=0.48;

z=current_z1; 

if t>=1 && t<36
    nsp=0.0;
elseif t>=36 && t<=60
    nsp=current_nsp9;
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

