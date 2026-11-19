%% Raman Spectroscopy Peak Fitting & Lattice Strain Analysis
% Author: Sakshi Tandel
% Analyzes the optical phonon peak (Si 520.5 cm^-1 or TiO2 anatase mode)

clear; clc;

% Synthetic Raman spectrum around Si crystalline peak (520.5 cm^-1)
wavenumber = linspace(490, 550, 600)';
true_peak = 520.5;
true_gamma = 3.8; % FWHM in cm^-1
% Lorentzian line shape: I(w) = A / (1 + ((w - w0)/(gamma/2))^2)
intensity_clean = 1000 ./ (1 + ((wavenumber - true_peak) / (true_gamma / 2)).^2);
noise = 15 * randn(size(wavenumber));
intensity = intensity_clean + noise + 50; % with background

% Initial parameter guesses: [Amplitude, Center, Gamma, Baseline]
beta0 = [1000, 520.0, 4.0, 50];

% Lorentzian model function
lorentzian_model = @(b, x) b(4) + (b(1) ./ (1 + ((x - b(2)) / (b(3) / 2)).^2));

% Non-linear least-squares curve fitting
beta_fit = nlinfit(wavenumber, intensity, lorentzian_model, beta0);

fitted_center = beta_fit(2);
fitted_fwhm = abs(beta_fit(3));

% Strain calculation: Delta_omega = omega_strained - omega_unstrained
delta_omega = fitted_center - 520.5;
% Residual biaxial stress sigma (MPa) ~ -250 * Delta_omega
stress_mpa = -250.0 * delta_omega;

fprintf('=== Raman Spectroscopy Fitting Results ===\n');
fprintf('Fitted Raman Peak Center: %.2f cm^-1\n', fitted_center);
fprintf('Fitted FWHM (Phonon Lifetime): %.2f cm^-1\n', fitted_fwhm);
fprintf('Phonon Peak Shift (Delta w): %.3f cm^-1\n', delta_omega);
fprintf('Estimated Lattice Stress: %.1f MPa\n', stress_mpa);
