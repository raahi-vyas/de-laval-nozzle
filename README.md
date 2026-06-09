# Isentropic Nozzle Flow Validation: 1D Theory vs. 2D Inviscid CFD
A MATLAB and ANSYS Fluent pipeline validating 1D isentropic flow theory against 2D inviscid CFD for a conical convergent-divergent nozzle. Boundary conditions were derived from the NASA GRC Mach 2.5 axisymmetric MOC nozzle (Davis, 2015).

## Features
- Isentropic flow relations: Mach, pressure, temperature, and area ratio from stagnation conditions
- Area-Mach equation solved implicitly for both subsonic and supersonic regions
- Choked mass flow rate validated against NASA GRC paper (< 1% error)
- Conical nozzle geometry:
  - 30° convergent, 15° divergent half-angles
  - Inlet = exit diameter (NASA constraint)
- ANSYS Fluent:
  - 2D axisymmetric, inviscid flow, density-based solver
  - First-order upwind calculation converged in 2,500 iterations to residuals of ~10⁻³
- Throat coordinate alignment between MATLAB and CFD x-axes
- Percent error computed over divergent section, with centerline overlay plots

## Geometry
The nozzle was modeled in SolidWorks to validate precise geometry before import into ANSYS for meshing. Dimensions were computed analytically from isentropic flow relations in MATLAB and transferred directly into the CAD model.

## Setup
1. Clone the repo
2. Open MATLAB and add `/matlab` to path
3. Update CFD CSV paths in `main.m` to point to your exported centerline data
4. Run: `main.m`

## Centerline Validation Results

| Metric | MATLAB (Theory) | CFD (Inviscid) | Error |
|---|---|---|---|
| Exit Mach Number | 2.500 | 2.553 | 2.10% |
| Exit Static Pressure | 13,812.5 Pa | 11,479.6 Pa | 16.89% |
| Mach Mean Error (divergent) | N/A | N/A | 5.33% |
| Pressure Mean Error (divergent) | N/A | N/A | 16.00% |

## Physical Explanation of Error
The 5.3% Mach and 16% pressure errors over the divergent section are physically expected for a conical nozzle. 1D isentropic theory assumes perfectly uniform, area-averaged flow, while 2D CFD resolves oblique expansion waves that emanate from the divergent wall as a direct consequence of the conical geometry. These waves create non-uniform radial pressure gradients that the centerline captures but 1D theory cannot. Pressure is more sensitive to local wave structure than Mach number, which is why pressure error is significantly higher. An MOC contour nozzle eliminates these waves by solving the wall profile for perfectly axial, shock-free flow, further reducing Mach and pressure errors.

## Mesh Quality

| Metric | Min | Max |
|---|---|---|
| Skewness | 0.00177 | 0.338 |
| Aspect Ratio | 1.000 | 15.17 |

## Project Structure
```
de-laval-nozzle/
├── matlab/
│   ├── main.m
│   ├── nozzle_geometry.m
│   ├── mach_distribution.m
│   └── cfd_comparison.m
├── geometry/
│   ├── nozzle.SLDPRT
│   └── nozzle_drawing.png
├── cfd/
│   ├── centerline_mach.csv
│   ├── centerline_pressure.csv
│   ├── mach_contour.png
│   ├── pressure_contour.png
│   ├── mesh_skewness.png
│   ├── mesh_aspect_ratio.png
│   └── residuals_convergence.png
└── results/
    ├── centerline_mach_comparison.png
    └── centerline_pressure_comparison.png
```

## Skills Demonstrated
**Aerospace / Fluid Dynamics:** De Laval nozzle theory, isentropic flow relations, choked flow, Area-Mach relation, conical nozzle geometry, mass flow rate calculation

**CFD:** ANSYS Fluent setup (2D axisymmetric, inviscid, density-based), boundary condition back-calculation from reference data, mesh quality assessment, residual convergence

**MATLAB:** Modular function architecture, isentropic relations, implicit nonlinear equation solving, piecewise domain construction (subsonic/supersonic regions), theoretical and experimental coordinate alignment, interpolation-based percent error analysis

**CAD (SolidWorks):** Parametric part modeling with global variables, fully constrained sketches, revolve and shell features, dimensioned 2D drawing file

**Tools:** MATLAB, ANSYS Fluent, SolidWorks
