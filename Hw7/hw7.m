clc;
clear;
close all;

m = 10;
b = 2;

s = tf('s');
G = 1 / (m*s^2 + b*s);

Kp = 30;
Ki = 10;
Kd = 5;

C = pid(Kp, Ki, Kd);

T = feedback(C*G, 1);

t = 0:0.01:10;

figure;

subplot(3,1,1);
step(T, t);
title('Step Response');
grid on;

subplot(3,1,2);
impulse(T, t);
title('Impulse Response');
grid on;

subplot(3,1,3);
u = t;
lsim(T, u, t);
title('Ramp Response');
grid on;
