
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
    %KANW COPY-PASTE TO:R=[I(2),M(2)]
    %META PAS STA RESULTS KAI VRISKEIS BETA, KAPPA&GAMMA KOITAZONTAS TO I(2) STHN VARIABLE BETA VALUES

    %figure(1);
    %labels=cellstr(num2str(i));
   %plot(i,resnorm,'r*')
   %text(i,resnorm,labels,'HorizontalAlignment','right')
    %%%
 %%% 23Nov2018_AL:
 %%% Now solve the system of equations using the fitted_p that was just
 %%% determined in the previous step with LSQNONLIN
   param1 = fitted_parameter_beta;
   
 %%%
 %%% 23Nov2018_AL:
 %%% Note: In order to use the equations file 'mfit_eq_final_g', you will
 %%% have to make sure the input arguments are in the same format
   p = param1;
   
  [t,y] = ode45(@(t,y) acute_mfit_eq_final_base(t,y,p,current_z1,current_nsp9), [1:0.01:60], [4432.72 0 26.7569 3574.94 0 21.5791], options);

 %%%
 %%% 23Nov2018_AL:
 %%% In this main file, you have not defined what is the variable 'N'
 %%% In this case, 'N' is the total population at timepoint 1201
 
 %ELINA:prevalence_model_ = (y(:,2)+y(:,5))/N
 %PREVALENCES FOR THE TIMEPOINTS THAT I HAVE DATA:
  %results1_prevalence(i) = 100*((y(1201,2)+y(1201,4)))/sum(y(1201,:),2);
  %results2_prevalence(i) = 100*(y(2401,2)+y(2401,4))/sum(y(2401,:),2);
  %results3_prevalence(i) = 100*(y(4401,2)+y(4401,4))/sum(y(4401,:),2);
  %results4_prevalence(i) = 100*(y(4701,2)+y(4701,4))/sum(y(4701,:),2);
  %results5_prevalence(i) = 100*(y(5001,2)+y(5001,4))/sum(y(5001,:),2);
  %results6_prevalence(i) = 100*(y(5401,2)+y(5401,4))/sum(y(5401,:),2);
  %results7_prevalence(i) = 100*(y(5701,2)+y(5701,4))/sum(y(5701,:),2);
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
  
  %INCIDENCE RATE PER TIMEPOINT
  %results1_incidencerate(i) = 100*12*(lamda01(i)*y(1201,1)+lamda11(i)*y(1201,3))./(y(1201,1)+y(1201,4));
  %results2_incidencerate(i) = 100*12*(lamda02(i)*y(2401,1)+lamda12(i)*y(2401,3))./(y(2401,1)+y(2401,4));
  %results3_incidencerate(i) = 100*12*(lamda03(i)*y(4401,1)+lamda13(i)*y(4401,3))./(y(4401,1)+y(4401,4));
  %results4_incidencerate(i) = 100*12*(lamda04(i)*y(4701,1)+lamda14(i)*y(4701,3))./(y(4701,1)+y(4701,4));
  %results5_incidencerate(i) = 100*12*(lamda05(i)*y(5001,1)+lamda15(i)*y(5001,3))./(y(5001,1)+y(5001,4));
  %results6_incidencerate(i) = 100*12*(lamda06(i)*y(5401,1)+lamda16(i)*y(5401,3))./(y(5401,1)+y(5401,4));
  %results7_incidencerate(i) = 100*12*(lamda07(i)*y(5701,1)+lamda17(i)*y(5701,3))./(y(5701,1)+y(5701,4));
  
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
  %ESTIMATE 2.5,MEDIAN,7.5 INCIDENCE after the running-i doit after running this code but(maybe it can be done
%on the same code Ihaven;t tried it!
for j=1:5901
incidbase_prcj(j,:)=prctile(results_incidence_timeseries(j,:),[2.5 50 97.5]); 
end
%t1=1:5901;
%plot(t1,incidbase_prcj)
%title ('Model fit Baseline Scenario')

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


  %R0_LOW RISK GROUP
  R0l(i)=fitted_parameter_beta/(m+q);
  R0l_prc = prctile(R0l,[2.5 50 97.5]) ;
  %R0_HIGH RISK GROUP
  R0h(i)=u*fitted_parameter_beta/(m+q);
  R0h_prc = prctile(R0h,[2.5 50 97.5]) ;
  
  %RE_LOW RISK GROUP FOR THE TIMEPOINTS OF DATA
  Rel_0(i)=R0l(i)*y(1,1)/N;
  Rel_1(i)=R0l(i)*y(1201,1)/N;
  Rel_2(i)=R0l(i)*y(2401,1)/N;
  Rel_3(i)=R0l(i)*y(4401,1)/N;
  Rel_4(i)=R0l(i)*y(4701,1)/N;
  Rel_5(i)=R0l(i)*y(5001,1)/N;
  Rel_6(i)=R0l(i)*y(5401,1)/N;
  Rel_7(i)=R0l(i)*y(5701,1)/N;
  Rel_8(i)=R0l(i)*y(5901,1)/N;
  
  Rel_prc0=prctile(Rel_0,[2.5 50 97.5]);
  Rel_prc1=prctile(Rel_1,[2.5 50 97.5]);
  Rel_prc2=prctile(Rel_2,[2.5 50 97.5]);
  Rel_prc3=prctile(Rel_3,[2.5 50 97.5]);
  Rel_prc4=prctile(Rel_4,[2.5 50 97.5]);
  Rel_prc5=prctile(Rel_5,[2.5 50 97.5]);
  Rel_prc6=prctile(Rel_6,[2.5 50 97.5]);
  Rel_prc7=prctile(Rel_7,[2.5 50 97.5]);
  Rel_prc8=prctile(Rel_8,[2.5 50 97.5]);
  Relb_table=[Rel_prc0;Rel_prc1;Rel_prc2;Rel_prc3;Rel_prc4;Rel_prc5;Rel_prc6;Rel_prc8];
  %RE_HIGH RISK GROUP FOR THE TIMEPOINTS OF DATA
  
  Reh_0(i)=R0h(i)*y(1,3)/N;
  Reh_1(i)=R0h(i)*y(1201,3)/N;
  Reh_2(i)=R0h(i)*y(2401,3)/N;
  Reh_3(i)=R0h(i)*y(4401,3)/N;
  Reh_4(i)=R0h(i)*y(4701,3)/N;
  Reh_5(i)=R0h(i)*y(5001,3)/N;
  Reh_6(i)=R0h(i)*y(5401,3)/N;
  Reh_7(i)=R0h(i)*y(5701,3)/N;
  Reh_8(i)=R0h(i)*y(5901,3)/N;
  
  
  Reh_prc0=prctile(Reh_0,[2.5 50 97.5]);
  Reh_prc1=prctile(Reh_1,[2.5 50 97.5]);
  Reh_prc2=prctile(Reh_2,[2.5 50 97.5]);
  Reh_prc3=prctile(Reh_3,[2.5 50 97.5]);
  Reh_prc4=prctile(Reh_4,[2.5 50 97.5]);
  Reh_prc5=prctile(Reh_5,[2.5 50 97.5]);
  Reh_prc6=prctile(Reh_6,[2.5 50 97.5]);
  Reh_prc7=prctile(Reh_7,[2.5 50 97.5]);
  Reh_prc8=prctile(Reh_8,[2.5 50 97.5]);
  Rehb_table=[Reh_prc0;Reh_prc1;Reh_prc2;Reh_prc3;Reh_prc4;Reh_prc5;Reh_prc6;Reh_prc8;];
 %%% 23Nov2018_AL:
 %%% It might be a good idea to plot the timeseries of the solved system of
 %%% equations with each fitted_p over time, so I will save the whole
 %%% timeseries for prevalence and we will plot it below outside the FOR
 %%% loop
 %%% Note: Here we are dividing vectors, so you need to use ./ instead of
 %%%       using just /
  results_prevalence_timeseries(:,i) = 100*(y(:,2)+y(:,4))./sum(y(:,:),2);
  %CALCULATE JUST THE PREVALENCE THAT COMES FROM THE BEST FITTED PARAMETERS
  %F_results_prevalence_timeseries(:,368) = 100*(y(:,2)+y(:,4))./sum(y(:,:),2);
  
  %ESTIMATE 2.5,MEDIAN,7.5 PREVALENCE after the running-i doit after running this code but(maybe it can be done
%on the same code Ihaven;t tried it!
for j=1:5901
prevbase_prcj(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 97.5]); 
end
t1=1:5901;
plot(t1,prevbase_prcj);
  
  
  %CALCULATE JUST THE INCIDENCE THAT COMES FROM THE BEST FITTED
  %PARAMETERS AND INCIDENCE DATA:NUMBER 2 IS REPLACED BY THE NUMBER OF ITERATION  THAT GIVES
  %THE BEST FIT-take off the % symbol until line 244
  %I_R=results_incidence_timeseries(:,248);
  %plot(t,I_R);
  %xlabel('Year')
  %ylabel('HIV Incidence/100 PY (RDS-weighted)')
  %hold on;
  %tspan=[46 52 56 58];
%Aristotle data
  %y=[7.76 5.88 2.91 1.71];
  %sz = 20;
  %scatter(tspan, y, sz,'d')
  %hold on;
  %lower=[3.16 2.18 1.34 1.16];
  %upper=[5.35 3.45 2.5 3.6];
  %errorbar(tspan, y, lower,upper,'LineStyle','none','MarkerFaceColor','yellow');
%e = errorbar(tspan,y,errorbar)
%e.Color = 'yellow';
  %ax = gca;
  %ax.XTick = [1 15 30 45 58];%1 10/2012 0/12013 05/2013 08/2013 12/2013];
  %ax.XTickLabel=[{'2009','2010','2011','2012','2013'}];%];'2009','2010','2011',
  %ax.XLim = [0 60.2];
  %legend(' Baseline Scenario', 'Aristotle Seroconversion Data ','Location', 'NorthWest')
%''
%figure(4);
%Lag data
%plot(t,I_R);
%xlabel('Year')
%ylabel('HIV Incidence/100 PY (RDS-weighted)')
%hold on;
%tspan=[45 48 52 55 58];
%z=[12.62 8.55 5.99 5.94 2.41];
%sz = 20;
%scatter(tspan, z, sz,'d')
%hold on;
%err=[4.24 3.4 3.1 3 1.8];
%lower=[3.16 2.18 1.34 3.79];
%upper=[5.35 3.45 2.5 3.6];
%errorbar(tspan, z, err,'LineStyle','none');
%ax = gca;
%ax.XTick = [1 15 30 45 58];%1 10/2012 0/12013 05/2013 08/2013 12/2013];
%ax.XTickLabel=[{'2009','2010','2011','2012','2013'}];%];'2009','2010','2011',
%ax.XLim = [0 60.2];
%legend('Baseline Scenario', 'Lag Seroconversion Data','Location', 'NorthWest')
%' Baseline Scenario',

  %results_incidence_timeseries(:,i) = 100*12*(lamda0*y(:,1)'+lamda1*y(:,4))'%./(y(:,1)+y(:,4));
  %CALCULATE JUST THE INCIDENCE THAT COMES FROM THE BEST FITTED PARAMETERS
  %F_results_incidence_timeseries(:,6) = 100*12*(y(:,1)+y(:,4))./(y(:,1)+y(:,4));
%AL    output.message
end
betal_prc = prctile(beta_values,[2.5 50 97.5]) ;
beta_values_h=7.9*beta_values;
betah_prc = prctile(beta_values_h,[2.5 50 97.5]) ;

%results
%results1_prevalence;
%results2_prevalence;
%results3_prevalence;
%results4_prevalence;
%results5_prevalence;
%results6_prevalence;
%results7_prevalence;

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
%legend('2.5', '50','97.5','Location','northwest')

%beta_values_h=7.9*beta_values;
%p-percentiles
%p1_prc = prctile(results(:,1),[2.5 50 97.5]) ;
%p2_prc = prctile(results(:,2),[2.5 50 97.5]) ;
%p3_prc = prctile(results(:,3),[2.5 50 97.5]) ;

 %%%
 %%% 23Nov2018_AL:
 %%% Here we plot the prevalence over time for all the runs. This is where
 %%% you can check whether or not your fitted_p gave reasonable results.
 %%% Question: How do the model runs compare to the original data? Are they
 %%%           close? What I mean is, does the modelled prevalence line
 %%%           come close to all the data points? To see this, try to plot
 %%%           the data points on the same graph as the modelled prevalence
 %%%           lines.
  figure(2);
  %PLOT ALL THE PREVALENCE&INCIDENCE GRAPHS
  %TO PIO KATW GRAF ANTISTOIXEI STHN i=1
  plot(t,results_prevalence_timeseries)
  %plot(1:size(y,1),results_prevalence_timeseries)
  figure(3);
  plot(t,results_incidence_timeseries)
  %plot(1:size(y,1),results_incidence_timeseries)
  %hold on;
  %figure(4);
  %P_f_base=results_prevalence_timeseries(:,249);
  %plot(t,P_f_base);
  %IR_f_base=results_incidence_timeseries(:,249);
  %IN_base=P(:,249);
  
  %CALCULATE INCIDENCE NUMBER
for j=1:5901
TP_b_prcj(j,:)=prctile(P_b(j,:),[2.5 50 97.5]); 
end

  %TP_b=[t,P_b(:,249)];
  %MODEL PREDICTIONS 2009/
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
  
   %PLOT JUST THE PREVALENCE THAT COMES FROM THE BEST FITTED
   %PARAMETERS AND PREVALENCE DATA-vgale ola ta % until line 314&add arithmisi gia figures gia
   %na sou vgoun ola ta shimata
  %plot(t, F_results_prevalence_timeseries)
  %xlabel('Year')
  %ylabel('HIV Prevalence (%) / RDS weighted estimates')
  %ax = gca;
  %ax.XTick = [1 13 25 35 48 51 55 58];%1 10/2012 0/12013 05/2013 08/2013 12/2013];
  %ax.XTickLabel=[{'2009','2010','2011','2012','', '','','2013'}];
  %ax.XLim = [0 60.5];
%add EKTEPN&Aristotle data
  %tspan=[1 13 25 45 48 51 55 58];
  %y=[0.6 0.8 8.1 14.2 16.1 16.2 13.5 12];
  %sz = 20;
  %scatter(tspan, y, sz,'d')
  %hold on;
  %lower=[0.11 0.29 1.6 4 4 4 4 3];
  %upper=[1 1 2 3 4 4 4 3.5];
  %errorbar(tspan, y, lower,upper,'LineStyle','none','MarkerFaceColor','yellow');
  %legend('Model fit Baseline Scenario', 'EKTEPN&Aristotle Data', 'Location', 'NorthWest')

  


% Display the fitted parameter, here, beta
  %disp('fitted parameter beta')
  %disp(fitted_parameter_beta)
  



%% That's it!
% If you want, you can double-check what value of infected prevalence you
% get with this fitted parameter for beta by plugging the value back into
% the system of equations and solving
% For this, you will need a time span and an initial condition
  %tspan = 1:0.01:60;
  %y0 = [4401.91 26.5709 3550.09 21.4291];

% Set the parameter that we fit above as beta
%beta=0.0346;% fitted_parameter_beta;

% Now solve the equation with this new fitted parameter beta
%[t,y] = ode45(@(t,y) mfit_eq_baseline_final_betafit(t,y,beta),tspan,y0);
%N=8000;
%prevalence_model_ = (y(:,2)+y(:,4))/N
% figure(1);
%plot(tspan,prevalence_model_ ,'--')
% Add a legend and axis labels
%legend('Model fit Baseline Scenario','Data', 'Location', 'NorthWest')%legend(' Model fit', 'Data',  'Location', 'NorthWest') %'Lower/Upper Bounds',
%xlabel('Year')
%ylabel('HIV Prevalence (%)_ RDS-weighted')
%ax = gca;
%ax.XTick = [1 13 25 37 49 51 55 58 60.2];%1 10/2012 0/12013 05/2013 08/2013 12/2013];
%ax.XTickLabel=[{'2009','2010','2011','2012','2013','', '','','2014'}];
%ax.XLim = [0 60.5];
%legend('Model fit Main Scenario', 'Model fit Baseline Scenario', 'Data', 'Location', 'NorthWest')
%
%hold off
 %tspan=[1 13 25 44 48 51 55 58];
%y=[0.6 0.8 8.1 14.2 16.1 16.2 13.5 12];
%scatter(tspan, y, 'k')
% Add a legend and axis labels
%legend(' Model fit', 'Data',  'Location', 'NorthWest') %'Lower/Upper Bounds',
%xlabel('Time')
%ylabel('Prevalence')
% Calculate the infected prevalence with this new fitted parameter beta
% Note that this is the same as before: Infected Prevalence =
% I/(SL+SH+I)note:it is the classical prevalence term
%N=10000;
%w = 0.42;
%u = 7.9;
%prevalence_model_ = (y(:,2)+y(:,5)+y(:,3)+y(:,6))/N;
%MATLAB FOR SOME REASON CALCULATES IT WRONGLY;art_model = (y(:,3)+y(:,6))/(y(:,2)+y(:,5))
%S=y(:,1)+y(:,4);
%A=(y(:,3)+y(:,6));
%I=(y(:,2)+y(:,5));
%art_model = A./I;
%T = table(fit_final)
%infected_prevalence_calculation_SI = y(:,3)./(y(:,1)+y(:,2)+y(:,3));
%INCIDENCE RATE/Baseline scenario
%I1=beta*(y(:,2)./N+w*y(:,3)./N);
%I2=u*beta*(y(:,5)./N+w*y(:,6)./N);
%incidence_rate=100*12*(I1*y(:,1).'+I2*y(:,4).')/(y(:,1)+y(:,4))';

%%betalow*infected_prevalence_calculation_SI*(y(:,1)+10*y(:,2))/(y(:,1)+y(:,2));

% Display and compare with what you expect - which we said was 0.11 (i.e. 11%)
  %disp('Infected prevalence using the fitted parameter')
  %disp([prevalence_model_final(401),prevalence_model_final(701),prevalence_model_final(1101),prevalence_model_final(1401)])
  %disp('Incidence using the fitted parameter')
  %disp(incidence_calculation_SI(end))

% Plot the time series
%h=[14.2 21.4 20.2 15.6 13.4];
%t=[212 210 203 198 194 178 168];
%scatter(h,t); hold on;
%y=-.0017*h+211.88;
%plot(h,y);
%scatter(tspan,h); hold on;
  %plot(tspan,100*prevalence_model_,'b')
  %ylim([0 40])
  %hold on
 %plot(1,14.2,'r*')
 %hold on
 %plot(5,16.1,'r*')
  %hold on
 %plot(8,16.2,'r*')
 %hold on
 %plot(12,13.5,'r*')
 % hold on
 %  plot(15,12.0,'r*')
%xlabel('Time(months)')
%ylabel('HIV prevalence(%)')
%legend('Model Prevalence','Data')
%set(gca,'XTick',[1 5 8 12 15])
%set(gca,'XTickLabel',{'Aug12';'Dec12';'Mar13';'Jun13';'Sep13'})
%   x1 =1 ;y1=14.2;
%  txt1='14.2';
%  text(x1,y1,txt1);
%  x2=5 ;y2=16.1;
%txt2='16.1';
%text(x2,y2,txt2)
%x3=8 ;y3=16.2;
%txt3='16.2';
%text(x3,y3,txt3)
%x4=12 ;y4=13.5;
%txt4='13.5';
%text(x4,y4,txt4)
%x5=15 ;y5=12.0;
%txt5='12.0';
%text(x5,y5,txt5)
%title('')

  %axis([0 15 9 12])
  %title('Infected Prevalence Over Time')
%plot(tspan,incidence_rate)
%x1 =1 ;y1=7.8;
%  txt1='7.8';
%  text(x1,y1,txt1);
%%  x2=5 ;y2=5.9;
%txt2='5.9';
%text(x2,y2,txt2)
%x3=8 ;y3=2.9;
%txt3='2.9';
%text(x3,y3,txt3)
%x4=13.5 ;y4=1.7;
%%txt4='1.7';
%text(x4,y4,txt4)


