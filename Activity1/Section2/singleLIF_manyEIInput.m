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
w = 1.4; % w = 1.4 for firing rate of 10Hz

S_output = zeros(1,T/dt);
V_output = zeros(1,T/dt);
h = zeros(1,T/dt);
%incrementing over time
for i = 2:T/dt
    S_in_exc = S(300:300+K,i-1)./dt; 
    S_in_inh = S(100:100+K,i-1)./dt; 
    [V_output(i), S_output(i)] = MyEuler6(V_output(i-1), tau, w, S_in_exc, S_in_inh, V_th, dt, K);
%     h(i) = w*(1/K)*sum(S_in_exc);
end


%% Plotting
figure;
time_array = [0:dt:T-dt];
p1 = subplot(2,1,1);
p = plot(time_array,V_output);
set(p,'LineWidth',2);
grid on;
xlabel('Time(s)');
ylabel('V(t)');
title('Single LIF Neuron with many input spike trains');

p2 = subplot(2,1,2);
plot(time_array,S_output*2,'.','markers',18);
grid on;
xlabel('Time(s)');
ylabel('Spike train');
legend('S_{i} Output');
title('Input and Output spike trains');
axis([0 T 0 2.2]);


%% Mean and Stdev

myu = mean(V_output);
var_ = var(V_output);

myu_pred = tau*w*r_x;
s = 0;

for n = 1:K
    s = s + (n^2)*((r_x*dt)^(n))*(1-r_x*dt)^(K-n);
end

var_pred = (tau/2)*(((w/(K*dt))^2)*s - (w*r_x)^2);
% myu_pred2 = 0.975*myu_pred;


%% Fano factor
window = 100*10^-3;
FanoFactor = CalculateFano(S_output,window,dt);


%% (b) Firing rate of 10
firing_rate = sum(S_output); %w = 1.4; Fano = 0.9686
