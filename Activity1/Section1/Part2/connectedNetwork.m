%% Setup
N = 10;
dt = 0.001;
T = 10;
lamda = 1;


% ***********************************% ***********************************
% Setup Connections
% ***********************************% ***********************************
g = 0.5;

% Symmetric matrix
% w1 = normrnd(0,g/sqrt(N), [N 1]); % The diagonal values
% w2 = triu(bsxfun(@min,w1,w1.').*normrnd(0,g/sqrt(N), [N N]),1); % The upper trianglar random values
% W = diag(w1)+w2+w2.'; % Put them together in a symmetric matrix

% W = normrnd(0,g/sqrt(N), [N N]);
% for i = 1:N
%     W(i,i) = 0;
% end
load('W.mat')
W = W*5;

%% Initial
r = zeros(N, T/dt+1);
r(1) = 0;
time = [0:dt:T];
F =  [-1.3499 3.0349 0.7254 -0.0631 0.7147 -0.2050 -0.1241 1.4897 1.4090 1.4172];


%% Numerical integrator


for i = 2:T/dt+1
   r(:,i) = MyEuler2(r(:,i-1), dt, lamda, F',W);
end


%% Plotting

legendInfo = cell(N,1);
for i=1:N
    h = plot(time',r(i,:));
    legendInfo{i} = ['r' num2str(i) ' (F = ' num2str(F(i)) ')'];
    set(h,'LineWidth',2);
    hold on;
end
xlabel('Time(s)');
ylabel('Firing Rate(s^{-1})');
title('Firing Rates');
legend(legendInfo);
grid on;
  
%% a_ii
% ***********************************
% Eigenvalue decomposition
% ***********************************
[V,D] = eig(W);
for i = 1:N
    lamda_nu(i) = D(i,i);
end
figure;
p = plot(lamda_nu,'x');
set(p,'LineWidth',2);
% for i = 1:N
%     p = plot(lamda_nu(i),'x');
%     hold on;
%     set(p,'LineWidth',2);
% end
xlabel('Real');
ylabel('Imaginary');
title('Eigenvalues of connectivity matrix W');
% legend(legendInfo2);
grid on;


%% a_iii

A = W-eye(N,N);
r_inf = A\(-1*F');

figure;
for i = 1:N
p = plot(r_inf(i),r(i,10/dt),'x');
hold on;
set(p,'LineWidth',2);
end

% for i = 1:N
%     p = plot(lamda_nu(i),'x');
%     hold on;
%     set(p,'LineWidth',2);
% end
xlabel('r_{inf} (s^{-1})');
ylabel('r(t=10) (s^{-1})');
title('Equilibrium Rates');
legend(legendInfo);
grid on;


    