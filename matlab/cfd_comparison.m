function cfd_comparison(x, M_x, P_x, L_c, mach_file, pressure_file)

% Load Mach data
CFD   = readtable(mach_file);
x_CFD = CFD.X_m;
M_CFD = CFD.Mach;

% Align throats
[~, throat_idx]  = min(abs(M_CFD - 1.0));
x_throat_CFD     = x_CFD(throat_idx);
shift            = x_throat_CFD - L_c;
x_CFD_aligned    = x_CFD - shift;

% Clip
mask         = x_CFD_aligned >= 0;
x_CFD_plot   = x_CFD_aligned(mask);
M_CFD_plot   = M_CFD(mask);
matlab_mask  = x <= x_CFD_plot(end);

% Mach error
M_interp   = interp1(x_CFD_plot, M_CFD_plot, x(matlab_mask), 'linear', 'extrap');
err_M      = abs(M_interp - M_x(matlab_mask)) ./ M_x(matlab_mask) * 100;
disp("Mach Mean Error (divergent): "  + mean(err_M(x(matlab_mask) > L_c)) + "%")
disp("Exit Mach Error: " + abs(M_CFD(end) - 2.5) / 2.5 * 100 + "%")

% Mach plot
figure;
plot(x(matlab_mask), M_x(matlab_mask), 'b-', 'LineWidth', 2); hold on;
plot(x_CFD_plot, M_CFD_plot, 'r--', 'LineWidth', 2);
xlabel('x (m)'); ylabel('Mach Number');
title('Centerline Mach: MATLAB vs CFD (Inviscid)');
legend('MATLAB (Isentropic)', 'CFD (Inviscid)');
grid on;

% Load Pressure data
CFD_P        = readtable(pressure_file);
x_CFD_P      = CFD_P.X_m - shift;
P_CFD        = CFD_P.Pressure_Pa;
mask_P       = x_CFD_P >= 0;
x_CFD_P_plot = x_CFD_P(mask_P);
P_CFD_plot   = P_CFD(mask_P);
matlab_mask_P = x <= x_CFD_P_plot(end);

% Pressure error
P_interp  = interp1(x_CFD_P_plot, P_CFD_plot, x(matlab_mask_P), 'linear', 'extrap');
err_P     = abs(P_interp - P_x(matlab_mask_P)) ./ P_x(matlab_mask_P) * 100;
disp("Pressure Mean Error (divergent): " + mean(err_P(x(matlab_mask_P) > L_c)) + "%")

P_exit_CFD = P_CFD_plot(end);
disp("Exit Pressure Error: " + abs(P_exit_CFD - P_x(end)) / P_x(end) * 100 + "%" + ...
    "  (CFD: " + P_exit_CFD + " Pa, MATLAB: " + P_x(end) + " Pa)")

% Pressure plot
figure;
plot(x(matlab_mask_P), P_x(matlab_mask_P), 'b-', 'LineWidth', 2); hold on;
plot(x_CFD_P_plot, P_CFD_plot, 'r--', 'LineWidth', 2);
xlabel('x (m)'); ylabel('Static Pressure (Pa)');
title('Centerline Pressure: MATLAB vs CFD (Inviscid)');
legend('MATLAB (Isentropic)', 'CFD (Inviscid)');
grid on;

end