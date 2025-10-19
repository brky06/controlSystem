import sympy as sp
import numpy as np
import matplotlib.pyplot as plt

sp.init_printing()

t = sp.symbols('t', real=True, nonnegative=True)
s = sp.symbols('s', real=True)

u = sp.Heaviside

# Part 1: Differential Equations
results_de = []  # to collect (description, Y(s), y(t))

# DE #1: First-order LTI with step input
#   y'(t) + 3 y(t) = 2 u(t),  y(0) = 1
y = sp.Function('y')
ode1 = sp.Eq(sp.diff(y(t), t) + 3*y(t), 2*u(t))
y0_1 = 1

# Laplace transform side-by-side: we'll derive Y(s) symbolically
Y = sp.Function('Y')
# Laplace of y'(t) -> s*Y(s) - y(0)
Y_s = sp.symbols('Y_s')
# Using Sympy: Represent Laplace{y(t)} as Y_s symbol, then solve algebraically
Y_s_symbol = sp.Symbol('Y_s')

# Build equation in s-domain manually:
# L{y'} + 3 L{y} = 2 * 1/s  (since L{u(t)} = 1/s)
eq1_s = sp.Eq((s*Y_s_symbol - y0_1) + 3*Y_s_symbol, 2*(1/s))
sol1_Ys = sp.solve(eq1_s, Y_s_symbol)[0]

# Inverse Laplace to get y1(t)
y1_t = sp.inverse_laplace_transform(sol1_Ys, s, t)

results_de.append(("y'(t) + 3y(t) = 2u(t),  y(0)=1", sol1_Ys, sp.simplify(y1_t)))

# DE #2: Second-order with impulse input
#   y''(t) + 5 y'(t) + 6 y(t) = δ(t),  y(0)=0, y'(0)=0
ode2_desc = "y''(t) + 5y'(t) + 6y(t) = δ(t),  y(0)=0, y'(0)=0"
y0_2 = 0
ydot0_2 = 0

# Laplace: (s^2 Y - s y(0) - y'(0)) + 5 (s Y - y(0)) + 6 Y = 1  (since L{δ} = 1)
Y_s_symbol = sp.Symbol('Y_s_2')
eq2_s = sp.Eq((s**2*Y_s_symbol - s*y0_2 - ydot0_2) + 5*(s*Y_s_symbol - y0_2) + 6*Y_s_symbol, 1)
sol2_Ys = sp.solve(eq2_s, Y_s_symbol)[0]
y2_t = sp.inverse_laplace_transform(sol2_Ys, s, t)
results_de.append((ode2_desc, sol2_Ys, sp.simplify(y2_t)))

# DE #3: Undamped oscillator with sinusoidal forcing
#   y''(t) + 4 y(t) = sin(2 t),  y(0)=0, y'(0)=0
ode3_desc = "y''(t) + 4y(t) = sin(2t),  y(0)=0, y'(0)=0"
y0_3 = 0
ydot0_3 = 0

# Laplace: (s^2 Y - s y0 - ydot0) + 4 Y =  Laplace{sin(2t)} = 2/(s^2 + 4)
Y_s_symbol = sp.Symbol('Y_s_3')
eq3_s = sp.Eq((s**2*Y_s_symbol - s*y0_3 - ydot0_3) + 4*Y_s_symbol, 2/(s**2 + 4))
sol3_Ys = sp.solve(eq3_s, Y_s_symbol)[0]
y3_t = sp.inverse_laplace_transform(sol3_Ys, s, t)
results_de.append((ode3_desc, sol3_Ys, sp.simplify(y3_t)))

print("Part 1: Differential Equations -> Laplace domain and time-domain solutions\n")
for desc, Ys, yt_expr in results_de:
    print(f"DE: {desc}")
    print("Y(s) = ")
    sp.pprint(sp.simplify(Ys))
    print("y(t) = ")
    sp.pprint(sp.simplify(yt_expr))
    print("-"*80)
def plot_expression(expr, t_end, title):
    tt = np.linspace(0, t_end, 1000)
    f = sp.lambdify(t, expr, 'numpy')
    yy = f(tt)
    plt.figure()
    plt.plot(tt, yy)
    plt.title(title)
    plt.xlabel("t")
    plt.ylabel("Response")
    plt.grid(True)
    plt.show()

# For DE #1: first-order with step input typically settles ~ few time constants (1/3)
plot_expression(y1_t, 6.0, "DE1: y'(t)+3y=2u(t), y(0)=1")
# For DE #2: a stable 2nd-order with impulse input (poles at -2 and -3)
plot_expression(y2_t, 5.0, "DE2: y''+5y'+6y=δ(t), y(0)=0,y'(0)=0")
# For DE #3: resonance-like behavior since forcing frequency equals natural frequency (ω_n=2)
plot_expression(y3_t, 10.0, "DE3: y''+4y=sin(2t), y(0)=0,y'(0)=0")
F1 = 1/(s + 2)
F2 = 5/((s + 2)**2 + 9)       
F3 = (s + 1)/(s*(s + 3))      

f1_t = sp.inverse_laplace_transform(F1, s, t)
f2_t = sp.inverse_laplace_transform(F2, s, t)
f3_t = sp.inverse_laplace_transform(F3, s, t)

print(" Part 2: Inverse Laplace of selected S-domain functions")
for i, (F_expr, f_expr) in enumerate([(F1, f1_t), (F2, f2_t), (F3, f3_t)], start=1):
    print(f"F{i}(s) = ")
    sp.pprint(sp.simplify(F_expr))
    print("f{i}(t) = ")
    sp.pprint(sp.simplify(f_expr))
    print("-"*80)
plot_expression(f1_t, 5.0, "F1(s)=1/(s+2)  ->  f1(t)")
plot_expression(f2_t, 10.0, "F2(s)=5/((s+2)^2+9)  ->  f2(t)")
plot_expression(f3_t, 5.0, "F3(s)=(s+1)/(s(s+3))  ->  f3(t)")
