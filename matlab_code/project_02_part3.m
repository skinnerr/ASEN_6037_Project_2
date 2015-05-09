clear all;
set(groot,'defaultTextInterpreter','none');
set(groot,'defaultLegendInterpreter','none');
set(groot,'defaultLineLineWidth',2);
set(groot,'defaultAxesXGrid','on');
set(groot,'defaultAxesYGrid','on');
set(groot,'defaultAxesFontSize',12);
set(groot,'defaultAxesPosition',[0.15,0.15,0.7,0.7]);

global i A

% Load data from Yu and Girimaji.
dns_data = {};
dns_data{1} = csvread('../data/YuGirimaji_Fig25.txt',1,0);
dns_data{2} = csvread('../data/YuGirimaji_Fig15.txt',1,0);
dns_data{3} = csvread('../data/YuGirimaji_Fig14.txt',1,0);

Cmu = 0.09;
Sstar = 3.3;
options = odeset('RelTol',1e-7);
Sstartau_range = [0,50];
A = [10,1,0.5,0.1,0.01];

figure();
hold on;
for i = 1:length(A)
    % SKE Model
    init_cond = [1,1];
    [tvec,yvec] = ode45(@ode_a12_SKE,Sstartau_range,init_cond,options);
    a12 = -Cmu .* yvec(:,1) ./ yvec(:,2) .* Sstar .* sin(tvec .* A(i));
    plot(tvec,a12,'DisplayName',['w/S = ',num2str(A(i))]);
end
% Annotation
hold off;
xlabel('Time (S* tau)');
ylabel('a_{12}');
title('SKE');
legend(gca,'show','location','northeast');
% Set axis range.
xlim([0,50]);
ylim([-0.8,0.8]);

figure();
hold on;
for i = 1:length(A)
    % DKE Model
    init_cond = [1,1,0];
    [tvec,yvec] = ode45(@ode_a12_DKE,Sstartau_range,init_cond,options);
    plot(tvec,yvec(:,3),'DisplayName',['w/S = ',num2str(A(i))]);
end
% Annotation
hold off;
xlabel('Time (S* tau)');
ylabel('a_{12}');
title('DKE');
legend(gca,'show','location','northeast');
% Set axis range.
xlim([0,50]);
ylim([-0.8,0.8]);

for i = 1:3
    figure();
    hold on;
    % SKE Model
    init_cond = [1,1];
    [tvec,yvec] = ode45(@ode_a12_SKE,Sstartau_range,init_cond,options);
    a12 = -Cmu .* yvec(:,1) ./ yvec(:,2) .* Sstar .* sin(tvec .* A(i));
    plot(tvec,a12,'DisplayName','SKE');
    % DKE Model
    init_cond = [1,1,0];
    [tvec,yvec] = ode45(@ode_a12_DKE,Sstartau_range,init_cond,options);
    plot(tvec,yvec(:,3),'DisplayName','DKE');
    % DNS Results
    if i<4
        plot(dns_data{i}(:,1),2*dns_data{i}(:,2),'DisplayName','DNS');
    end
    % Annotation
    hold off;
    xlabel('Time (S* tau)');
    ylabel('a_{12}');
    title(['omega/S = ',num2str(A(i))]);
    legend(gca,'show','location','northeast');
    % Set axis range.
    if i==1
        xlim([0,4]);
    else
        xlim([0,50]);
    end
    ylim([-0.8,0.8]);
end
