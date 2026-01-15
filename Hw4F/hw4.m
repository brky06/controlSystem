clear all; close all; clc;

num = [1];
den = [1 10 20];
G = tf(num, den);

Kp = 350;
Ki = 300;
Kd = 50;

C = pid(Kp, Ki, Kd);

sys_cl = feedback(C*G, 1);

t = 0:0.01:2;
figure;
step(sys_cl, t);
title('Step Response with Designed PID');
grid on;
