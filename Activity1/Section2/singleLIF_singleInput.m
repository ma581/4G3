%% Setup
V_th = 1;
dt = 0.1*10^-3;
tau = 20*10^-3;
N = 1000;
K = 100;
r_x = 10;
T = 2;
%% Single LIF
load('S');
w = 0.9;

S_input = S(66,:)./dt;
S_output = zeros(1,T/dt);
V_output = zeros(1,T/dt);

for i = 2:T/dt
    [V_output(i), S_output(i)] = MyEuler4(V_output(i-1), tau, w, S_input(i-1), V_th, dt);
end


%% Plotting
time_array = [0:dt:T-dt];
p1 = subplot(2,1,1);
p = plot(time_array,V_output);
set(p,'LineWidth',2);
grid on;
xlabel('Time(s)');
ylabel('V(t)');
title('Single LIF Neuron with single spike train');

p2 = subplot(2,1,2);
plot(time_array,S_input*dt,'.',time_array,S_output*2,'.','markers',18);
grid on;
xlabel('Time(s)');
ylabel('Spike train');
legend('S_{j} Input','S_{i} Output');
title('Input and Output spike trains');
axis([0 T 0 2.2]);

