%IN ORDER TO RUN THIS CODE, RUN FIRSTLY THIS FILE, WHICH WILL THEN CALL THE TWO OTHERS FILES(FUNCTION FILES)
clear all; clc;
%% Intervention Scenario:

% Provide initial values for beta

  p0=[0.0044,0.023 ,0.03]; 
  p_lb=[0,0,0];
  p_ub=[1, 1,1];
   
 
 iterations =1000%%200%500
%INSERT 95%CI'S FOR GREEK REITOX FOCAL POINT PREVALENCE(2010-2011)
 pd1 = makedist('Triangular','a',0.0029,'b',0.008,'c',0.0172);
 pd2 = makedist('Triangular','a',0.0627,'b',0.081,'c',0.102);
%INSERT 95%CI'S FOR ARISTOTLE PREVALENCE (RDS weighted estimates) 
 pd3 = makedist('Triangular','a',0.103,'b',0.142,'c',0.18);
 pd4 = makedist('Triangular','a',0.12,'b',0.161,'c',0.201);
 pd5 = makedist('Triangular','a',0.119,'b',0.162,'c',0.204);
 pd6 = makedist('Triangular','a',0.095,'b',0.135,'c',0.175);
%INSERT 95%CI'S FOR ARISTOTLE's FREQUENCY OF INJECTING(RDS weighted estimates)  
 pd8 = makedist('Triangular','a',0.394,'b',0.452,'c',0.51);
 pd9 = makedist('Triangular','a',0.162,'b',0.203,'c',0.243);
 pd10 = makedist('Triangular','a',0.167,'b',0.213,'c',0.259);
 pd11 = makedist('Triangular','a',0.147,'b',0.189,'c',0.23);
 pd12 = makedist('Triangular','a',0.152,'b',0.188,'c',0.224);
%ART Estimates FOR LOW RISK--> 0.0909,0212,0326,0348,0.348
pd13 = makedist('Triangular','a',0.04,'b',0.09,'c',0.18);
pd14 = makedist('Triangular','a',0.15,'b',0.21,'c',0.29);
pd15 = makedist('Triangular','a',0.25,'b',0.329,'c',0.41);
pd16 = makedist('Triangular','a',0.29,'b',0.375,'c',0.46);
pd17 = makedist('Triangular','a',0.25,'b',0.324,'c',0.41);
 %INSERT VARIABILITY FOR ART EFFICACY
pd18=makedist('Uniform','lower',0.25,'upper',0.75);

 rng('default');  % For reproducibility

for i=1:iterations
  
   r1(i)=random(pd1);
   r2(i)=random(pd2);
   r3(i)=random(pd3);
   r4(i)=random(pd4);
   r5(i)=random(pd5);
   r6(i)=random(pd6);
   r7(i)=random(pd7);
   %95%CI frequency of injecting -ARISTOTLE-RDS weighted estimates
   r8(i)=random(pd8);
   r9(i)=random(pd9);
   r10(i)=random(pd10);
   r11(i)=random(pd11);
   r12(i)=random(pd12);
   r13(i)=random(pd13);
   r14(i)=random(pd14);
   r15(i)=random(pd15);
   r16(i)=random(pd16);
   r17(i)=random(pd17);
   r18(i)=random(pd18);
  
end

num_param = size(p0,2);
results=zeros(iterations, num_param); %
options=optimset('disp','iter','LargeScale','off','TolFun',1.0e-10,'MaxIter',10000,'MaxFunEvals',10000);
options=optimset('disp','off');
 
%INSERT 95%CI'S FOR ARISTOTLE'S HIGH RISK PERCENTAGE FOR NEW INJECTORS (RDS weighted estimates)
z1 = 0.289+(0.615-0.289)*rand(1,iterations);  
z2 = 0.143+(0.421-0.143)*rand(1,iterations);
z3 = 0.122+(0.509-0.122)*rand(1,iterations);
z4 = 0.096+(0.261-0.096)*rand(1,iterations);
z5 = 0.109+(0.344-0.109)*rand(1,iterations);

%INSERT 95%CI'S FOR ARISTOTLE ADEQUATE SYRINGE (RESULTS FROM LINEAR
%REGRESSION MODEL)
nsp1 = 0.0568043+(0.0665792-0.0568043)*rand(1,iterations);  
nsp2 = 0.0636086+(0.0831584-0.0636086)*rand(1,iterations);
nsp3 = 0.070413+(0.0997376-0.070413)*rand(1,iterations);
nsp4 = 0.0772173+(0.1163168-0.0772173)*rand(1,iterations);
nsp5 = 0.0840216+(0.1328961-0.0840216)*rand(1,iterations);
nsp6 = 0.0908259+(0.1494753-0.0908259)*rand(1,iterations);
nsp7 = 0.0976303+(0.1660545-0.0976303)*rand(1,iterations);
nsp8 = 0.1044346+(0.1826337-0.1044346)*rand(1,iterations);
%Proportion with adequate syringe coverage in past month (95% CI) 
nsp9 = 0.1112389+(0.1992129-0.1112389)*rand(1,iterations);  
nsp10 = 0.1580151+(0.2523558-0.1580151)*rand(1,iterations);
nsp11 = 0.2329493+(0.3500733-0.2329493)*rand(1,iterations);
nsp12= 0.1084201+(0.1731946-0.1084201)*rand(1,iterations);
nsp13= 0.1676013+(0.2451149-0.1676013)*rand(1,iterations);


for i=1:iterations
    current_r1=r1(i);
    current_r2=r2(i);
    current_r3=r3(i);
    current_r4=r4(i);
    current_r5=r5(i);
    current_r6=r6(i);
    current_r7=r7(i);
    current_r8=r8(i);
    current_r9=r9(i);
    current_r10=r10(i);
    current_r11=r11(i);
    current_r12=r12(i);
    current_r13=r13(i);
    current_r14=r14(i);
    current_r15=r15(i);
    current_r16=r16(i);
    current_r17=r17(i); 
    current_r18=r18(i);
    current_z1=z1(i);
    current_z2=z2(i);
    current_z3=z3(i);
    current_z4=z4(i);
    current_z5=z5(i);
    current_nsp1=nsp1(i);
    current_nsp2=nsp2(i);
    current_nsp3=nsp3(i);
    current_nsp4=nsp4(i);
    current_nsp5=nsp5(i);
    current_nsp6=nsp6(i);
    current_nsp7=nsp7(i);
    current_nsp8=nsp8(i);
    current_nsp9=nsp9(i);
    current_nsp10=nsp10(i);
    current_nsp11=nsp11(i);
    current_nsp12=nsp12(i);
    current_nsp13=nsp13(i);
   
   
% Fit the parameter to the system of equations with this initial guess
    [fitted_p,resnorm,residual,exitflag,output]= lsqnonlin(@(p) acute_mdfit_final(p,current_r1,current_r2, current_r3,current_r4,current_r5,current_r6,current_r7,current_r8,current_r9,current_r10,current_r11,current_r12,current_r13,current_r14,current_r15,current_r16,current_r17,current_r18,current_z1,current_z2,current_z3,current_z4,current_z5,current_nsp1,current_nsp2,current_nsp3,current_nsp4,current_nsp5,current_nsp6,current_nsp7,current_nsp8,current_nsp9,current_nsp10,current_nsp11,current_nsp12,current_nsp13), p0,p_lb, p_ub,options);%fitted_p_lb, p_ub p 
fitted_p;
    results(i,:)=fitted_p;%matrix iX3 with rows the iterations &columns the parameters
    i
    resnorm ;
    A(i,:)=[i,resnorm];
    [M,I] = min(A);
    
 
 %%% Now solve the system of equations using the fitted_p that was just
 %%% determined in the previous step with LSQNONLIN
   param1 = fitted_p(1);
   param2 = fitted_p(2);
   param3 = fitted_p(3);

   p = [param1,param2,param3];
   
  [t,y] = ode45(@(t,y) acutemfit_eq_final(t,y,p,current_r18,current_z1,current_z2,current_z3,current_z4,current_z5,current_nsp1,current_nsp2,current_nsp3,current_nsp4,current_nsp5,current_nsp6,current_nsp7,current_nsp8,current_nsp9,current_nsp10,current_nsp11,current_nsp12,current_nsp13), [1:0.01:60], [4432.72 0 26.7569 0 3574.94 0 21.5791 0], options);

 
  N=8056;
  w =current_r18;%0.42;
  u=10;%7.9;
  %u = 7.9;
  q=(1/12)/12; 
  m=(0.0231)/12;%death rate per month from Mathers (Western Europe)
  r=26;%18;
  d=1/3;%0.6;%1/2;
%TRANSMISSION PER MONTH PERIOD
%lamda0=beta*((I0+w*A)/N)  ;
%lamda1=u*beta*(I1/N)   ;
%incidence_number=lamda0*(S0)+lamda1*(S1);
%incidence_rate=12*100*incidence_number/S;
%S0=y(1)
%I0=y(2)
%A=y(3)
%S1=y(4)
%I1=y(5)
 
  %FORCE OF INFECTION/LOW RISK
  
  lamda0(:,i)=fitted_p(1)*((r*y(:,2)+y(:,3)+w*y(:,4))/N);
  
  %FORCE OF INFECTION/HIGH RISK
  
  lamda1(:,i)=u*fitted_p(1)*((r*y(:,6)+y(:,7)+w*y(:,8))/N);
  
  %%NUMBER OF NEW INFECTIONS 
  P=(bsxfun(@times,lamda0,y(:,1))+(bsxfun(@times,lamda1,y(:,5))));%lamda0.*y(:,1)+lamda1.*y(:,4));
  S=(y(:,1)+y(:,5));
  %INCIDENCE RATE
  results_incidence_timeseries=bsxfun(@rdivide,100*12*P,S);%=100*12*P./S;
  
  
%INCIDENCE RATE PER TIMEPOINT
for j=1:5901
incid_prcj(j,:)=prctile(results_incidence_timeseries(j,:),[2.5 50 97.5]);
%incid_prcj95(j,:)=prctile(results_incidence_timeseries(j,:),[2.5 50 95]);
%incid_prcj90(j,:)=prctile(results_incidence_timeseries(j,:),[2.5 50 90]);
end
%INCIDENCE RATE PER TIMEPOINT/97.5 PERCENTILES
  
  incidence_prc0=prctile(results_incidence_timeseries(1,:),[2.5 50 97.5]);
  incidence_prc1=prctile(results_incidence_timeseries(1201,:),[2.5 50 97.5]);
  incidence_prc2=prctile(results_incidence_timeseries(2401,:),[2.5 50 97.5]);
  incidence_prc3=prctile(results_incidence_timeseries(4401,:),[2.5 50 97.5]);
  incidence_prc4=prctile(results_incidence_timeseries(4701,:),[2.5 50 97.5]);
  incidence_prc5=prctile(results_incidence_timeseries(5001,:),[2.5 50 97.5]);
  incidence_prc6=prctile(results_incidence_timeseries(5401,:),[2.5 50 97.5]);
  incidence_prc7=prctile(results_incidence_timeseries(5701,:),[2.5 50 97.5]);
  incidence_prc8=prctile(results_incidence_timeseries(5901,:),[2.5 50 97.5]);
  incid_table=[incidence_prc0;incidence_prc1;incidence_prc2;incidence_prc3;incidence_prc4;incidence_prc5;incidence_prc6;incidence_prc7;incidence_prc8;];
  
  
  %INCIDENCE RATE
  %results_incidence_timeseries=bsxfun(@rdivide,P,S');
  
  %PREVALENCE TIMESERIES
  results_prevalence_timeseries(:,i) = 100*(y(:,2)+y(:,3)+y(:,6)+y(:,7))./N;%sum(y(:,:),2);
  results_prevalenceA_timeseries(:,i) = 100*(y(:,2)+y(:,3)+y(:,6)+y(:,7)+y(:,4)+y(:,8))./N;
  results_altprevalence_timeseries(:,i) = 100*(y(:,2)+y(:,3)+y(:,6)+y(:,7))./(N-y(:,4)-y(:,8));%sum(y(:,:),2);
  %CALCULATE JUST THE PREVALENCE THAT COMES FROM THE BEST FITTED PARAMETERS
  results_frequency_timeseries(:,i) = 100*(y(:,5)+y(:,6)+y(:,7)+y(:,8))./N;%sum(y(:,:),2);
 %FREQUENCY PERCENTILES AT AVAILABLE DATA TIMEPOINTS
 frequency_prc4=prctile(results_frequency_timeseries(4701,:),[2.5 50 97.5]);
 frequency_prc5=prctile(results_frequency_timeseries(5001,:),[2.5 50 97.5]);
 frequency_prc6=prctile(results_frequency_timeseries(5401,:),[2.5 50 97.5]);
 frequency_prc7=prctile(results_frequency_timeseries(5701,:),[2.5 50 97.5]);
 frequency_prc8=prctile(results_frequency_timeseries(5901,:),[2.5 50 97.5]);
 freq_table=[frequency_prc4;frequency_prc5;frequency_prc6;frequency_prc7;frequency_prc8;];
  
 
for j=1:5901
freq_prcj(j,:)=prctile(results_frequency_timeseries(j,:),[2.5 50 97.5]);
end
results;

%PREVALENCE PERCENTILES AT AVAILABLE DATA TIMEPOINTS

prev_prc1=prctile(results_prevalence_timeseries(1201,:),[2.5 50 97.5]);
prev_prc2=prctile(results_prevalence_timeseries(2401,:),[2.5 50 97.5]);
prev_prc3=prctile(results_prevalence_timeseries(4401,:),[2.5 50 97.5]);
prev_prc4=prctile(results_prevalence_timeseries(4701,:),[2.5 50 97.5]);
prev_prc5=prctile(results_prevalence_timeseries(5001,:),[2.5 50 97.5]);
prev_prc6=prctile(results_prevalence_timeseries(5401,:),[2.5 50 97.5]);
prev_prc7=prctile(results_prevalence_timeseries(5701,:),[2.5 50 97.5]);
prev_prc8=prctile(results_prevalence_timeseries(5901,:),[2.5 50 97.5]);
prev_table=[prev_prc1;prev_prc2;prev_prc3;prev_prc4;prev_prc5;prev_prc6;prev_prc7;prev_prc8;];

for j=1:5901
prev_prcj(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 97.5]); 
end
p1_prc = prctile(results(:,1),[2.5 50 97.5]) ;
p2_prc = prctile(results(:,2),[2.5 50 97.5]) ;
p3_prc = prctile(results(:,3),[2.5 50 97.5]) ;

 figure(1);
 plot(t,results_prevalence_timeseries)
 figure(2);
 plot(t,results_incidence_timeseries)
 
  %CALCULATE CUMULATIVE NUMBER OF NEW INFECTIONS
  %take the cases calculated in each month of each year
  IN_9=TP_prcj([1,101,201,301,401,501,601,701,801,901,1001,1101],:);
  %add them up
  S_9=sum(IN_9);%#55.2503 VS EKTEPN 2009 (N=
  %MODEL PREDICTIONS 2010
  IN_10=TP_prcj([1201,1301,1401,1501,1601,1701,1801,1901,2001,2101,2201,2301],:);
  S_10=sum(IN_10);%#161.1281 VS EKTEPN 2010 (N=29)
  %MODEL PREDICTIONS 2011
  IN_11=TP_prcj([2401,2501,2601,2701,2801,2901,3001,3101,3201,3301,3401,3501],:);
  S_11=sum(IN_11);%#410.1383 VS EKTEPN 2011 (N=319)
  %MODEL PREDICTIONS 2012
  IN_12=TP_prcj([3601,3701,3801,3901,4001,4101,4201,4301,4401,4501,4601,4701],:);
  S_12=sum(IN_12);%#570.7239 VS EKTEPN 2012 (N=523)
   %MODEL PREDICTIONS 2013
  IN_13=TP_prcj([4801,4901,5001,5101,5201,5301,5401,5501,5601,5701,5801,5901],:);
  S_13=sum(IN_13);%#301.7750 VS EKTEPN 2012 (N=270)
   %CUMULATIVE NUMBER FOR EACH YEAR
  CN=[S_9;S_9+S_10;S_9+S_10+S_11;S_9+S_10+S_11+S_12;S_9+S_10+S_11+S_12+S_13];
   
 
