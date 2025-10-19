clc;
clear;
close all;

syms t s y(t) Ys

disp('Bölüm 1: Diferansiyel Denklemler -> Laplace domeni ve zaman domeni çözümleri');
disp(repmat('-', 1, 80));

ode1 = diff(y(t), t) + 3*y(t) == 2*heaviside(t);
y0_1 = 1;
L_ode1 = laplace(ode1, t, s);
L_ode1_sub = subs(L_ode1, {laplace(y(t), t, s), y(0)}, {Ys, y0_1});
sol1_Ys = solve(L_ode1_sub, Ys);
y1_t = ilaplace(sol1_Ys, s, t);

desc1 = "y'(t) + 3y(t) = 2u(t), y(0)=1";
disp("DE: " + desc1);
disp("Y(s) = ");
pretty(simplify(sol1_Ys));
disp("y(t) = ");
pretty(simplify(y1_t));
disp(repmat('-', 1, 80));

ode2 = diff(y(t), t, 2) + 5*diff(y(t), t) + 6*y(t) == dirac(t);
y0_2 = 0;
ydot0_2 = 0;
L_ode2 = laplace(ode2, t, s);
L_ode2_sub = subs(L_ode2, {laplace(y(t), t, s), y(0), subs(diff(y(t), t), t, 0)}, {Ys, y0_2, ydot0_2});
sol2_Ys = solve(L_ode2_sub, Ys);
y2_t = ilaplace(sol2_Ys, s, t);

desc2 = "y''(t) + 5y'(t) + 6y(t) = δ(t), y(0)=0, y'(0)=0";
disp("DE: " + desc2);
disp("Y(s) = ");
pretty(simplify(sol2_Ys));
disp("y(t) = ");
pretty(simplify(y2_t));
disp(repmat('-', 1, 80));

ode3 = diff(y(t), t, 2) + 4*y(t) == sin(2*t);
y0_3 = 0;
ydot0_3 = 0;
L_ode3 = laplace(ode3, t, s);
L_ode3_sub = subs(L_ode3, {laplace(y(t), t, s), y(0), subs(diff(y(t), t), t, 0)}, {Ys, y0_3, ydot0_3});
sol3_Ys = solve(L_ode3_sub, Ys);
y3_t = ilaplace(sol3_Ys, s, t);

desc3 = "y''(t) + 4y(t) = sin(2t), y(0)=0, y'(0)=0";
disp("DE: " + desc3);
disp("Y(s) = ");
pretty(simplify(sol3_Ys));
disp("y(t) = ");
pretty(simplify(y3_t));
disp(repmat('-', 1, 80));

figure;
fplot(y1_t, [0, 6]);
title("DE1: y'(t)+3y=2u(t), y(0)=1");
xlabel("t");
ylabel("Response");
grid on;

figure;
fplot(y2_t, [0, 5]);
title("DE2: y''+5y'+6y=δ(t), y(0)=0,y'(0)=0");
xlabel("t");
ylabel("Response");
grid on;

figure;
fplot(y3_t, [0, 10]);
title("DE3: y''+4y=sin(2t), y(0)=0,y'(0)=0");
xlabel("t");
ylabel("Response");
grid on;

F1 = 1/(s + 2);
F2 = 5/((s + 2)^2 + 9);
F3 = (s + 1)/(s*(s + 3));

f1_t = ilaplace(F1, s, t);
f2_t = ilaplace(F2, s, t);
f3_t = ilaplace(F3, s, t);

disp('Bölüm 2: Seçilen S-domeni fonksiyonlarının ters Laplace dönüşümü');

disp(repmat('-', 1, 80));
disp("F1(s) = ");
pretty(simplify(F1));
disp("f1(t) = ");
pretty(simplify(f1_t));
disp(repmat('-', 1, 80));

disp("F2(s) = ");
pretty(simplify(F2));
disp("f2(t) = ");
pretty(simplify(f2_t));
disp(repmat('-', 1, 80));

disp("F3(s) = ");
pretty(simplify(F3));
disp("f3(t) = ");
pretty(simplify(f3_t));
disp(repmat('-', 1, 80));

figure;
fplot(f1_t, [0, 5.0]);
title('F1(s)=1/(s+2) -> f1(t)');
xlabel("t");
ylabel("Response");
grid on;

figure;
fplot(f2_t, [0, 10.0]);
title('F2(s)=5/((s+2)^2+9) -> f2(t)');
xlabel("t");
ylabel("Response");
grid on;

figure;
fplot(f3_t, [0, 5.0]);
title('F3(s)=(s+1)/(s(s+3)) -> f3(t)');
xlabel("t");
ylabel("Response");
grid on;
