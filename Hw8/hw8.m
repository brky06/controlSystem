clear all; clc;

M = 2.0;
m = 0.5;
l = 0.3;
g = 9.81;

numerator_coeff = -1 / (M * l);
denominator_s2 = 1;
denominator_s0 = -((M + m) * g) / (M * l);

num = [numerator_coeff];
den = [denominator_s2, 0, denominator_s0];

sys_tf = tf(num, den);

sys_tf

poles = pole(sys_tf)

if any(real(poles) > 0)
    disp('System is UNSTABLE because there is a pole in RHP.');
else
    disp('System is stable.');
end
