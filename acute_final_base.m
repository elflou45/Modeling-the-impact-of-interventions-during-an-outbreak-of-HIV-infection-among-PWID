
clear all; clc;
%% Main code
%BASELINE SCENARIO-FITTING UP TO 06/12 ONLY beta (NO kappa&gamma fit),WITH NO TRANSITION(k=0)/NO
%THERAPY(g=0)
% Guess what beta might be. Note: lb = lower bound, ub = upper bound
  beta0 = 0.008;
  beta_lb = 0;
  beta_ub =1;
  
 %INSERT 95%CI'S FOR EKTEPN PREVALENCE(2010-2011)
 pd1 = makedist('Triangular','a',0.0029,'b',0.008,'c',0.0172);
 pd2 = makedist('Triangular','a',0.0627,'b',0.081,'c',0.102);
 %INSERT 95%CI'S FOR A'ROUND ARISTOTLE PREVALENCE (RDS weighted estimates) 
 pd3 = makedist('Triangular','a',0.103,'b',0.142,'c',0.18);
 %INSERT 95%CI'S FOR THE INITIAL PREVALENCE(0.006(0.0011-0.163)
 %pd4 = makedist('Triangular','a',4356.29,'b',4401.91,'c',4423.61);
 %pd5 = makedist('Triangular','a',4.87133,'b',26.5709,'c',72.1842);
 %pd6 = makedist('Triangular','a',3350.09,'b',3513.31,'c',3567.59);
 %pd7 = makedist('Triangular','a',3.92867,'b',21.4291,'c',58.2158);
 
 
  rng('default');  % For reproducibility
  
%prevalence data (95%CI)from ALL participants from 2009(t=1) until
%06/12(t=42)
iterations=2
for i=1:iterations
   r1(i)=random(pd1);%0.0029+(0.0172-0.0029)*rand;%EKTEPN 2010
   r2(i)=random(pd2);%0.0627+(0.102-0.0627)*rand;%EKTEPN 2011
   r3(i)=random(pd3);%0.103+(0.18-0.103)*rand;%ARISTOTLE A'ROUND
   %so(i)=random(pd4);
   %io(i)=random(pd5);
   %s1(i)=random(pd6);
   %i1(i)=random(pd7);
end

%INSERT 95%CI'S FROM A'ROUND ARISTOTLE'S HIGH RISK PERCENTAGE FOR NEW INJECTORS (RDS weighted estimates)
z1 = 0.289+(0.615-0.289)*rand(1,iterations);  
%INSERT 95%CI'S FROM A'ROUND ARISTOTLE'S ADEQUATE COVERAGE SYRINGES (RDS weighted estimates)
nsp9 = 0.1112389+(0.1992129-0.1112389)*rand(1,iterations);  
for i=1:iterations
    current_r1=r1(i);
    current_r2=r2(i);
    current_r3=r3(i);
    %current_s0=so(i); 
    %current_i0=io(i); 
    %current_s1=s1(i); 
    %current_i1=i1(i); 
    current_z1 = z1(i); 
    current_nsp9=nsp9(i);
% This means that nothing is output to the display after the fit. Can be
% changed if necessary.

opts = optimset('display','off');
options=optimset('disp','iter','LargeScale','off','TolFun',1.0e-10,'MaxIter',10000,'MaxFunEvals',10000);
% Fit the parameter to the system of equations with this initial guess
  [fitted_parameter_beta,resnorm,residual,exitflag,output]= lsqnonlin(@(p) acute_mdfit_final_base(p,current_r1,current_r2, current_r3,current_z1,current_nsp9), beta0, beta_lb, beta_ub, opts);%current_s0, current_i0, current_s1, current_i1
fitted_parameter_beta;
  beta_values(i)=fitted_parameter_beta;
i
resnorm ;
A(i,:)=[i,resnorm];
[M,I] = min(A);
param1 = fitted_parameter_beta;
p = param1;
[t,y] = ode45(@(t,y) acute_mfit_eq_final_base(t,y,p,current_z1,current_nsp9), [1:0.01:60], [4432.72 0 26.7569 3574.94 0 21.5791], options);
  N=8056;
  w = 0.42;
  u = 7.9;
  q=(1/12)/12; 
  m=(0.0231)/12;%death rate per month from Mathers
  r=26;
  %INCIDENCE RATE
  lamda01(i)=fitted_parameter_beta*y(1201,2)/N;%+w*y(1201,3))/N);
  lamda02(i)=fitted_parameter_beta*y(2401,2)/N;%+w*y(2401,3))/N);
  lamda03(i)=fitted_parameter_beta*y(4401,2)/N;%+w*y(4401,3))/N);
  lamda04(i)=fitted_parameter_beta*y(4701,2)/N;%+w*y(4701,3))/N);
  lamda05(i)=fitted_parameter_beta*y(5001,2)/N;%+w*y(5001,3))/N);
  lamda06(i)=fitted_parameter_beta*y(5401,2)/N;%+w*y(5401,3))/N);
  lamda07(i)=fitted_parameter_beta*y(5701,2)/N;%+w*y(5701,3))/N);
  
 
  lamda0(:,i)=fitted_parameter_beta*(r*y(:,2)+y(:,3))/N;
  
  lamda11(i)=u*fitted_parameter_beta*(y(1201,4)/N);
  lamda12(i)=u*fitted_parameter_beta*(y(2401,4)/N);
  lamda13(i)=u*fitted_parameter_beta*(y(4401,4)/N);
  lamda14(i)=u*fitted_parameter_beta*(y(4701,4)/N);
  lamda15(i)=u*fitted_parameter_beta*(y(5001,4)/N);
  lamda16(i)=u*fitted_parameter_beta*(y(5401,4)/N);
  lamda17(i)=u*fitted_parameter_beta*(y(5701,4)/N);
  
  lamda1(:,i)=u*fitted_parameter_beta*(y(:,4)/N);
  
  %%Incidence_number 
  P_b=(bsxfun(@times,lamda0,y(:,1))+(bsxfun(@times,lamda1,y(:,3))));
  S_b=(y(:,1)+y(:,3));
  %INCIDENCE RATE
  results_incidence_timeseries=bsxfun(@rdivide,100*12*P_b,S_b);%P./S;
  
  %INCIDENCE RATE PER TIMEPOINT/PERCENTILES
  incidence_prc0=prctile(results_incidence_timeseries(1,:),[2.5 50 97.5]);
  incidence_prc1=prctile(results_incidence_timeseries(1201,:),[2.5 50 97.5]);
  incidence_prc2=prctile(results_incidence_timeseries(2401,:),[2.5 50 97.5]);
  incidence_prc3=prctile(results_incidence_timeseries(4401,:),[2.5 50 97.5]);
  incidence_prc4=prctile(results_incidence_timeseries(4701,:),[2.5 50 97.5]);
  incidence_prc5=prctile(results_incidence_timeseries(5001,:),[2.5 50 97.5]);
  incidence_prc6=prctile(results_incidence_timeseries(5401,:),[2.5 50 97.5]);
  incidence_prc7=prctile(results_incidence_timeseries(5701,:),[2.5 50 97.5]);
  incidence_prc8=prctile(results_incidence_timeseries(5901,:),[2.5 50 97.5]);
  incidb_table=[incidence_prc0;incidence_prc1;incidence_prc2;incidence_prc3;incidence_prc4;incidence_prc5;incidence_prc6;incidence_prc7;incidence_prc8;];
 
for j=1:5901
incidbase_prcj(j,:)=prctile(results_incidence_timeseries(j,:),[2.5 50 97.5]); 
end

 results_frequencyb_timeseries(:,i) = 100*(y(:,4)+y(:,3))./sum(y(:,:),2);
 %FREQUENCY PERCENTILES AT AVAILABLE DATA TIMEPOINTS
 frequencyb_prc4=prctile(results_frequencyb_timeseries(4701,:),[2.5 50 97.5]);
 frequencyb_prc5=prctile(results_frequencyb_timeseries(5001,:),[2.5 50 97.5]);
 frequencyb_prc6=prctile(results_frequencyb_timeseries(5401,:),[2.5 50 97.5]);
 frequencyb_prc7=prctile(results_frequencyb_timeseries(5701,:),[2.5 50 97.5]);
 frequencyb_prc8=prctile(results_frequencyb_timeseries(5901,:),[2.5 50 97.5]);
 freqb_table=[frequencyb_prc4;frequencyb_prc5;frequencyb_prc6;frequencyb_prc7;frequencyb_prc8;];
  
 
for j=1:5901
freqbase_prcj(j,:)=prctile(results_frequencyb_timeseries(j,:),[2.5 50 97.5]);
freqb_prcj95(j,:)=prctile(results_frequencyb_timeseries(j,:),[2.5 50 95]);
freqb_prcj90(j,:)=prctile(results_frequencyb_timeseries(j,:),[2.5 50 90]);
end

results_prevalence_timeseries(:,i) = 100*(y(:,2)+y(:,4))./sum(y(:,:),2);
  
%ESTIMATE 2.5,MEDIAN,7.5 PREVALENCE after the running-i doit after running this code but(maybe it can be done
%on the same code Ihaven;t tried it!
for j=1:5901
prevbase_prcj(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 97.5]); 
end
t1=1:5901;
plot(t1,prevbase_prcj);

%PREVALENCE PERCENTILES
prev_prc1=prctile(results_prevalence_timeseries(1201,:),[2.5 50 97.5]);
prev_prc2=prctile(results_prevalence_timeseries(2401,:),[2.5 50 97.5]);
prev_prc3=prctile(results_prevalence_timeseries(4401,:),[2.5 50 97.5]);
prev_prc4=prctile(results_prevalence_timeseries(4701,:),[2.5 50 97.5]);
prev_prc5=prctile(results_prevalence_timeseries(5001,:),[2.5 50 97.5]);
prev_prc6=prctile(results_prevalence_timeseries(5401,:),[2.5 50 97.5]);
prev_prc7=prctile(results_prevalence_timeseries(5701,:),[2.5 50 97.5]);
prev_prc8=prctile(results_prevalence_timeseries(5901,:),[2.5 50 97.5]);
prevb_table=[prev_prc1;prev_prc2;prev_prc3;prev_prc4;prev_prc5;prev_prc6;prev_prc8;];

%ESTIMATE 2.5,MEDIAN,7.5 PREVALENCE after the running-i doit after running this code but(maybe it can be done
%on the same code Ihaven;t tried it!
for j=1:5901
prevbase_prcj(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 97.5]); 
end
t1=1:5901;
plot(t1,prevbase_prcj)
title ('Model fit Baseline Scenario')

%CALCULATE INCIDENCE NUMBER
for j=1:5901
TP_b_prcj(j,:)=prctile(P_b(j,:),[2.5 50 97.5]); 
end

  %take the cases calculated in each month of each year
  IN_b9=TP_b_prcj([1,101,201,301,401,501,601,701,801,901,1001,1101],:);
  %add them up
  S_b9=sum(IN_b9);%#55.2503 VS EKTEPN 2009 (N=
  %MODEL PREDICTIONS 2010
  IN_b10=TP_b_prcj([1201,1301,1401,1501,1601,1701,1801,1901,2001,2101,2201,2301],:);
  S_b10=sum(IN_b10);%#161.1281 VS EKTEPN 2010 (N=29)
  %MODEL PREDICTIONS 2011
  IN_b11=TP_b_prcj([2401,2501,2601,2701,2801,2901,3001,3101,3201,3301,3401,3501],:);
  S_b11=sum(IN_b11);%#410.1383 VS EKTEPN 2011 (N=319)
  %MODEL PREDICTIONS 2012
  IN_b12=TP_b_prcj([3601,3701,3801,3901,4001,4101,4201,4301,4401,4501,4601,4701],:);
  S_b12=sum(IN_b12);%#570.7239 VS EKTEPN 2012 (N=523)
   %MODEL PREDICTIONS 2013
  IN_b13=TP_b_prcj([4801,4901,5001,5101,5201,5301,5401,5501,5601,5701,5801,5901],:);
  S_b13=sum(IN_b13);%#301.7750 VS EKTEPN 2012 (N=270)
   %CUMULATIVE NUMBER FOR EACH YEAR
  CN_b=[S_b9;S_b9+S_b10;S_b9+S_b10+S_b11;S_b9+S_b10+S_b11+S_b12;S_b9+S_b10+S_b11+S_b12+S_b13];
  
  





