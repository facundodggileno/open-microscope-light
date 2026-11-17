# Puesta en marcha y validación

**Primera alimentación:** solo en banco con herramientas y fuente DC de calidad, preferentemente limitable. El circuito documentado es una **referencia** y requiere comprobaciones; no presupongas que copiar una placa perforada garantiza seguridad.

## Sin conectar COB

1. Inspeccionar soldaduras, polaridad, puentes y protección de entrada.
2. Verificar entrada nominal de fuente ~19 V DC y masa común.
3. Verificar salida 78L05 ~**5 V**.
4. Verificar TL431 ~**2,495 V** en K/REF y correcto sesgo de corriente.
5. Con el divisor conservador de referencia, medir en cursor B10K de 0 V a ~**0,192 V**.
6. Con cada SW abierto, comprobar que la entrada **(+)** respectiva del MCP6004 esté próxima a 0 V.
7. Confirmar patas MCP6004, TL431, 78L05 e IRLZ44N según **datasheets del encapsulado real**.

## Conectar un canal

1. Alimentar un COB con límite inicial bajo.
2. Medir caída en la resistencia shunt de 1 Ω: **0,10 V equivale a ~100 mA; 0,19 V equivale a ~190 mA**.
3. Girar el potenciómetro despacio y verificar variación suave, sin oscilaciones ni sobrecorrientes.
4. Medir temperatura del MOSFET y disipador, y revisar el contacto térmico COB/metal.
5. Repetir con cada uno de los otros canales, uno a la vez. Comparar diferencias de corriente y de temperatura.

## Ensayo completo

Registrar condiciones de forma reproducible:

| Tiempo | Corriente por COB | Temperatura disipador | Temperatura soporte | Observaciones |
|---|---|---|---|---|
| inicial | medir | medir | medir | brillo y cableado |
| 10 min | medir | medir | medir | olor/deformación |
| 30 min | medir | medir | medir | estabilidad |
| 60 min | medir | medir | medir | uso continuo |

No usar una lectura de porcentaje de perilla como porcentaje real de potencia si no está calibrada. En el prototipo los disipadores llegaron a **~95 °C después de 10 min al 100%**: no mantener ese nivel continuamente con la disipación documentada.

## Flicker

Aunque el driver no aplique PWM intencional, su alimentación y regulación pueden causar ripple. Para verificarlo usar un **fotodiodo + osciloscopio** observando la modulación óptica en diversos ajustes y, si fuera posible, contrastar fuente de alimentación diferente. La ausencia de parpadeo visible **no es medición de flicker**.

**Detener el ensayo** si aparece olor, ablandamiento del soporte, desconexión, incremento térmico sin estabilización, sobretensión, o cable en contacto con disipador caliente.