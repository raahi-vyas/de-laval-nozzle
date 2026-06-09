clc, clearvars

% --- Inputs ---
M_e = 2.5;
r_e = 0.085;
k   = 1.4;
T_0 = 300;
P_0 = 236000;
R   = 8.314 / (28.966e-3);

% --- Run ---
[r_t, A_t, r_i, L_c, L_d, L, E, P_e, T_e, m_dot] = nozzle_geometry(M_e, r_e, k, T_0, P_0, R);
[x, M_x, P_x, T_x] = mach_distribution(r_t, A_t, r_i, L_c, L_d, k, T_0, P_0);
cfd_comparison(x, M_x, P_x, L_c, ...
    '/Users/raahiv/Desktop/De Laval Nozzle Analysis/cfd/centerline_mach.csv', ...
    '/Users/raahiv/Desktop/De Laval Nozzle Analysis/cfd/centerline_pressure.csv');

% --- Print Specs ---
disp("Inlet Radius: "    + r_i   + newline + "Exit Radius: "  + r_e + ...
    newline + "Throat Radius: " + r_t   + newline + ...
    "Convergent Length: " + L_c + newline + "Divergent Length: " + L_d)
disp("Inlet Pressure: "  + P_0   + newline + "Exit Pressure: " + P_e)
disp("Mass Flow Rate: "  + m_dot)
disp("Overall Nozzle Length: " + L)