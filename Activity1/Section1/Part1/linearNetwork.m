%% Setup
N = 10;
dt = 0.001;
T = 5;
lamda = 1;

%% Initial
r = zeros(T/dt+1,N);
r(1) = 0;
time = [0:dt:5];
F =  [-1.3499 3.0349 0.7254 -0.0631 0.7147 -0.2050 -0.1241 1.4897 1.4090 1.4172];


%% Numerical integrator

for j = 1:N
    for i = 2:T/dt+1
        r(i,j) = MyEuler(r(i-1,j), dt, lamda, F(j));
    end
end

%% Plotting

legendInfo = cell(N,1);
for i=1:N
    h = plot(time',r(:,i));
    legendInfo{i} = ['r' num2str(i) ' (F = ' num2str(F(i)) ')'];
    set(h,'LineWidth',2);
    hold on;
end
xlabel('Time(s)');
ylabel('Firing Rate(s^{-1})');
title('Firing Rates');
legend(legendInfo);
grid on;
    
    