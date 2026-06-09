function [r_t, A_t, r_i, L_c, L_d, L, E, P_e, T_e, m_dot] = nozzle_geometry(M_e, r_e, k, T_0, P_0, R)

M_t = 1;
A_e = pi * r_e^2;
r_i = r_e;

% Exit conditions
T_e = T_0 / (1 + ((k-1)/2) * M_e^2);
P_e = P_0 * (1 + ((k-1)/2) * M_e^2)^(-k/(k-1));

% Throat geometry
E   = (M_t/M_e) * sqrt(((1 + (k-1)/2*M_e^2) / (1 + (k-1)/2*M_t^2))^((k+1)/(k-1)));
A_t = A_e / E;
r_t = sqrt(A_t / pi);

% Lengths
L_d = (r_e - r_t) / tan(deg2rad(15));
L_c = (r_i - r_t) / tan(deg2rad(30));
L   = L_c + L_d;

% Mass flow rate
m_dot = (P_0 * A_t) / sqrt(T_0) * sqrt(k/R) * (2/(k+1))^((k+1)/(2*(k-1)));

end