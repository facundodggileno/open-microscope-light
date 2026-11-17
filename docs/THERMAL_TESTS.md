# Ensayos térmicos — datos medidos en el prototipo

**Montaje:** RELIFE RL-M3T, cuatro COB XIANGCLEAR con disipadores de aluminio nominales de 22 × 22 × 13 mm. Estructura inicial impresa en **PLA**, con cinta de aluminio cubriendo apoyos locales.

| Estado de control | Duración del ensayo | Temperatura medida de disipadores |
|---|---|---|
| ~50% de la perilla | **más de 1 hora** | **55–63 °C** |
| 100% de la perilla | **unos 10 minutos** | **~95 °C** |

El autor informó **más de un mes de uso estable** del prototipo. Estas son observaciones reales, no simulaciones. No se comunicaron temperatura ambiente, corriente exacta durante ambas pruebas, temperatura de soporte de PLA, Tj de los COB ni metodología de sensor; **no deben inferirse datos no medidos**.

## Qué significan esos resultados

- La temperatura de unión (**Tj**) es superior a la del disipador durante la disipación. No conocemos la resistencia térmica real del COB genérico ni la temperatura de juntura; asignar una Tj exacta no está justificado.
- El PLA puede perder rigidez alrededor de la zona de transición vítrea según formulación, carga mecánica y estructura impresa; que haya sobrevivido un mes **no demuestra seguridad al máximo**.
- La cinta de aluminio **conduce calor**: puede reflejar radiación y distribuir temperatura, pero no funciona como aislante térmico eficaz entre metal caliente y plástico.
- ABS/ASA o PC permiten más margen térmico mecánico que un PLA típico, pero la resistencia depende de la pieza, el fabricante, la orientación, la adhesión de capas y temperatura local.
- Reimprimir en un material más resistente **no mejora la refrigeración del LED**. Para uso continuo a máxima corriente, rediseñar la disipación y/o disminuir potencia.

## Recomendación para otros constructores

1. Empezar por un límite de corriente menor, como el diseño de referencia de ~**190 mA por canal**.
2. Probar a brillo de uso real y medir temperaturas del LED, del disipador y **del plástico donde apoyan**; anotar tiempo, ambiente y corriente.
3. Evitar uso permanente a 100% con los disipadores originales. La observación a ~95 °C en 10 min es razón suficiente para establecer esta cautela.
4. No fijar límites universales de temperatura sin especificaciones fiables de LED y filamento. Consultar fichas técnicas de los materiales.
5. Desenergizar ante deformación, olor, pérdida de contacto térmico o aumento de temperatura no controlado.

Para objetivos de operación profesional, registrar ensayos prolongados y construir margen térmico sobre el ambiente más caluroso esperado.