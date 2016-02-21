function [V_future, S_output ] = MyEuler6(V_current, tau, w, S_exc, S_inh, V_th, dt, K)
    dr_dt = -1*V_current/tau + (w/sqrt(K))*sum(S_exc) - (w/sqrt(K))*sum(S_inh) ;
%     dr_dt(dr_dt<0) = 0; %rectify
    V_future = V_current + dt*dr_dt;
    
    
    S_output = 0;
    
    if (V_future>V_th)
        S_output = 1;
        V_future = 0;
    end
    
    
end