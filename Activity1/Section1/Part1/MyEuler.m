function r_future = MyEuler(r_current, dt, lamda, F)
    dr_dt = -1*lamda*r_current + F;
    r_future = r_current + dt*dr_dt;
end