%% This file calculates the difference between the model and the data
function fit_final = mdfit_final_base(p,current_r1,current_r2, current_r3,current_z1,current_nsp9)

% Set the parameter to be fit (note that p can be a vector)
 %beta=p ;

% Data point - This is the prevalence that the beta_fit parameter will try
% to fit to
options = odeset('RelTol', 1e-4, 'NonNegative', [1 2 3 4]);
[t,y] = ode45(@(t,y) mfit_eq_final_base(t,y,p,current_z1,current_nsp9), [1:0.01:60], [4432.72 26.7569 3574.94 21.5791], options);
w=0.42;
N=8056;
u=7.9;

% Calculate the expression for infected prevalence using the model
N=8056;
prevalence_model = [(y(1201,2)+y(1201,4))/N,(y(2401,2)+y(2401,4))/N,(y(4401,2)+y(4401,4))/N];
% Find the difference between the model and the data - we want to minimise this ?fitting_function'
  fit_final = prevalence_model -prevalence_data
end
