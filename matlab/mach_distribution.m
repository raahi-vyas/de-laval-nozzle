function [x, M_x, P_x, T_x] = mach_distribution(r_t, A_t, r_i, L_c, L_d, k, T_0, P_0)

area_mach = @(M) (1/M) * ((2/(k+1)) * (1 + ((k-1)/2)*M^2))^((k+1)/(2*(k-1)));

% Divergent section
x_d   = linspace(0, L_d, 100); x_d = x_d(2:end);
r_d   = r_t + (x_d * tan(deg2rad(15)));
E_d   = pi * r_d.^2 / A_t;
M_x_d = zeros(size(E_d));
for j = 1:length(E_d)
    M_x_d(j) = fsolve(@(M) area_mach(M) - E_d(j), 2);
end
T_d = T_0 ./ (1 + ((k-1)/2) * M_x_d.^2);
P_d = P_0 ./ ((1 + ((k-1)/2) * M_x_d.^2).^(k/(k-1)));

% Convergent section
x_c   = abs(linspace(-L_c, 0, 100));
r_c   = r_t + (x_c * tan(deg2rad(30)));
E_c   = pi * r_c.^2 / A_t;
M_x_c = zeros(size(E_c));
for j = 1:length(E_c)
    M_x_c(j) = fsolve(@(M) area_mach(M) - E_c(j), 0.1);
end
T_c = T_0 ./ (1 + ((k-1)/2) * M_x_c.^2);
P_c = P_0 ./ ((1 + ((k-1)/2) * M_x_c.^2).^(k/(k-1)));

% Combine
x   = [linspace(0, L_c, length(x_c)),  linspace(L_c, L_c+L_d, length(x_d))];
M_x = [M_x_c, M_x_d];
T_x = [T_c,   T_d];
P_x = [P_c,   P_d];

end