close all; clear all;
set(groot,'defaultTextInterpreter','none');
set(groot,'defaultLegendInterpreter','none');
set(groot,'defaultLineLineWidth',2);
set(groot,'defaultAxesXGrid','on');
set(groot,'defaultAxesYGrid','on');
set(groot,'defaultAxesFontSize',12);
set(groot,'defaultAxesPosition',[0.15,0.15,0.7,0.7]);

% Read in data.
data1 = read_MKM_data('/home/ryan/Project_02/data/chan590.means');
data2 = read_MKM_data('/home/ryan/Project_02/data/chan590.kbal');
data3 = read_MKM_data('/home/ryan/Project_02/data/chan590.reystress');
data = [data1;data2;data3];
data.keys

% Plot stream-wise velocity.
figure();
line(data('y+'),data('Umean'));
ax1 = gca();
ax2 = axes('Position',ax1.Position,'XAxisLocation','top','YAxisLocation','right');
line(data('y'),data('Umean'),'Parent',ax2);
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
k = zeros(length(data('y+')),1);
for field = {'R_uu','R_vv','R_ww'}
    temp = data(field{1});
    k = k + temp / 2;
end
plot(data('y+'),k);
xlabel('y+');
ylabel('k');

% Plot dissipation.
figure();
plot(data('y+'),data('dissip'));
xlabel('y+');
ylabel('mean(u)');

