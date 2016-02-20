function r_future = MyEuler(r_current, dt, lamda, F,W)
    dr_dt = -1*r_current + W*r_current + F;
    r_future = r_current + dt*dr_dt;
end