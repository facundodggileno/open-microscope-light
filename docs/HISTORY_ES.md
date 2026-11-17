# Historia del desarrollo

## Problema de origen

Se buscó mejorar la iluminación para reparación de placas y microsoldadura, manteniendo buen contraste, alto CRI declarado, menor fatiga ocular y control fino de brillo, con geometría compatible con RELIFE RL-M3T. Se exploró inicialmente una solución tipo aro con 28 emisores; finalmente se descartó a favor de **cuatro módulos COB** orientables, con apagado independiente.

## Electrónica

Se seleccionaron COB XIANGCLEAR 1311-5W y un driver analógico de corriente basado en **MCP6004, 4 × IRLZ44N, TL431A, 78L05 y B10K**. Se contempló la disipación en cada MOSFET y el efecto de usar fuentes de notebook ~19V para reducir la diferencia de tensión frente a los COB.

La placa de control se construyó y quedó funcional. **No existe en los archivos recuperados un netlist final certificado** de esa placa; el documento de cableado es una **implementación propuesta** basada en su arquitectura.

## CAD

La primera medición usada para el aro resultó incorrecta (**103 mm de diámetro interior**). Posteriormente se corrigió a **63 mm**, con **83 mm de diámetro exterior** para la V0.20.

El desarrollo incluyó la sustitución de un puente que interfería en la horquilla, corrección del pivote del brazo, extensión de brazo, cuidado para que los tornillos radiales no coincidieran con fijación de brazos y eliminación de salientes que bloqueaban la introducción del disipador.

La configuración final se estabilizó con **4 LEDs a 90°**, fase de **65°**, agujeros radiales de **3,7 mm** y tres tornillos a **20/125/275°**.

## Prototipo y temperatura

Se imprimió una unidad funcional en **PLA** con cinta de aluminio local, se instaló en el microscopio y se usó más de un mes. Con control en torno al 50% se midieron **55–63 °C tras más de 1 h**. Al máximo el disipador llegó a **~95 °C tras ~10 min**. Estos datos se mantienen publicados, sin inferir una temperatura de juntura numérica no medida.

## Integridad del registro

Los commits de versiones de este repositorio fueron creados **durante la publicación** al importar snapshots originales. No deben interpretarse como las fechas originales de diseño. Los .scad históricos disponibles empiezan en **V0.6**, no hay archivos encontrados con nombres V0.1–V0.5. Se conserva cada archivo de revisión recuperado en [cad/history](../cad/history/).

Las ilustraciones antiguas se consideran históricas, y no constituyen esquemas de cableado auditados.

## Material gráfico original

Se han incorporado las imágenes originales sin remuestreo, incluyendo la [lámina eléctrica histórica 1536 × 1024](historical/historical-electrical-poster-original.png) y la [ilustración mecánica 1448 × 1086](historical/microscope-mechanical-concept-original.png). La lámina eléctrica es material de exploración, **no un plano verificado de la placa final**. La fotografía real del montaje se publicó con sus **900 × 1600 píxeles** originales.
