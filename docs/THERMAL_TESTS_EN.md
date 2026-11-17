# Thermal measurements, material limits and uncertainty

**Reference build:** RELIFE RL-M3T with four nominal 22 × 22 × 13 mm aluminium heatsinks and XIANGCLEAR 1311-5W COB modules, initially printed in **PLA** with aluminium tape over some supports.

| User-reported operating point | Duration | Measured LED heatsink surface |
|---|---|---|
| Knob at roughly 50% | **more than 1 hour** | **55–63 °C** |
| Knob at 100% | **around 10 minutes** | **~95 °C** |

The author reported **over one month of stable normal operation**. Room temperature, actual current during each test, plastic-contact temperature, LED junction temperature and MOSFET temperature were **not recorded** in the supplied results. We therefore do not claim a specific junction temperature or lifetime.

**PLA + aluminium tape:** the first prototype survived normal use; this does not certify maximum-power safety. PLA mechanical properties can deteriorate around its glass transition depending on formulation and load. Aluminium tape conducts heat and is **not a thermal insulator**.

**ABS/ASA/PC:** potential choices for a final print, but part temperature, layer bonding and material datasheet must be considered. Changing plastic alone does **not** cool the LEDs. For continuous full brightness, improve heatsinks, thermal interfaces, convection and/or lower the current.

**Recommendation:** reproduce the conservative reference driver limit (~190 mA/channel), measure temperature of both heatsink and printed holder after 10/30/60 minutes, and do **not** assume "50% knob" means 50% electrical power. Stop the test if a support distorts, wiring heats, odours develop or temperatures continue rising without stabilizing.