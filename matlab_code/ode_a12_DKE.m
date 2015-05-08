function [ dy ] = ode_a12_DKE(Sstartau,y)

global i A

Sstar = 3.3;
Ce1 = 1.44;
Ce2 = 1.92;
C1 = 1.5;
C2 = 0.8;

k = y(1);
e = y(2);
a12 = y(3);

alpha1 = -(k * a12 / e) * Sstar * sin(A(i) * Sstartau) - 1 + C1;
alpha2 = C2 - (4/3);
dy = zeros(3,1);
dy(1) = -k * a12 * Sstar * sin(A(i) * Sstartau) - e;
dy(2) = -Ce1 * e * a12 * Sstar * sin(A(i) * Sstartau) - Ce2 * e^2 / k;
dy(3) = -alpha1 * (e / k) * a12 + 0.5*alpha2 * Sstar * sin(A(i) * Sstartau);

end

