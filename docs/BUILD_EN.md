# OpenMicroscope Light — step-by-step build guide

This project started as a working prototype for a **RELIFE RL-M3T** stereo microscope, using a 0.5× Barlow lens. The final author-validated head is **V0.20**. It has been used for **over one month** at normal brightness. The prototype was printed in PLA, but this does **not** certify it as safe for high-temperature continuous operation.

## What you need

- Four **XIANGCLEAR 1311-5W** LED COBs, seller-advertised 6000 K and Ra95 (not independently verified).
- Four aluminium heatsinks, nominally **22 × 22 × 13 mm**.
- FDM printer, filament, callipers, OpenSCAD and suitable mounting hardware.
- **Three roughly M4 × 23 mm** radial screws to secure the ring around the objective/Barlow.
- Four **M3** pivot screws and four M3 arm-retention fasteners, washers/nuts suited to printed geometry.
- Thermally conductive compound / fastening appropriate to the COB and heatsink, insulated flexible wire and strain relief.
- A separately housed analog current controller, ~19 V **isolated** DC notebook power supply, multimeter and preferably a current-limited bench supply.

## 1. Measure your microscope first

The actual Barlow barrel in the reference setup was approximately **50 mm in diameter**, clamped by three radial screws inside the **63 mm ID** ring. The ring's outside diameter is **83 mm** and height **8 mm**. The 155 mm Barlow-to-PCB working distance was a design reference, not a fixed requirement of your microscope.

**Do not copy the 103 mm ID of the early archived CAD:** that figure was based on a measurement error.

## 2. Inspect and export the CAD

Open [V0.20 source](../cad/current/microscope_led_head_v020.scad) in OpenSCAD. Review dimensions for your barrel, heatsink and screws. The source is parametric; the final tested nominal values are documented in [CAD_GUIDE.md](CAD_GUIDE.md).

Set the **part** variable to **"ring"**, **"arm"** or **"pod"** and press F6, then export the STL. Alternatively use [prebuilt V0.20 STLs](../cad/stl/) produced by GitHub Actions.

Print **one ring, four arms and four pods**. Test-print one pod and check that its 22 mm heatsink slides freely before committing to all four. Typical starting print settings (not universally validated): 0.16–0.20 mm layer height, ~4 walls and 30–50% infill. Print orientation, overhang support and material shrinkage must be inspected in your slicer.

**Material choice:** the original prototype was PLA with aluminium tape over some supports. For a final part, **ABS/ASA or polycarbonate** are options if your printer can process them, but they require proper part-temperature testing. Aluminium tape **does not thermally insulate** against a hot heatsink.

## 3. Mechanical assembly

1. Place the ring on the Barlow without contacting optical glass. Tighten the **three radial screws** gradually and evenly.
2. Insert four arms into the ring's pockets, each separated by 90°. Retain with M3 screws.
3. Join each arm to its pod: the **arm's central cylindrical pivot must fit between the two fork ears** of the pod. Insert the M3 pivot and adjust friction without cracking the print.
4. Slide each aluminium heatsink into the pod's rails, ensuring no protrusions block its movement. The V0.18 revision removed interfering tabs.
5. Attach a COB to each heatsink using a proper thermal interface. Insulate terminals from heatsink metal when necessary.
6. Route flexible wires with slack around hinges and provide strain relief. Do not allow the wires to rub on the hot heatsinks or block the optical path.

## 4. Electronics

Follow [WIRING_EN.md](../hardware/WIRING_EN.md), the pinout reference and the [first-power-up guide](COMMISSIONING.md). The published design is a **proposed reproducible electrical implementation**, not a measured as-built netlist for the author's functional perfboard.

Test **one current-limited channel at a time**. Begin around **190 mA** per COB, NOT at the original prototype's full-power region (~340–350 mA/channel). The MOSFET TO-220 tab is electrically tied to DRAIN.

## 5. Aiming and temperature checks

With a real PCB under the microscope, rotate the four pods to illuminate the working area. The nominal CAD tilt is 25°, but pivot angle must be adjusted for your actual working distance. Try all four LEDs, three LEDs and pairs of opposite or adjacent emitters to control glare on solder joints.

Measure shunt voltage/current and heatsink **and printed support temperatures** at 10/30/60 minutes at the intended brightness, including the warmest expected room conditions. The original prototype reported:

| Setting | Duration | LED heatsink temperature |
|---|---|---|
| ~50% knob | >1 hour | **55–63 °C** |
| 100% knob | ~10 minutes | **~95 °C** |

Do **not** operate these small heatsinks continuously at full brightness without redesigning their thermal capacity and checking the COB junction-temperature limits. The knob percentage does not necessarily represent a calibrated power or current percentage.

## 6. Maintenance

Inspect clamping screws, hinge retention, heatsink adhesion, electrical insulation and cable strain relief periodically. If operating current or print material is changed, re-run the thermal checks. For full technical details and uncertainties, see [thermal data](THERMAL_TESTS_EN.md).