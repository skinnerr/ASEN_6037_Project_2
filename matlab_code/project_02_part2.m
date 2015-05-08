% close all; clear all;
set(groot,'defaultTextInterpreter','none');
set(groot,'defaultLegendInterpreter','none');
set(groot,'defaultLineLineWidth',2);
set(groot,'defaultAxesXGrid','on');
set(groot,'defaultAxesYGrid','on');
set(groot,'defaultAxesFontSize',12);
set(groot,'defaultAxesPosition',[0.15,0.15,0.7,0.7]);

% Read in data.
data1 = read_MKM_data('/home/ryan/ASEN 6037 Turbulence/Project_02/data/chan590.means');
data2 = read_MKM_data('/home/ryan/ASEN 6037 Turbulence/Project_02/data/chan590.kbal');
data3 = read_MKM_data('/home/ryan/ASEN 6037 Turbulence/Project_02/data/chan590.reystress');
data = [data1;data2;data3];
data.keys

%%%
% Problem 2.1
%%%

% Plot stream-wise velocity.
figure();
hold on;
line(data('y+'),data('Umean'));
ax1 = gca();
ax2 = axes('Position',ax1.Position,'XAxisLocation','top','YAxisLocation','right');
line(data('y'),data('Umean'),'Parent',ax2);
hold off;
xlabel(ax1(1),'y+');
xlabel(ax2(1),'y/h');
ylabel(ax1(1),'mean(u)');

% Plot Reynolds stresses.
figure();
hold on;
fields = {'R_uu','R_uv','R_uw','R_vv','R_vw','R_ww'};
field_data = zeros(length(data('y')),length(fields));
for i = 1:length(fields)
    field_data(:,i) = data(fields{i});
end
line(repmat(data('y+'),1,length(fields)),field_data);
ax1 = gca();
ax2 = axes('Position',ax1.Position,'XAxisLocation','top','YAxisLocation','right');
line(repmat(data('y'),1,length(fields)),field_data);
hold off;
xlabel(ax1(1),'y+');
xlabel(ax2(1),'y/h');
ylabel(ax1(1),'Reynolds Stress');
legend(ax2,fields);

% Plot turbulence intensity.
figure();
hold on;
k = zeros(length(data('y+')),1);
for field = {'R_uu','R_vv','R_ww'}
    temp = data(field{1});
    k = k + temp / 2;
end
line(data('y+'),k);
ax1 = gca();
ax2 = axes('Position',ax1.Position,'XAxisLocation','top','YAxisLocation','right');
line(data('y'),k,'Parent',ax2);
hold off;
xlabel(ax1(1),'y+');
xlabel(ax2(1),'y/h');
ylabel(ax1(1),'k');

% Plot dissipation.
figure();
hold on;
line(data('y+'),data('dissip'));
ax1 = gca();
ax2 = axes('Position',ax1.Position,'XAxisLocation','top','YAxisLocation','right');
line(data('y'),data('dissip'),'Parent',ax2);
hold off;
xlabel(ax1(1),'y+');
xlabel(ax2(1),'y/h');
ylabel(ax1(1),'Dissipation');

% Plot anisotropy.
figure();
hold on;
fields = {'R_uu','R_uv','R_uw','R_vv','R_vw','R_ww'};
aniso = zeros(length(data('y')),length(fields));
for i = 1:length(fields)
    aniso(:,i) = data(fields{i}) ./ k;
    if any(strcmp(fields{i},{'R_uu','R_vv','R_ww'}))
        aniso(:,i) = aniso(:,i) - 2/3;
    end
end
fields = {'a_uu','a_uv','a_uw','a_vv','a_vw','a_ww'};
line(repmat(data('y+'),1,length(fields)),aniso);
ax1 = gca();
ax2 = axes('Position',ax1.Position,'XAxisLocation','top','YAxisLocation','right');
line(repmat(data('y'),1,length(fields)),aniso);
hold off;
xlabel(ax1(1),'y+');
xlabel(ax2(1),'y/h');
ylabel(ax1(1),'Anisotropy');
legend(ax2,fields);

% Plot mean strain rate.
figure();
hold on;
fields = {'dUmean/dy','dWmean/dy'};
strain = zeros(length(data('y')),length(fields));
for i = 1:length(fields)
    strain(:,i) = data(fields{i}) / 2;
end
fields = {'Sbar_uv','Sbar_wv'};
line(repmat(data('y+'),1,length(fields)),strain);
ax1 = gca();
ax2 = axes('Position',ax1.Position,'XAxisLocation','top','YAxisLocation','right');
line(repmat(data('y'),1,length(fields)),strain);
hold off;
xlabel(ax1(1),'y+');
xlabel(ax2(1),'y/h');
ylabel(ax1(1),'Mean Strain Rate');
legend(ax2,fields);

%%%
% Problem 2.3
%%%

% Plot Cmu, and find its average away from the walls.
Cmu = (590 .* data('dissip') .* aniso(:,2)) ./ (2 .* k .* strain(:,1));
cutoff_index = 15;
Cmu = Cmu(cutoff_index:end-1);
y = data('y');
yplus = data('y+');
y = y(cutoff_index:end-1);
yplus = yplus(cutoff_index:end-1);
figure();
hold on;
line(yplus,Cmu);
ax1 = gca();
ax2 = axes('Position',ax1.Position,'XAxisLocation','top','YAxisLocation','right');
line(y,Cmu,'Parent',ax2);
line([min(y),max(y)],ones(2,1)*mean(Cmu(40:end)),'Parent',ax2,'Color','r','LineStyle','--');
fprintf('Problem 2.3: average calculated from y = %5f to be %5f\n',y(40),mean(Cmu(40:end)));
hold off;
xlabel(ax1(1),'y+');
xlabel(ax2(1),'y/h');
ylabel(ax1(1),'C_{mu}');













