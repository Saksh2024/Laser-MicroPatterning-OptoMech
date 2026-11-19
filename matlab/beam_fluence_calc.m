%% Gaussian Beam Optics & Ablation Fluence Calculation
% Author: Sakshi Tandel (IIT Kharagpur)
% Laser: Pulsed picosecond Nd:YAG laser (532 nm Second Harmonic Generation)

clear; clc;

% Laser parameters
lambda = 532e-9;         % Wavelength: 532 nm (green)
focal_length = 50e-3;    % Lens focal length: 50 mm
beam_diam_input = 4.0e-3;% Input beam diameter: 4 mm (at 1/e^2)
pulse_energy = 50e-6;    % Pulse energy: 50 uJ
pulse_duration = 30e-12; % Pulse width: 30 ps
rep_rate = 1000;         % Repetition rate: 1 kHz

% Spot size at focus: w0 = (2 * lambda * f) / (pi * d)
w0 = (2 * lambda * focal_length) / (pi * beam_diam_input);
spot_area = pi * (w0^2);

% Rayleigh range: zR = pi * w0^2 / lambda
zR = (pi * (w0^2)) / lambda;

% Peak Fluence (J/cm^2): F0 = 2 * E_pulse / (pi * w0^2)
peak_fluence = (2 * pulse_energy) / (pi * (w0^2)) * 1e-4; % Convert to J/cm^2

% Peak Intensity (W/cm^2): I0 = F0 / tau_pulse
peak_intensity = peak_fluence / pulse_duration;

fprintf('=== Optical Beam Delivery Characteristics ===\n');
fprintf('Focused Beam Waist (w0): %.2f um\n', w0 * 1e6);
fprintf('Rayleigh Range (zR):      %.2f um\n', zR * 1e6);
fprintf('Peak Fluence (F0):        %.3f J/cm^2\n', peak_fluence);
fprintf('Peak Intensity (I0):      %.2e W/cm^2\n', peak_intensity);
