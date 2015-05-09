function [ dy ] = ode_a12_SKE(Sstartau,y)

global i A

Cmu = 0.09;
Sstar = 3.3;
Ce1 = 1.44;
Ce2 = 1.92;

k = y(1);
e = y(2);

a12 = -Cmu * (k / e) * Sstar * sin(A(i) * Sstartau);
dy = zeros(2,1);
dy(1) = -k * a12 * Sstar * sin(A(i) * Sstartau) - e;
dy(2) = -Ce1 * e * a12 * Sstar * sin(A(i) * Sstartau) - Ce2 * e^2 / k;

end
