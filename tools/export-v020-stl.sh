#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p cad/stl
for part in ring arm pod; do
  openscad -o "cad/stl/${part}_v020.stl" -D "part=\"${part}\"" cad/current/microscope_led_head_v020.scad
done
echo "Exported cad/stl/{ring,arm,pod}_v020.stl"
