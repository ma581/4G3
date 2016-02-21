function [V_future,S_output ] = MyEuler5(V_current, tau, w, S, V_th, dt, K)
    dr_dt = -1*V_current/tau + (w/K)*sum(S);
%     dr_dt(dr_dt<0) = 0; %rectify
    V_future = V_current + dt*dr_dt;
    
    
    S_output = 0;
    
%     if (V_future>V_th)
%         S_output = 1;
%         V_future = 0;
%     end
    
    
end