   function [dydt] = pathway_GLP1(t, y, p)
       


        % System parameters
       
         Eg0=0.0118;  BV=7200; unit_con=0.0006944;

        
        % Define metabolic rate M and Insulin secretion rate ISR
        Mmax=1; alpha_M=150; kM=2;
        M = Mmax.*y(1).^kM./(alpha_M.^kM + y(1).^kM);
        
        alpha_ISR=1.2; 
        kISR=2;

        
          ts=60; t_min=0.00069444;
           % Define exocytosis
            % Glucose Amplifying factor
                 
         GF_bar=4.4567.*( (p.n_iter>0)-(p.n_iter>p.t_GF_bar_on) ) + (4.4567 + p.del_GF_bar).*( (p.n_iter>p.t_GF_bar_on)-(p.n_iter>p.t_GF_bar_off) );
         r20=0.006.*( (p.n_iter>0)-(p.n_iter>p.t_r20_on) ) + (0.006 + p.del_r20).*( (p.n_iter>p.t_r20_on)-(p.n_iter>p.t_r20_off) );


         GF_b=1.7826.*( (p.n_iter>0)-(p.n_iter>p.t_GF_b_on) ) + (1.7826 + p.del_GF_b).*( (p.n_iter>p.t_GF_b_on)-(p.n_iter>p.t_GF_b_off) );
        %GF_bar=4.4567; 
        %GF_b=1.7826;

        kGF=16; alpha_GF=260; shGF=-89; 
        

        GF=(0.1.*p.IVGTT.*GF_bar + (1-p.IVGTT).*GF_bar).*(y(1)-shGF).^kGF./(alpha_GF.^kGF + (y(1)-shGF).^kGF) + GF_b;

        ca_bar=2; kca=4; alpha_ca=0.62; ca_b=0.07; 
       
        ci=ca_bar.*(M + y(4)).^kca./(alpha_ca.^kca + (M + y(4)).^kca) + ca_b;
        
           
           
           
        k1=20; km1=100; r1=0.6; rm1=1; rm2=0.001;
        %r20=0.006; 
      
        
        r30=1.205; rm3=0.0001; u1=2000; u2=3; u3=0.02; Kp2=2.3;

        %r2 = (0.1.*p.IVGTT.*p.r20 + (1-p.IVGTT).*p.r20).*ci./(ci + Kp2);
        r2 = (0.1.*p.IVGTT.*r20 + (1-p.IVGTT).*r20).*ci./(ci + Kp2);
         
        
        % Define Microdoman Ca2+
        cmd_factor=150; cmd_b=0.0635; cik=4; cialpha=1;
        cmd=cmd_factor.*ci.^cik./(cialpha.^cik+ci.^cik) + cmd_b;

      
      
       
        r3 = y(5).*GF.*r30.*ci./(ci + Kp2);

        %%%%%%%%
       N1_C=km1./(3.*k1.*cmd + rm1);
       N1_D=r1./(3.*k1.*cmd + rm1);

       N2_E=3.*k1.*cmd./(2.*k1.*cmd + km1);
       N2_F=2.*km1./(2.*k1.*cmd + km1);

       N3_L=2.*k1.*cmd./(2.*km1+k1.*cmd);
       N3_N=3.*km1./(2.*km1+k1.*cmd);

      %%%%%% fast-slow analysis by considering N6 and N5 slow and all other fast.
      CN4=(k1.*cmd./(3.*km1 +u1));
      CN3=N3_L./(1-N3_N.*CN4);
      CN2=N2_E./(1-N2_F.*CN3);
      CN1=N1_D./(1-N1_C.*CN2);

      

      N1=CN1.*y(8);
      N2=CN2.*N1;
      N3=CN3.*N2;
      N4=CN4.*N3;
      NF=u1.*N4./u2;
      NR=(u2./u3).*NF;
      

        
        
          %###### Build b dynamics  and Define Proliferation rate P(ISR) and Apoptosis A(M)
         
         ISR=ts.*9.*(u3.*NR);
         Pmax=4.55; kP=4; alpha_P=41.77;
         P=Pmax.*ISR.^kP./(alpha_P.^kP + ISR.^kP);

         Amax=3.11; alpha_A=0.44; kA=6; A_b=0.8;
         A=Amax.*M.^kA./(alpha_A.^kA + M.^kA) + A_b;
         tau_b=10080000;

        %###### Build gamma dynamics
        %Gs=100;
        G_bar=0.4; Gn=5; Gshft=0.2;
        G_inf=G_bar./(1+ exp(-(y(1)-p.Gs)./Gn)) - Gshft;
        gamma_inf=G_inf;
        tau_g=3081.6;

         %###### Build sigma dynamics
         sigma_Gsh=35;
         M_Gsh = Mmax.*(y(1)-sigma_Gsh).^kM./(alpha_M^kM + (y(1)-sigma_Gsh).^kM);

         %ISRI_bar=400; 
         
          % IGT early=160, IGT late= 290

         %ISRI_bar=0.5259.*( (p.n_iter>0)-(p.n_iter>p.t_sigma_on) ) + (0.5259 + p.del_ISRI_bar).*( (p.n_iter>p.t_sigma_on)-(p.n_iter>p.t_sigma_off) );
         
         ISRI_s=0.1; ISRI_n=0.1; ISRI_k=1; sigma_b=0.01752;
         sigma_ISRI=p.ISRI_bar./(1+ ISRI_k.*exp(-(ISR-ISRI_s)./ISRI_n));

         MI_bar=1; MI_k=0.2; MI_s=0.2; MI_n=0.02;
         sigma_MI= 1 - MI_bar./(1 + MI_k.*exp(-(M_Gsh-MI_s)./MI_n));
         sigma_inf=sigma_MI.*sigma_ISRI + sigma_b; 
         tau_sigma=359856;

       %meal Flux
       period=360;
       nspike=3;
       active=nspike*period;
       rest=360;
       bperiod=active + rest; 

      mhill_k=4; mh_alpha=40; ita=0.3; mu=-0.015;
      
     burstenv=( (mod(t,bperiod)>0)-( mod(t,bperiod)>active) );
     mhill_fcn=mod(t,period).^mhill_k./(mh_alpha.^mhill_k +mod(t,period).^mhill_k);
     meal_rate= p.meal.*(p.mealbar.*(mhill_fcn).^ita.*exp(mu.*(mod(t,period))).*burstenv);

    %%%%


%%%%%%
      % OGTT Flux %% unit [BW]=kg, [V_bar]=dl
        V_bar=1.569; OGTTbar=1; t1=15; 
        t2=120; t3=240;
        a1=588.5; a2=353.1; a3=0; 
       
        OGTT_flux0=((t>0)-(t>t1)).*t.*a1./t1 + ((t>t1)-(t>t2)).*((t-t2).*(a2-a1)./(t2-t1)+a2) + ((t>t2)-(t>t3)).*(t-t3).*(a3-a2)./(t3-t2);
        OGTT_rate=p.OGTT.*OGTTbar.*OGTT_flux0./(p.BW.*V_bar);
        
     % IVGTT Flux      

       IVGTTbar=1471250; IVGTT_sh=0;
       IVGTT_a=1; IVGTT_b=-10; 
       IVGTT_sp=0;

      IVGTT_rate= p.IVGTT*IVGTTbar*(t-IVGTT_sh)^IVGTT_a*exp(IVGTT_b*(t-IVGTT_sp))./(p.BW.*V_bar);

    % HGP model
      
      hepa_bar=15.443; hepa_k=0.27; hepa_b=-3.54277; con_si=0.8;
      hepa_max= hepa_bar./(hepa_k +y(6).*(1-p.HGP_no_si) + con_si*p.HGP_no_si) + hepa_b;
      
     alpha_max=6; alpha_k=0.4; alpha_b=-0.5;
     alpha_HGP= alpha_max./(alpha_k + y(6).*(1-p.HGP_no_si) + con_si*p.HGP_no_si) + alpha_b;

     HGP_b=0.104166;  
     HGP = hepa_max./(alpha_HGP + y(2)*y(7)) + HGP_b;



     % ode system       

      dGdt = HGP +meal_rate + OGTT_rate + IVGTT_rate - (Eg0 + unit_con.*y(6).*y(2)).*y(1);
      dIdt = y(3).*ISR./BV  - p.k.*y(2);  
      dbdt = (P-A).*y(3)./tau_b;
      dgammadt = (gamma_inf - y(4))./tau_g;
      dsigmadt = (sigma_inf - y(5))./tau_sigma;
      dsidt=(-y(6) + p.tar_si)./p.tau_si;
   
    
      
      dhepasidt=(-y(7)+ p.tar_hepasi)./p.tau_hepasi;

      dN5dt = ts.*(rm1.*CN1.*y(8) - (r1 + rm2).*y(8) + r2.*y(9));
      dN6dt = ts.*(r3 + rm2.*y(8) - (rm3 + r2).*y(9));

     % dGLP1dt=t_min.*(GLP1_inf- y(5))./tau_GLP1;
     % dydt = [dGdt; dIdt; dN5dt; dN6dt;dGLP1dt];
       dydt = [dGdt; dIdt; dbdt; dgammadt; dsigmadt; dsidt; dhepasidt; dN5dt; dN6dt];



%plot (t,meal_rate)






