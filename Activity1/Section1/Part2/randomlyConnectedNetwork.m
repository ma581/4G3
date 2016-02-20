%% Q 2 a i

% Setup
N = 10;
syms r(t) t;
R = cell(N,1);
C = cell(N,1);

legendInfo = cell(N,1);
F =  [-1.3499 3.0349 0.7254 -0.0631 0.7147 -0.2050 -0.1241 1.4897 1.4090 1.4172];
F = F';
I = 1;

% ***********************************% ***********************************
% Setup Connections
% ***********************************% ***********************************
g = 0.9;

% Symmetric matrix
% w1 = normrnd(0,g/sqrt(N), [N 1]); % The diagonal values
% w2 = triu(bsxfun(@min,w1,w1.').*normrnd(0,g/sqrt(N), [N N]),1); % The upper trianglar random values
% W = diag(w1)+w2+w2.'; % Put them together in a symmetric matrix

W = normrnd(0,g/sqrt(N), [N N]);
for i = 1:N
    W(i,i) = 0;
end



% ***********************************
% Eigenvalue decomposition
% ***********************************
[V,D] = eig(W);
lamda_nu = zeros(N,1);
for i = 1:N
    lamda_nu(i) = D(i,i);
end
 
% ***********************************% ***********************************
% Solving for time-dependent coefficients describing r(r)
% ***********************************% ***********************************
c_0 = 0; % Boundary condition assuming zero
for i = 1:N
    g_nu = V(:,i)'*(F*I);
    C{i} = g_nu/(1 - lamda_nu(i)) + (c_0 - g_nu/(1 -lamda_nu(i)))*exp(-t/(1 /(1-lamda_nu(i) )));
end
% ***********************************
% Calculating firing rates
% ***********************************

j = 1; %temp variable
r_ = zeros(N,20); %will hold all neurons response at a given time
R = zeros(N,20); %will hold firing rate over time
for time = 0:10:500
    for i = 1:N
        r_(:,i) = eval(subs(C{i},time))*V(:,i);
    end
    R(:,j) = sum(r_,2); 
    j = j + 1;
end

% Plotting
time = [0:10:500];
figure;
legendInfo2 = cell(N,1);
for i = 1:N
    p = plot(time,R(i,:));
    legendInfo2{i} = ['r' num2str(i)];
    hold on;
    set(p,'LineWidth',2);
end
xlabel('Time (s)');
ylabel('Firing Rate (s^{-1})');
title('Firing Rates');
legend(legendInfo2);
grid on;



%% 2a(ii) Argand
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


%% 2a(iii) Equilibrim firing rate
% 
% syms r1(t) r2(t) r3(t) r4(t) r5(t) r6(t) r7(t) r8(t) r9(t) r10(t)
% r_1 = {r1(t) r2(t) r3(t) r4(t) r5(t) r6(t) r7(t) r8(t) r9(t) r10(t)};
% 
% r_1 + W*r_1;
% ***********************************
% Calculating firing rates at infiinity
% ***********************************

% j = 1; %temp variable
% r_ = zeros(N,20); %will hold all neurons response at a given time
% R_final = zeros(N,20); %will hold firing rate over time
% for time = 5000:0.1:5002
%     for i = 1:N
%         r_(:,i) = eval(subs(C{i},time))*V(:,i);
%     end
%     R_final(:,j) = sum(r_,2); 
%     j = j + 1;
% end
% 
% % Plotting
% time = 5000:0.1:5002;
% figure;
% legendInfo2 = cell(N,1);
% for i = 1:N
%     p = plot(time,R_final(i,:));
%     legendInfo2{i} = ['r' num2str(i)];
%     hold on;
%     set(p,'LineWidth',2);
% end
% xlabel('Time (s)');
% ylabel('Firing Rate (s^{-1})');
% title('Firing Rates');
% legend(legendInfo2);
% grid on;    
% 
% final_values(:,1) = R_final(:,j-1);
% r_at_t10 = zeros(N,1);


% ***********************************
% Calculating firing rates at infiinity
% ***********************************
r_rates = zeros(N,N);
c_0 = 0; % Boundary condition assuming zero
for i = 1:N
    g_nu = V(:,i)'*(F*I);
    temp_const = g_nu/(1 - lamda_nu(i));
    r_rates(:,i) = temp_const*V(:,i);
end
r_inf = sum(r_rates,2);

% ***********************************
% Calculating firing rates at r(t=10)
% ***********************************

time = 10;
    for i = 1:N
        r_(:,i) = eval(subs(C{i},time))*V(:,i);
    end
r_at_t10(:,1) = sum(r_,2); 

figure;
p = plot(real(r_inf),r_at_t10,'x' );
set(p,'LineWidth',2);
xlabel('r_{inf} (s^{-1})');
ylabel('r(t=10) (s^{-1})');
title('Equilibrium Rates');
grid on;