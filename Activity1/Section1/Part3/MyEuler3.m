function r_future = MyEuler3(r_current, dt, lamda, h, W)
    dr_dt = -1*r_current + h + (lamda/pi)*W*r_current;
    dr_dt(dr_dt<0) = 0; %rectify
    r_future = r_current + dt*dr_dt;
end