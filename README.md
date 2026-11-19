# Direct Laser Writing & 3-Axis Opto-Mechanical Motion Stage

**Author:** [Sakshi Tandel](https://github.com/Saksh2024) (Indian Institute of Technology, Kharagpur)  
**Bachelor's Thesis:** *Development of Laser Writing Setup for Micro-Nano Surface Patterning and Characterization*

---

## 🔬 Overview

This repository contains the opto-mechanical design, embedded motion control firmware, and analytical spectroscopy toolchain for a precision **Direct Laser Writing (DLW)** micro-patterning system. The setup was designed and experimentally calibrated at IIT Kharagpur using a **pulsed picosecond Nd:YAG laser** ($1064\text{ nm} \rightarrow 532\text{ nm}$ SHG).

The system fabricates sub-micron surface trenches on semiconductor Silicon wafers and sol-gel synthesized $\text{TiO}_2$ dielectric thin films, evaluated via **Raman spectroscopy** to quantify localized crystal lattice strain and defect density.

---

## 🛠️ Hardware & Opto-Mechanical Architecture

```
[Picosecond Laser (532nm)] 
        │
        ▼ (4-DOF Kinematic Steering Mirrors)
[Spatial Iris Pinholes & Beam Expander]
        │
        ▼ (Objective Focusing Lens, f = 50mm)
[Sample on 3-Axis Precision Translation Stage]
        ▲
        │ (Rubber Couplers & Lead Screws)
[NEMA 17 Stepper Motors] ◄── [Arduino Uno + CNC Shield V3 + L298N Drivers]
```

1. **2-Tier Optical Setup:** Compact breadboard layout with kinematic 4-DOF mirror mounts, spatial filtering pinholes, and collimation optics maintaining $TEM_{00}$ beam profile.
2. **CAD & Circuit Prototyping:** 3-axis mechanical mounts modeled in **AutoCAD** and stepper motor driver circuitry prototyped in **TinkerCAD**.
3. **Vibration Damping:** Rubber vibration-damping couplers between stepper shafts and translation micrometers, eliminating mechanical vibration and backlash down to sub-micron step repeatability.

---

## 📈 Laser Physics & Material Characterization

* **Optical Fluence Parameterization:** Evaluated spot size ($w_0 \approx 5.2\text{ }\mu\text{m}$), Rayleigh range, and peak fluence ($F_0$) across repetition rates from 1 Hz to 1 kHz to prevent thermal heat accumulation and micro-cracking.
* **Raman Spectroscopy Analysis:** Lorentzian peak deconvolution of the crystalline Si optical phonon peak ($520.5\text{ cm}^{-1}$) in Origin and MATLAB, extracting peak shifts ($\Delta\omega$) and FWHM broadening to quantify residual biaxial strain.

---

## 📁 Repository Structure

```
├── firmware/
│   └── stepper_stage_control.ino   # Arduino CNC Shield serpentine raster control
├── matlab/
│   ├── beam_fluence_calc.m        # Gaussian beam optics & peak fluence solver
│   └── raman_peak_fitting.m       # Non-linear Lorentzian Raman deconvolution
└── README.md
```
