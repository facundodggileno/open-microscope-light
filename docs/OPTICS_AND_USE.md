# Óptica y uso en microsoldadura

El sistema utiliza **cuatro fuentes separadas 90°**, no un aro de múltiples LEDs pequeños. Cada pod puede orientarse alrededor de un pivote M3 y cada COB puede apagarse individualmente para crear iluminación direccional.

## Propósito

- Facilitar inspección de pistas, pines y soldaduras sobre PCBs.
- Reducir reflejos molestos, conmutando fuentes que inciden en los ángulos de reflexión.
- Proporcionar brillo ajustable sin PWM de control intencional; no se ha cuantificado flicker óptico.
- Mantener ventilación pasiva alrededor de los disipadores.

## Ajuste recomendado

Primero colocar la motherboard a la distancia de trabajo habitual (en el diseño se consideraron aprox. **155 mm** desde el extremo del Barlow a la PCB). Ajustar cada pod con los cuatro encendidos. Observar un componente plano y uno reflectante.

Probar sucesivamente **4 COB**, **3 COB**, **2 opuestos**, **2 adyacentes** y un solo COB, y elegir según profundidad de sombras y reflejos de estaño. Encender todos no es necesariamente la mejor configuración para distinguir relieves.

El ángulo nominal CAD de **25°** es solo punto de partida; la geometría real de convergencia depende de montura, lente, altura y desplazamiento mecánico.

## Color y calidad

Los COB adquiridos se venden como **6000 K / Ra95**. Son afirmaciones del vendedor y no se midió espectro, temperatura de color ni CRI mediante instrumento calibrado. Si la precisión cromática es crítica, medir el lote con equipo apropiado.

No mirar directamente los COB potentes a corta distancia; evitar deslumbramiento y exposición prolongada innecesaria. La inspección con microscopio debe hacerse con iluminación confortable, no maximizando corriente por defecto.