clear all;
close all;
clc;
f = 8000;
f_sine = 50;
voltage = 60; 
arr = 4500  - 1;
numbers = (round (f / f_sine)) ;
Ac=4500;
i=0;
%CCR_max = round( ((11 * f_sine) / (400*sqrt(2))) * arr );
dt=10000;
Angle_p_Saw=1.125;
Nsaw=360/Angle_p_Saw;
Point_per_Saw=dt*360/Nsaw;
CCR_max = round( (voltage * arr) / 60);
beta =0:1/dt:360-1/dt;
vc=(round(Ac*sawtooth(2*pi*1/Angle_p_Saw*beta,1/2)));
zero = round ((4 * (10^-6) * numbers)*(numbers / ((1/f) * numbers)));
fprintf('%d \n',zero);
fprintf('%d \n',numbers);
fprintf('%d \n',CCR_max);

fprintf('\n'); fprintf('\n'); fprintf('\n');

    third_hamonic_injecta = 0.15*sind(3*beta);
    third_hamonic_injectb = 0.15*sind(3*beta-(3*(2*180)/3));
    third_hamonic_injectc = 0.15*sind(3*beta+ (3*(2*180)/3));
    y = sind(beta)+third_hamonic_injecta;
    sineA= (round ( y*CCR_max));
    
    x = sind (beta  -((2*180)/3))+third_hamonic_injectb;
    sineB =  ( round (x*CCR_max));
     
    z =  sind (beta + ((2*180)/3))+third_hamonic_injectc;
    sineC =   (round ( z*CCR_max));

% PHASE A    
    fprintf('const uint32_t A%d_1[%d]={ \n',f/Nsaw*2, Nsaw);
    for Dem1=1:length(sineA)
    if (sineA (Dem1) > vc(Dem1) )
        van1(Dem1)=voltage/2;
    elseif (sineA (Dem1) < vc(Dem1) )
        van1(Dem1)=-voltage/2;
    end 
    end
    for count=1:length(sineA)
    if van1(count)>0
        Gate1(count)=1;
    else 
        Gate1(count)=0;
    end
    end
   demA=0;
   NdemA_H=0;
   for count1=0: Nsaw-1
       for countA=count1*Point_per_Saw+1:count1*Point_per_Saw+Point_per_Saw
           if Gate1(countA)==1
               demA=demA+1;
           end
       end
       NdemA_H(count1+1)=demA;
       demA=0;
   end
   NdemA_H=round(NdemA_H*CCR_max/Point_per_Saw);
   NdemA_L=CCR_max-NdemA_H;
   for dema = 1:length(NdemA_H)
        yA=NdemA_H(dema);
        fprintf('%d',yA), fprintf(',');
        if mod(dema,10)==0
            fprintf('\n');
        end
   end
fprintf('};');
fprintf('\n');
fprintf('\n');
    fprintf('const uint32_t A%d_2[%d]={ \n',f/Nsaw*2, Nsaw);
for dema = 1:length(NdemA_L)
        yA=NdemA_L(dema);
        if ( yA > 4500)
            fprintf('%d',yA-4500), fprintf(','); 
        elseif ( yA <= 4500)
            fprintf('%d',0), fprintf(','); 
        end
        if mod(dema,10)==0
            fprintf('\n');
        end
 end
fprintf('};');
fprintf('\n');
fprintf('\n');

% PHASE B   
    fprintf('const uint32_t B%d_1[%d]={ \n',f/Nsaw*2, Nsaw);
    for Dem2=1:length(sineB)
    if (sineB (Dem2) > vc(Dem2) )
        van2(Dem2)=voltage/2;
    elseif (sineB (Dem2) < vc(Dem2) )
        van2(Dem2)=-voltage/2;
    end 
    end
    for count=1:length(sineB)
    if van2(count)>0
        Gate2(count)=1;
    else 
        Gate2(count)=0;
    end
    end
   demB=0;
   NdemB_H=0;
   for count2=0: Nsaw-1
       for countB=count2*Point_per_Saw+1:count2*Point_per_Saw+Point_per_Saw
           if Gate2(countB)==1
               demB=demB+1;
           end
       end
       NdemB_H(count2+1)=demB;
       demB=0;
   end
   NdemB_H=round(NdemB_H*CCR_max/Point_per_Saw);
   NdemB_L=CCR_max-NdemB_H;
   for demb = 1:length(NdemB_H)
        yB=NdemB_H(demb);
      fprintf('%d',yB), fprintf(',');
        if mod(demb,10)==0
            fprintf('\n');
        end
  end
fprintf('};');
fprintf('\n');
fprintf('\n');
fprintf('const uint32_t B%d_2[%d]={ \n',f/Nsaw*2, Nsaw);
for demb = 1:length(NdemB_L)
        yB=NdemB_L(demb);
        if ( yB > 4500)
            fprintf('%d',yB-4500), fprintf(','); 
        elseif ( yB <= 4500)
            fprintf('%d',0), fprintf(','); 
        end
        if mod(demb,10)==0
            fprintf('\n');
        end
 end
fprintf('};');
fprintf('\n');
fprintf('\n');

   % PHASE C    
    fprintf('const uint32_t C%d_1[%d]={ \n',f/Nsaw*2, Nsaw);
    for Dem3=1:length(sineC)
    if (sineC (Dem3) > vc(Dem3) )
        van3(Dem3)=voltage/2;
    elseif (sineC (Dem3) < vc(Dem3) )
        van3(Dem3)=-voltage/2;
    end 
    end
    for count=1:length(sineC)
    if van3(count)>0
        Gate3(count)=1;
    else 
        Gate3(count)=0;
    end
    end
   demC=0;
   NdemC_H=0;
   for count3=0: Nsaw-1
       for countC=count3*Point_per_Saw+1:count3*Point_per_Saw+Point_per_Saw
           if Gate3(countC)==1
               demC=demC+1;
           end
       end
       NdemC_H(count3+1)=demC;
       demC=0;
   end
   NdemC_H=round(NdemC_H*CCR_max/Point_per_Saw);
   NdemC_L=CCR_max-NdemC_H;
   for demc = 1:length(NdemC_H)
        yC=NdemC_H(demc);
fprintf('%d',yC), fprintf(',');
        if mod(demc,10)==0
            fprintf('\n');
        end
  end
fprintf('};');
fprintf('\n');
fprintf('const uint32_t C%d_2[%d]={ \n',f/Nsaw*2, Nsaw);
for demc = 1:length(NdemC_L)
        yC=NdemC_L(demc);
        if ( yC > 4500)
            fprintf('%d',yC-4500), fprintf(','); 
        elseif ( yC <= 4500)
            fprintf('%d',0), fprintf(','); 
        end
        if mod(demc,10)==0
            fprintf('\n');
        end
 end
fprintf('};');
fprintf('\n');
fprintf('\n');

   
   figure();
   plot (beta,sineA,'b'); %xanh phase1
   ylabel('y')
   xlabel('theta');
   hold on;    
   plot (beta,sineB ,'k'); %den phase2
   ylabel('y')
   xlabel('theta');
   hold on;   
   plot (beta,sineC,'r'); %do phase3
   ylabel('y')
   xlabel('theta');
   hold on; 
   plot(beta, vc);
   hold on; 
   figure();
   plot(NdemA_H);
   hold on;
   plot(NdemB_H);
   hold on;
   plot(NdemC_H);
   hold on;
   plot(NdemA_L);
   hold on;
   plot(NdemB_L);
   hold on;
   plot(NdemC_L);
   hold on;

