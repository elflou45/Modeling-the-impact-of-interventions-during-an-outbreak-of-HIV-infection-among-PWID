%% This file calculates the difference between the model and the data
function fit_final = acute_mdfit_final(p,current_r1,current_r2, current_r3,current_r4, current_r5, current_r6,current_r7,current_r8,current_r9,current_r10, current_r11, current_r12,current_r13,current_r14,current_r15,current_r16,current_r17,current_r18,current_z1,current_z2,current_z3,current_z4,current_z5,current_nsp1,current_nsp2,current_nsp3,current_nsp4,current_nsp5,current_nsp6,current_nsp7,current_nsp8,current_nsp9,current_nsp10,current_nsp11,current_nsp12,current_nsp13)
% Data point - This is the prevalence that the beta_fit parameter will try
% to fit to
%z = 0.289+(0.615-0.289)*rand(1,2);%1x2 vector
% for i=1:numel(z)
 %    z_actual=z(i);
 %end
prevalence_data_r =[current_r1 current_r2 current_r3 current_r4 current_r5 current_r6 current_r7];%=current_r;
frequency_data_r=[current_r8 current_r9 current_r10 current_r11 current_r12 ];
therapy_data_rl=[current_r13 current_r14 current_r15 current_r16 current_r17 ];


options = odeset('RelTol', 1e-4, 'NonNegative', [1 2 3 4 5 6 7 8]);

%INSERT 95%CI'S FOR THE INITIAL PREVALENCE(0.006(0.0011-0.163)
%pd18 = makedist('Triangular','a',4356.29,'b',4401.91,'c',4423.61);
%pd19 = makedist('Triangular','a',4.87133,'b',26.5709,'c',72.1842);
%pd20 = makedist('Triangular','a',3350.09,'b',3513.31,'c',3567.59);
%pd21 = makedist('Triangular','a',3.92867,'b',21.4291,'c',58.2158);


[t,y] = ode45(@(t,y) acutemfit_eq_final(t,y,p,current_r18,current_z1,current_z2,current_z3,current_z4,current_z5,current_nsp1,current_nsp2,current_nsp3,current_nsp4,current_nsp5,current_nsp6,current_nsp7,current_nsp8,current_nsp9,current_nsp10,current_nsp11,current_nsp12,current_nsp13),[1:0.01:60], [4432.72 0 26.7569 0 3574.94 0 21.5791 0], options);


%[t,y] = ode45(@(t,y) mfit_eq_final_g_AL_elina(t,y,p), [1:0.01:60], [current_s0 current_i0 0 current_s1 current_i1], options);
%end
%plot(t,y)
%legend('S0', 'I0', 'A','S1', 'I1');
%Total=sum(y,2);
%y1=y(:,1)
%y2=y(:,2);
%y3=y(:,3);
%y4=y(:,4);
%y5=y(:,5);
%CALCULATE PREVALENCE WITHOUT ART
N=8056;
prevalence_model = [(y(1201,2)+y(1201,3)+y(1201,6)+y(1201,7))/N,(y(2401,2)+y(2401,3)+y(2401,6)+y(2401,7))/N,(y(4401,2)+y(4401,3)+y(4401,6)+y(4401,7))/N,(y(4701,2)+y(4701,3)+y(4701,6)+y(4701,7))/N,(y(5001,2)+y(5001,3)+y(5001,6)+y(5001,7))/N,(y(5401,2)+y(5401,3)+y(5401,6)+y(5401,7))/N,(y(5701,2)+y(5701,3)+y(5701,6)+y(5701,7))/N];
frequency_model=[(y(4401,5)+y(4401,6)+y(4401,7)+y(4401,8))/N,(y(4701,5)+y(4701,6)+y(4701,7)+y(4701,8))/N,(y(5001,5)+y(5001,6)+y(5001,7)+y(5001,8))/N,(y(5401,5)+y(5401,6)+y(5401,7)+y(5401,8))/N,(y(5701,5)+y(5701,6)+y(5701,7)+y(5701,8))/N];%;(y(1,4)+y(1,5)+y(1,6))/N
therapylow_model=[y(4401,4)/(y(4401,2)+y(4401,3)),y(4701,4)/(y(4701,2)+y(4701,3)),y(5001,4)/(y(5001,2)+y(5001,3)),y(5401,4)/(y(5401,2)+y(5401,3)),y(5701,4)/(y(5701,2)+y(5701,3))];
 
%results_prevalence(i)=prctile((y(1201,2)+y(1201,5))/N,[2.5 97.5]);
%prev_2=prctile((y(2401,2)+y(2401,5))/N,[2.5 97.5]);

% Find the difference between the model and the data - we want to minimise this ?fitting_function'
  fit_final =[prevalence_model - prevalence_data_r,frequency_model - frequency_data_r,therapylow_model-therapy_data_rl];
%  fit_final(1)
  %[prevalence_model -prevalence_data_r,frequency_model-frequency_data_r]; %[current_r1 current_r2 current_r3];
end