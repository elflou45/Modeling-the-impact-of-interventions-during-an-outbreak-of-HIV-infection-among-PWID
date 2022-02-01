clear all; clc;

%% Intervention Scenario:Adequate Syringe&HAART1&Normal Prevalence(-->because normal prevalence fits better to data)

% Guess what beta might be. Note: lb = lower bound, ub = upper bound
%p=[beta k gamma]

  p0=[0.0044,0.023 ,0.03]; 
  p_lb=[0,0,0];
  p_ub=[1, 1,1];
   
 
 iterations =1000%%200%500
%INSERT 95%CI'S FOR EKTEPN PREVALENCE(2010-2011)
 pd1 = makedist('Triangular','a',0.0029,'b',0.008,'c',0.0172);
 pd2 = makedist('Triangular','a',0.0627,'b',0.081,'c',0.102);
%INSERT 95%CI'S FOR ARISTOTLE PREVALENCE (RDS weighted estimates) 
 pd3 = makedist('Triangular','a',0.103,'b',0.142,'c',0.18);
 pd4 = makedist('Triangular','a',0.12,'b',0.161,'c',0.201);%0.201
 pd5 = makedist('Triangular','a',0.119,'b',0.162,'c',0.204);%0.204
 pd6 = makedist('Triangular','a',0.095,'b',0.135,'c',0.175);%pd6 = makedist('Triangular','a',0.095,'b',0.135,'c',0.175);%  pd6 = makedist('Triangular','a',0.152,'b',0.165,'c',0.178);
 pd7 = makedist('Triangular','a',0.086,'b',0.12,'c',0.155);%pd7 = makedist('Triangular','a',0.152,'b',0.165,'c',0.178);
%INSERT 95%CI'S FOR ARISTOTLE's FREQUENCY OF INJECTING(RDS weighted estimates)  
 pd8 = makedist('Triangular','a',0.394,'b',0.452,'c',0.51);
 pd9 = makedist('Triangular','a',0.162,'b',0.203,'c',0.243);
 pd10 = makedist('Triangular','a',0.167,'b',0.213,'c',0.259);
 pd11 = makedist('Triangular','a',0.147,'b',0.189,'c',0.23);
 pd12 = makedist('Triangular','a',0.152,'b',0.188,'c',0.224);
%INSERT 95%CI'S FOR ARISTOTLE's HAART (nonRDS weighted estimates-SYPSA JID 2017) 
 %pd13 = makedist('Triangular','a',0.003,'b',0.015,'c',0.044);
 %pd14 = makedist('Triangular','a',0.087,'b',0.125,'c',0.17);
 %pd15 = makedist('Triangular','a',0.128,'b',0.168,'c',0.215);
 %pd16 = makedist('Triangular','a',0.16,'b',0.2,'c',0.247);%pd16 = makedist('Triangular','a',0.128,'b',0.168,'c',0.215);pd16 = makedist('Triangular','a',0.1283106,'b',0.168,'c',0.2147546);%pd16 = makedist('Triangular','a',0.160,'b',0.201,'c',0.2470);
 %pd17 = makedist('Triangular','a',0.202,'b',0.245,'c',0.292);%;%pd17 = makedist('Triangular','a',0.128,'b',0.168,'c',0.215)pd17 = makedist('Triangular','a',0.1283106,'b',0.168,'c',0.2147546);%pd17 = makedist('Triangular','a',0.2015001,'b',0.245,'c',0.2917937);%foralternative_finalmodel:%pd17=makedist('Triangular','a',0.1595492,'b',0.201,'c',0.2468547);%
 %INSERT 95%CI'S FOR ARISTOTLE's of ART-self-reported -RDS weighted
 %pd13 = makedist('Triangular','a',0.0171109,'b',0.0416777,'c',0.0979992);
 %pd14 = makedist('Triangular','a',0.1057056,'b',0.1975498,'c',0.338949);
 %pd15 = makedist('Triangular','a',0.1606379,'b',0.2628129,'c',0.3990776);
 %pd16 = makedist('Triangular','a',0.2288318,'b',0.3654703,'c',0.5278514);
 %pd17 = makedist('Triangular','a',0.14476,'b',0.2515245,'c',0.4001857);
 %ART Estimates FOR LOW RISK--> 0.0909,0212,0326,0348,0.348
pd13 = makedist('Triangular','a',0.04,'b',0.09,'c',0.18);
pd14 = makedist('Triangular','a',0.15,'b',0.21,'c',0.29);
pd15 = makedist('Triangular','a',0.25,'b',0.329,'c',0.41);
pd16 = makedist('Triangular','a',0.29,'b',0.375,'c',0.46);
pd17 = makedist('Triangular','a',0.25,'b',0.324,'c',0.41);
 %INSERT VARIABILITY FOR ART EFFICACY
pd18=makedist('Uniform','lower',0.25,'upper',0.75);%SENSITIVITY SCENARIO%pd18=makedist('Uniform','lower',0.25,'upper',0.75);

 rng('default');  % For reproducibility

for i=1:iterations
   %%95%CI epipolasmou ALL PARTICIPANTS-EKTEPN 
   r1(i)=random(pd1);%0.0029+(0.0172-0.0029)*rand;r1=0.008;%
   r2(i)=random(pd2);%0.0627+(0.102-0.0627)*rand;%%*rand;r2=0.081;%%random(pd);%0.008+(0.142-0.008)*rand;%random(pd);
   %%95%CI epipolasmou ALL PARTICIPANTS-ARISTOTLE-RDS weighted estimates
   r3(i)=random(pd3);%0.103+(0.18-0.103)*rand;r3=0.142;%
   r4(i)=random(pd4);%0.12+(0.201-0.12)*rand;r4=0.161;%%=random(pd1);%random(pd);% % %0.0029+(0.0172-0.0029)*rand;random numbers from the (0.29-1.72)space that represents %prevalence from year2009 EKETEPN source
   r5(i)=random(pd5);%0.119+(0.204-0.119)*rand;r5=0.162;%
   r6(i)=random(pd6);%0.095+(0.175-0.095)*rand;r6=0.135;%
   r7(i)=random(pd7);%0.086+(0.155-0.086)*rand;r7=0.12;%
   %95%CI frequency of injecting -ARISTOTLE-RDS weighted estimates
   r8(i)=random(pd8);%0.394+(0.51-0.394)*rand;r8=0.452;%
   r9(i)=random(pd9);%0.162+(0.243-0.162)*rand;r9=0.203;%
   r10(i)=random(pd10);%0.167+(0.259-0.167)*rand;r10=0.213;%
   r11(i)=random(pd11);%0.147+(0.23-0.147)*rand;r11=0.189;%
   r12(i)=random(pd12);%0.152+(0.224-0.152)*rand;r12=0.188;%
 %Main scenario:95%CI percent of HAART from Sypsa Rapid Decline JID2017 -nonRDS weighted estimates /
   r13(i)=random(pd13);%r13=0.015;%0.0031356+(0.0436384-0.0031356)*rand;
   r14(i)=random(pd14);%r14=0.125;%0.0872919+(0.1704193-0.0872919)*rand;
   r15(i)=random(pd15);%r15=0.168%0.1283106+(0.2147546-0.1283106)*rand;
   r16(i)=random(pd16);%r16=0.168;%0.1595492+(0.2468547-0.1595492)*rand;
   r17(i)=random(pd17);%r17=0.168;%0.2015001+(0.2917937-0.2015001)*rand;
   r18(i)=random(pd18);
   %Alternative scenario (for sensitivity analysis): %95%CI percent of ART-self-reported -RDS weighted estimates 
  %r13(i)=0.0171109+(0.0979992-0.0171109)*rand;
  %r14(i)=0.1057056+(0.338949-0.1057056)*rand;
  %r15(i)=0.1606379+(0.3990776-0.1606379)*rand;
  %r16(i)=0.2288318+(0.5278514-0.2288318)*rand;
  %r17(i)=0.14476+(0.4001857-0.14476)*rand;
end
%figure; hold on
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


%INSERT 95%CI'S FOR ARISTOTLE RECEIVED SYRINGES (RESULTS FROM LINEAR
%REGRESSION MODEL)
%nsp1 = 0.0852+(0.0987-0.0852)*rand(1,iterations);  
%nsp2 = 0.1204+(0.147-0.1204)*rand(1,iterations);
%nsp3 = 0.156+(0.196-0.156)*rand(1,iterations);
%nsp4 = 0.191+(0.245-0.191)*rand(1,iterations);
%nsp5 = 0.226+(0.293-0.226)*rand(1,iterations);
%nsp6 = 0.261+(0.342-0.261)*rand(1,iterations);
%nsp7 = 0.297+(0.391-0.297)*rand(1,iterations);
%nsp8 = 0.332+(0.439-0.332)*rand(1,iterations);
%INSERT 95%CI'S FOR ARISTOTLE RECEIVED SYRINGES (RDS weighted estimates)
%nsp9 = 0.367+(0.488-0.367)*rand(1,iterations);  
%nsp10 = 0.275+(0.378-0.275)*rand(1,iterations);
%nsp11 = 0.373+(0.498-0.373)*rand(1,iterations);
%nsp12= 0.263+(0.37-0.263)*rand(1,iterations);
%nsp13= 0.277+(0.368-0.277)*rand(1,iterations);

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
%INSERT 95%CI'S FOR ARISTOTLE ADEQUATE SYRINGE (RDS weighted estimates)
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
   
% This means that nothing is output to the display after the fit. Can be
% changed if necessary.
%options=optimset('display','off');
   
% Fit the parameter to the system of equations with this initial guess
    [fitted_p,resnorm,residual,exitflag,output]= lsqnonlin(@(p) acute_mdfit_final(p,current_r1,current_r2, current_r3,current_r4,current_r5,current_r6,current_r7,current_r8,current_r9,current_r10,current_r11,current_r12,current_r13,current_r14,current_r15,current_r16,current_r17,current_r18,current_z1,current_z2,current_z3,current_z4,current_z5,current_nsp1,current_nsp2,current_nsp3,current_nsp4,current_nsp5,current_nsp6,current_nsp7,current_nsp8,current_nsp9,current_nsp10,current_nsp11,current_nsp12,current_nsp13), p0,p_lb, p_ub,options);%fitted_p_lb, p_ub p 
fitted_p;
    results(i,:)=fitted_p;%matrix iX3 with rows the iterations &columns the parameters
    i
    resnorm ;
    A(i,:)=[i,resnorm];
    [M,I] = min(A);
    %KANW COPY-PASTE TO:R=[I(2),M(2)]
    %META PAS STA RESULTS KAI VRISKEIS BETA, KAPPA&GAMMA KOITAZONTAS TO I(2) STHN VARIABLE RESULTS
    %figure(1);
    %labels=cellstr(num2str(i));
   %plot(i,resnorm,'r*')
   %text(i,resnorm,labels,'HorizontalAlignment','right')
    
 %%%
 %%% 23Nov2018_AL:
 %%% Now solve the system of equations using the fitted_p that was just
 %%% determined in the previous step with LSQNONLIN
   param1 = fitted_p(1);
   param2 = fitted_p(2);
   param3 = fitted_p(3);
 %%%
 %%% 23Nov2018_AL:
 %%% Note: In order to use the equations file 'mfit_eq_final_g', you will
 %%% have to make sure the input arguments are in the same format
   p = [param1,param2,param3];
   
  [t,y] = ode45(@(t,y) acutemfit_eq_final(t,y,p,current_r18,current_z1,current_z2,current_z3,current_z4,current_z5,current_nsp1,current_nsp2,current_nsp3,current_nsp4,current_nsp5,current_nsp6,current_nsp7,current_nsp8,current_nsp9,current_nsp10,current_nsp11,current_nsp12,current_nsp13), [1:0.01:60], [4432.72 0 26.7569 0 3574.94 0 21.5791 0], options);

 %%%
 %%% 23Nov2018_AL:
 %%% In this main file, you have not defined what is the variable 'N'
 %%% In this case, 'N' is the total population at timepoint 1201
 
 %ELINA:prevalence_model_ = (y(:,2)+y(:,5))/N
 %PREVALENCES FOR THE TIMEPOINTS THAT I HAVE DATA:
  %results1_prevalence(i) = 100*(y(1201,2)+y(1201,5))/sum(y(1201,:),2);
  %results2_prevalence(i) = 100*(y(2401,2)+y(2401,5))/sum(y(2401,:),2);
  %results3_prevalence(i) = 100*(y(4401,2)+y(4401,5))/sum(y(4401,:),2);
  %results4_prevalence(i) = 100*(y(4701,2)+y(4701,5))/sum(y(4701,:),2);
  %results5_prevalence(i) = 100*(y(5001,2)+y(5001,5))/sum(y(5001,:),2);
  %results6_prevalence(i) = 100*(y(5401,2)+y(5401,5))/sum(y(5401,:),2);
  %results7_prevalence(i) = 100*(y(5701,2)+y(5701,5))/sum(y(5701,:),2);
  N=8056;
  w =current_r18;%0.42;
  u=10;%7.9;
  %u = 7.9;
  q=(1/12)/12; %SENSITIVITY SCENARIO
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
  %lamda01(i)=fitted_p(1)*((r*y(1201,2)+w*y(1201,3))/N);
  %lamda02(i)=fitted_p(1)*((y(2401,2)+w*y(2401,3))/N);
  %lamda03(i)=fitted_p(1)*((y(4401,2)+w*y(4401,3))/N);
  %lamda04(i)=fitted_p(1)*((y(4701,2)+w*y(4701,3))/N);
  %lamda05(i)=fitted_p(1)*((y(5001,2)+w*y(5001,3))/N);
  %lamda06(i)=fitted_p(1)*((y(5401,2)+w*y(5401,3))/N);
  %lamda07(i)=fitted_p(1)*((y(5701,2)+w*y(5701,3))/N);
  
  lamda0(:,i)=fitted_p(1)*((r*y(:,2)+y(:,3)+w*y(:,4))/N);
  
  %FORCE OF INFECTION/HIGH RISK
  %lamda11(i)=u*fitted_p(1)*(y(1201,5)/N);
  %lamda12(i)=u*fitted_p(1)*(y(2401,5)/N);
  %lamda13(i)=u*fitted_p(1)*(y(4401,5)/N);
  %lamda14(i)=u*fitted_p(1)*(y(4701,5)/N);
  %lamda15(i)=u*fitted_p(1)*(y(5001,5)/N);
  %lamda16(i)=u*fitted_p(1)*(y(5401,5)/N);
  %lamda17(i)=u*fitted_p(1)*(y(5701,5)/N);
  
  lamda1(:,i)=u*fitted_p(1)*((r*y(:,6)+y(:,7)+w*y(:,8))/N);
  
  %%Incidence_number 
  P=(bsxfun(@times,lamda0,y(:,1))+(bsxfun(@times,lamda1,y(:,5))));%lamda0.*y(:,1)+lamda1.*y(:,4));
  S=(y(:,1)+y(:,5));
  %INCIDENCE RATE
  results_incidence_timeseries=bsxfun(@rdivide,100*12*P,S);%=100*12*P./S;
  
  
%INCIDENCE RATE PER TIMEPOINT
  %results1_incidencerate(i) = 100*12*(lamda01(i)*y(1201,1)+lamda11(i)*y(1201,4))./(y(1201,1)+y(1201,4));
  %results2_incidencerate(i) = 100*12*(lamda02(i)*y(2401,1)+lamda12(i)*y(2401,4))./(y(2401,1)+y(2401,4));
  %results3_incidencerate(i) = 100*12*(lamda03(i)*y(4401,1)+lamda13(i)*y(4401,4))./(y(4401,1)+y(4401,4));
  %results4_incidencerate(i) = 100*12*(lamda04(i)*y(4701,1)+lamda14(i)*y(4701,4))./(y(4701,1)+y(4701,4));
  %results5_incidencerate(i) = 100*12*(lamda05(i)*y(5001,1)+lamda15(i)*y(5001,4))./(y(5001,1)+y(5001,4));
  %results6_incidencerate(i) = 100*12*(lamda06(i)*y(5401,1)+lamda16(i)*y(5401,4))./(y(5401,1)+y(5401,4));
  %results7_incidencerate(i) = 100*12*(lamda07(i)*y(5701,1)+lamda17(i)*y(5701,4))./(y(5701,1)+y(5701,4));
  
  
  %ESTIMATE 2.5,MEDIAN,7.5 INCIDENCE after the running-i doit after running this code but(maybe it can be done
%on the same code Ihaven;t tried it!
for j=1:5901
incid_prcj(j,:)=prctile(results_incidence_timeseries(j,:),[2.5 50 97.5]);
%incid_prcj95(j,:)=prctile(results_incidence_timeseries(j,:),[2.5 50 95]);
%incid_prcj90(j,:)=prctile(results_incidence_timeseries(j,:),[2.5 50 90]);
end
%t1=1:5901;
%plot(t1,incid_prcj)
%title ('Model fit Main Scenario')
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
  
   %INCIDENCE RATE PER TIMEPOINT/95 PERCENTILES
 %incidence_prc0_95=prctile(results_incidence_timeseries(1,:),[2.5 50 95]);
 %incidence_prc1_95=prctile(results_incidence_timeseries(1201,:),[2.5 50 95]);
 %incidence_prc2_95=prctile(results_incidence_timeseries(2401,:),[2.5 50 95]);
 %incidence_prc3_95=prctile(results_incidence_timeseries(4401,:),[2.5 50 95]);
 %incidence_prc4_95=prctile(results_incidence_timeseries(4701,:),[2.5 50 95]);
 %incidence_prc5_95=prctile(results_incidence_timeseries(5001,:),[2.5 50 95]);
 %incidence_prc6_95=prctile(results_incidence_timeseries(5401,:),[2.5 50 95]);
 %incidence_prc7_95=prctile(results_incidence_timeseries(5701,:),[2.5 50 95]);
 %incidence_prc8_95=prctile(results_incidence_timeseries(5901,:),[2.5 50 95]);
 %incid_table_95=[incidence_prc0_95;incidence_prc1_95;incidence_prc2_95;incidence_prc3_95;incidence_prc4_95;incidence_prc5_95;incidence_prc6_95;incidence_prc8_95;];  
   
 %INCIDENCE RATE PER TIMEPOINT/90 PERCENTILES
 %incidence_prc0_90=prctile(results_incidence_timeseries(1,:),[2.5 50 90]);
 %incidence_prc1_90=prctile(results_incidence_timeseries(1201,:),[2.5 50 90]);
 %incidence_prc2_90=prctile(results_incidence_timeseries(2401,:),[2.5 50 90]);
 %incidence_prc3_90=prctile(results_incidence_timeseries(4401,:),[2.5 50 90]);
 %incidence_prc4_90=prctile(results_incidence_timeseries(4701,:),[2.5 50 90]);
 %incidence_prc5_90=prctile(results_incidence_timeseries(5001,:),[2.5 50 90]);
 %incidence_prc6_90=prctile(results_incidence_timeseries(5401,:),[2.5 50 90]);
 %incidence_prc7_90=prctile(results_incidence_timeseries(5701,:),[2.5 50 90]);
 %incidence_prc8_90=prctile(results_incidence_timeseries(5901,:),[2.5 50 90]);
 %incid_table_90=[incidence_prc0_90;incidence_prc1_90;incidence_prc2_90;incidence_prc3_90;incidence_prc4_90;incidence_prc5_90;incidence_prc6_90;incidence_prc8_90;];  
   
  %INCIDENCE RATE
  %results_incidence_timeseries(:,i) = 100*12*(lamda0*S0+lamda1*S1)/S;
%%%ORIGINAL  P=100*12*(lamda0'*y(:,1)+lamda1'*y(:,4));
%%%ORIGINAL  S=(y(:,1)+y(:,4));
%%%ORIGINAL  results_incidence_timeseries=bsxfun(@rdivide,P,S');
%%%
%%% 05DEC2018_AL: Instead of matrix multiplication using a dot product, we
%%% should do element-wise multiplcation, i.e. multiply element1 with
%%% element1 and put that in the first spot of the new vector
%%%   ---> Note that the 'bsxfun' is the same as element-wise
%%%   ---> So, for example, ./ is the same as bsxfun(@rdivide,P,S)
  %P=100*12*(lamda0.*y(:,1)+lamda1.*y(:,4));
  %S=(y(:,1)+y(:,4));
  %results_incidence_timeseries=P./S;
  
  
 %INCIDENCE RATE
  %results_incidence_timeseries(:,i) = 100*12*(lamda0*S0+lamda1*S1)/S;
  %WRONG CALCULATED-TOO BIG
  %I_N=lamda0'*y(:,1)+lamda1'*y(:,4);
  %P=100*12*(lamda0'*y(:,1)+lamda1'*y(:,4));
  %RIGHT CALCULATED
  %S=(y(:,1)+y(:,4));
  %results_incidence_timeseries=bsxfun(@rdivide,P,S');
  
  %R0_LOW RISK GROUP
  R0l(i)=fitted_p(1)/(m+q);
  R0_prc = prctile(R0l,[2.5 50 97.5]) ;
  
  %R0_HIGH RISK GROUP
  R0h(i)=u*fitted_p(1)/(m+q);
  R0h_prc = prctile(R0h,[2.5 50 97.5]) ;
  %p1h_prc=u*p1_prc;
  %R0h2_prc =p1h_prc/(m+q);
  %Re_LOW RISK GROUP
  %Rel(:,i)=R0l*y(:,1)/N;
  %Re_HIGH RISK GROUP
  %Rel(:,i)=R0h*y(:,4)/N;
  
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
  Rel_table=[Rel_prc0;Rel_prc1;Rel_prc2;Rel_prc3;Rel_prc4;Rel_prc5;Rel_prc6;Rel_prc8;];
  %RE_HIGH RISK GROUP FOR THE TIMEPOINTS OF DATA
  Reh_0(i)=R0h(i)*y(1,5)/N;
  Reh_1(i)=R0h(i)*y(1201,5)/N;
  Reh_2(i)=R0h(i)*y(2401,5)/N;
  Reh_3(i)=R0h(i)*y(4401,5)/N;
  Reh_4(i)=R0h(i)*y(4701,5)/N;
  Reh_5(i)=R0h(i)*y(5001,5)/N;
  Reh_6(i)=R0h(i)*y(5401,5)/N;
  Reh_7(i)=R0h(i)*y(5701,5)/N;
  Reh_8(i)=R0h(i)*y(5901,5)/N;
  
  Reh_prc0=prctile(Reh_0,[2.5 50 97.5]);
  Reh_prc1=prctile(Reh_1,[2.5 50 97.5]);
  Reh_prc2=prctile(Reh_2,[2.5 50 97.5]);
  Reh_prc3=prctile(Reh_3,[2.5 50 97.5]);
  Reh_prc4=prctile(Reh_4,[2.5 50 97.5]);
  Reh_prc5=prctile(Reh_5,[2.5 50 97.5]);
  Reh_prc6=prctile(Reh_6,[2.5 50 97.5]);
  Reh_prc7=prctile(Reh_7,[2.5 50 97.5]);
  Reh_prc8=prctile(Reh_8,[2.5 50 97.5]);
  Reh_table=[Reh_prc0;Reh_prc1;Reh_prc2;Reh_prc3;Reh_prc4;Reh_prc5;Reh_prc6;Reh_prc8;];
 
  
 
 %%% 23Nov2018_AL:
  %%% It might be a good idea to plot the timeseries of the solved system of
 %%% equations with each fitted_p over time, so I will save the whole
 %%% timeseries for prevalence and we will plot it below outside the FOR
 %%% loop
 %%% Note: Here we are dividing vectors, so you need to use ./ instead of
 %%%       using just /
  results_prevalence_timeseries(:,i) = 100*(y(:,2)+y(:,3)+y(:,6)+y(:,7))./N;%sum(y(:,:),2);
  results_prevalenceA_timeseries(:,i) = 100*(y(:,2)+y(:,3)+y(:,6)+y(:,7)+y(:,4)+y(:,8))./N;
  results_altprevalence_timeseries(:,i) = 100*(y(:,2)+y(:,3)+y(:,6)+y(:,7))./(N-y(:,4)-y(:,8));%sum(y(:,:),2);
  %CALCULATE JUST THE PREVALENCE THAT COMES FROM THE BEST FITTED PARAMETERS
  %F_results_prevalence_timeseries(:,536) = 100*(y(:,2)+y(:,5))./sum(y(:,:),2);
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
%freq_prcj95(j,:)=prctile(results_frequency_timeseries(j,:),[2.5 50 95]);
%freq_prcj90(j,:)=prctile(results_frequency_timeseries(j,:),[2.5 50 90]);
end

%RE_TOTAL FOR THE TIMEPOINTS OF DATA
 %Re_total_prc4=Reh_prc4*frequency_prc4+Rel_prc4*(1-frequency_prc4);
 %Re_total_prc5=Reh_prc5*frequency_prc5+Rel_prc5*(1-frequency_prc5);
 %Re_total_prc6=Reh_prc6*frequency_prc6+Rel_prc6*(1-frequency_prc6);
 %Re_total_prc7=Reh_prc7*frequency_prc7+Rel_prc7*(1-frequency_prc7);
 %Re_total_prc8=Reh_prc8*frequency_prc8+Rel_prc8*(1-frequency_prc8);
 


 results_therapylow_timeseries(:,i) = 100*(y(:,4)./(y(:,2)+y(:,3)));
 
 
 %THERAPY PERCENTILES AT AVAILABLE DATA TIMEPOINTS
 therapyl_prc4=prctile(results_therapylow_timeseries(4701,:),[2.5 50 97.5]);
 therapyl_prc5=prctile(results_therapylow_timeseries(5001,:),[2.5 50 97.5]);
 therapyl_prc6=prctile(results_therapylow_timeseries(5401,:),[2.5 50 97.5]);
 therapyl_prc7=prctile(results_therapylow_timeseries(5701,:),[2.5 50 97.5]);
 therapyl_prc8=prctile(results_therapylow_timeseries(5901,:),[2.5 50 97.5]);
 therapyl_table=[therapyl_prc4;therapyl_prc5;therapyl_prc6;therapyl_prc7;therapyl_prc8;];
  
 
 for j=1:5901
therl_prcj(j,:)=prctile(results_therapylow_timeseries(j,:),[2.5 50 97.5]);
%ther_prcj95(j,:)=prctile(results_therapy_timeseries(j,:),[2.5 50 95]);
%ther_prcj90(j,:)=prctile(results_therapy_timeseries(j,:),[2.5 50 90]);
end
  %T= y(:,:);
 
  
%AL    output.message
    
end
%p_prc = prctile(p_values,[2(.5 50 97.5]) ;
results;
%results1_prevalence;
%results2_prevalence;
%results3_prevalence;
%results4_prevalence;
%results5_prevalence;
%results6_prevalence;
%results7_prevalence;

%PREVALENCE PERCENTILES AT AVAILABLE DATA TIMEPOINTS
%prev_prc0=0.006;
prev_prc1=prctile(results_prevalence_timeseries(1201,:),[2.5 50 97.5]);
prev_prc2=prctile(results_prevalence_timeseries(2401,:),[2.5 50 97.5]);
prev_prc3=prctile(results_prevalence_timeseries(4401,:),[2.5 50 97.5]);
prev_prc4=prctile(results_prevalence_timeseries(4701,:),[2.5 50 97.5]);
prev_prc5=prctile(results_prevalence_timeseries(5001,:),[2.5 50 97.5]);
prev_prc6=prctile(results_prevalence_timeseries(5401,:),[2.5 50 97.5]);
prev_prc7=prctile(results_prevalence_timeseries(5701,:),[2.5 50 97.5]);
prev_prc8=prctile(results_prevalence_timeseries(5901,:),[2.5 50 97.5]);
prev_table=[prev_prc1;prev_prc2;prev_prc3;prev_prc4;prev_prc5;prev_prc6;prev_prc7;prev_prc8;];

%ALT_PREVALENCE PERCENTILES AT AVAILABLE DATA TIMEPOINTS-->NO A IN
%PARANOMASTIS OR ARITHMHTHS
altprev_prc1=prctile(results_altprevalence_timeseries(1201,:),[2.5 50 97.5]);
altprev_prc2=prctile(results_altprevalence_timeseries(2401,:),[2.5 50 97.5]);
altprev_prc3=prctile(results_altprevalence_timeseries(4401,:),[2.5 50 97.5]);
altprev_prc4=prctile(results_altprevalence_timeseries(4701,:),[2.5 50 97.5]);
altprev_prc5=prctile(results_altprevalence_timeseries(5001,:),[2.5 50 97.5]);
altprev_prc6=prctile(results_altprevalence_timeseries(5401,:),[2.5 50 97.5]);
altprev_prc7=prctile(results_altprevalence_timeseries(5701,:),[2.5 50 97.5]);
altprev_prc8=prctile(results_altprevalence_timeseries(5901,:),[2.5 50 97.5]);
altprev_table=[altprev_prc1;altprev_prc2;altprev_prc3;altprev_prc4;altprev_prc5;altprev_prc6;altprev_prc7;altprev_prc8;];
for j=1:5901
altprev_prcj(j,:)=prctile(results_altprevalence_timeseries(j,:),[2.5 50 97.5]); 
%prev_prcj95(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 95]); 
%prev_prcj90(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 90]); 
end
%ESTIMATE 2.5,MEDIAN,7.5 PREVALENCE after the running-i doit after running this code but(maybe it can be done
%on the same code Ihaven;t tried it!
for j=1:5901
prev_prcj(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 97.5]); 
%prev_prcj95(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 95]); 
%prev_prcj90(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 90]); 
end
for j=1:5901
prevA_prcj(j,:)=prctile(results_prevalenceA_timeseries(j,:),[2.5 50 97.5]); 
%prev_prcj95(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 95]); 
%prev_prcj90(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 90]); 
end
for j=1:5901
altprev_prcj(j,:)=prctile(results_altprevalence_timeseries(j,:),[2.5 50 97.5]); 
%prev_prcj95(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 95]); 
%prev_prcj90(j,:)=prctile(results_prevalence_timeseries(j,:),[2.5 50 90]); 
end

prevA_prc1=prctile(results_prevalenceA_timeseries(1201,:),[2.5 50 97.5]);
prevA_prc2=prctile(results_prevalenceA_timeseries(2401,:),[2.5 50 97.5]);
prevA_prc3=prctile(results_prevalenceA_timeseries(4401,:),[2.5 50 97.5]);
prevA_prc4=prctile(results_prevalenceA_timeseries(4701,:),[2.5 50 97.5]);
prevA_prc5=prctile(results_prevalenceA_timeseries(5001,:),[2.5 50 97.5]);
prevA_prc6=prctile(results_prevalenceA_timeseries(5401,:),[2.5 50 97.5]);
prevA_prc7=prctile(results_prevalenceA_timeseries(5701,:),[2.5 50 97.5]);
prevA_prc8=prctile(results_prevalenceA_timeseries(5901,:),[2.5 50 97.5]);
prevA_table=[prev_prc1;prevA_prc2;prevA_prc3;prevA_prc4;prevA_prc5;prevA_prc6;prevA_prc7;prevA_prc8;];
%t1=1:5901;
%plot(t1,prev_prcj)
%title ('Model fit Main Scenario')
%legend('2.5', '50','97.5','Location','northwest')

%beta_values_h=7.9*beta_values;
%p-percentiles
p1_prc = prctile(results(:,1),[2.5 50 97.5]) ;
p2_prc = prctile(results(:,2),[2.5 50 97.5]) ;
p3_prc = prctile(results(:,3),[2.5 50 97.5]) ;

%Rel_prc0=prctile(Rel,[2.5 50 97.5]);
%Rel_prc8=prctile(Rel,[2.5 50 97.5]);
 %%%
 %%% 23Nov2018_AL:
 %%% Here we plot the prevalence over time for all the runs. This is where
 %%% you can check whether or not your fitted_p gave reasonable results.
 %%% Question: How do the model runs compare to the original data? Are they
 %%%           close? What I mean is, does the modelled prevalence line
 %%%           come close to all the data points? To see this, try to plot
 %%%           the data points on the same graph as the modelled prevalence
 %%%           lines.
 figure(1);
 plot(t,results_prevalence_timeseries)
  %plot(1:size(y,1),results_prevalence_timeseries)
 figure(2);
 plot(t,results_incidence_timeseries)
  %plot(1:size(y,1),results_incidence_timeseries)
  %PLOT BEST_FITTED_P SOLUTION
  %figure(4);
  %P_f=results_prevalence_timeseries(:,963);
  %plot(t,P_f);
  %P_m=results_prevalence_timeseries(:,944);
  %plot(t,P_m);
  %IR_f=results_incidence_timeseries(:,963);
  figure(3); 
 plot(t,results_prevalenceA_timeseries) 
  %CALCULATE INCIDENCE NUMBER
for j=1:5901
TP_prcj(j,:)=prctile(P(j,:),[2.5 50 97.5]); 
end

  %TP_b=[t,P_b(:,249)];
  %MODEL PREDICTIONS 2009/
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
  
  %CALCULATE INCIDENCE NUMBER
  %TP=[t,P(:,963)];
  %MODEL PREDICTIONS 2009
  %IN_9=TP([1,101,201,301,401,501,601,701,801,901,1001,1101],2);
  %S_9=sum(IN_9,1);%#55.2503 VS EKTEPN 2009 (N=15)
  %MODEL PREDICTIONS 2010
  %IN_10=TP([1201,1301,1401,1501,1601,1701,1801,1901,2001,2101,2201,2301],2);
  %S_10=sum(IN_10,1);%#161.1281 VS EKTEPN 2010 (N=29)
  %MODEL PREDICTIONS 2011
  %IN_11=TP([2401,2501,2601,2701,2801,2901,3001,3101,3201,3301,3401,3501],2);
  %S_11=sum(IN_11,1);%#410.1383 VS EKTEPN 2011 (N=319)
  %MODEL PREDICTIONS 2012
  %IN_12=TP([3601,3701,3801,3901,4001,4101,4201,4301,4401,4501,4601,4701],2);
  %S_12=sum(IN_12,1);%#570.7239 VS EKTEPN 2012 (N=523)
   %MODEL PREDICTIONS 2013
  %IN_13=TP([4801,4901,5001,5101,5201,5301,5401,5501,5601,5701,5801,5901],2);
  %S_13=sum(IN_13,1);%#301.7750 VS EKTEPN 2012 (N=270)
  %CUMULATIVE NUMBER FOR EACH YEAR
  %CN=[S_9;S_9+S_10;S_9+S_10+S_11;S_9+S_10+S_11+S_12;S_9+S_10+S_11+S_12+S_13];
  
 
% Calculate the infected prevalence with this new fitted parameter beta
% Note that this is the same as before: Infected Prevalence =
% I/(SL+SH+I)note:it is the classical prevalence term
%infected_prevalence_calculation_SI = y(:,3)./(y(:,1)+y(:,2)+y(:,3));
%incidence_calculation_SI=beta*infected_prevalence_calculation_SI;
%%betalow*infected_prevalence_calculation_SI*(y(:,1)+10*y(:,2))/(y(:,1)+y(:,2));

% Display and compare with what you expect - which we said was 0.11 (i.e. 11%)
  %disp('Infected prevalence using the fitted parameter')
  %disp([infected_prevalence_calculation_SI(101),infected_prevalence_calculation_SI(201),infected_prevalence_calculation_SI(end)])
  %disp('Incidence using the fitted parameter')
  %disp(incidence_calculation_SI(end))

% Plot the time series
 % plot(tspan,infected_prevalence_calculation_SI)
  %axis([0 15 9 12])
  %title('Infected Prevalence Over Time')