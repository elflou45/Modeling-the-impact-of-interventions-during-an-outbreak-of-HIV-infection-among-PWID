%% This file calculates the difference between the model and the data
function fit_final = mdfit_final_base(p,current_r1,current_r2, current_r3,current_z1,current_nsp9)

% Set the parameter to be fit (note that p can be a vector)
 %beta=p ;

% Data point - This is the prevalence that the beta_fit parameter will try
% to fit to
prevalence_data_r =[current_r1 current_r2 current_r3];%=current_r;

options = odeset('RelTol', 1e-4, 'NonNegative', [1 2 3 4]);
[t,y] = ode45(@(t,y) mfit_eq_final_base(t,y,p,current_z1,current_nsp9), [1:0.01:60], [4432.72 26.7569 3574.94 21.5791], options);
%plot(t,y)
%legend('S0', 'I0', 'A0','S1', 'I1', 'A1');
%Total=sum(y,2);
%y1=y(:,1);
%y2=y(:,2);
%y3=y(:,3);
%y4=y(:,4);
%y5=y(:,5);
%y6=y(:,6);
w=0.42;
N=8056;
u=7.9;


 %infected_prevalence_data_SI =[0.008 0.081 0.142];  %For example, 11% infected prevalence at end timepoint
% Time span over which to solve the system of equations
% Here, choose to solve from 0 to 100 in time steps of 0.5
 % tspan = 1:0.01:17;

% Initial condition of the system
% Here, suppose we start with 98 healthy people and 2 infected person
% (which is equal to a 2% infected prevalence initially)
  %y0 = [3578,6362, 60];

% Format [t,y] = ode45(odefun,tspan,y0),
% where tspan = [t0,t1], and y0 = initial conditions for your three ODEs
 % [~,y] = ode45(@(t,y) mfit_eq_final_repeat(t,y,beta_fit),tspan,y0);

% Calculate the expression for infected prevalence using the model
% In this case, it is: Infected Prevalence = I/(SL+SH+I)
N=8056;
prevalence_model = [(y(1201,2)+y(1201,4))/N,(y(2401,2)+y(2401,4))/N,(y(4401,2)+y(4401,4))/N];
%therapy_model=[y(4201,4)/(y(4201,2)+y(4201,3)+y(4201,6)+y(4201,7))];
% Find the difference between the model and the data - we want to mi];

% Find the difference between the model and the data - we want to minimise this ?fitting_function'
  fit_final = prevalence_model -prevalence_data_r;%[current_r1 current_r2 current_r3];
  %T = table(fit_final)%disp(fit_final(401))
end
