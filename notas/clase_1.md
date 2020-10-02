# Historia del cómputo paralelo.

Principales ventajas.
En CPUs se hablan de cientos de cores de procesamientos.
GPU habla de miles de cores de procesamientos.

Velocidad de GPU de cada core es menor que una CPU.


Súper computadoras.
Tipo de computadoras que tienen arquitectura, recursos y componentes para resolver problemas complejos y alcanzar cómputo masivo.

FLOPS

PCI Expres -> para transferir datos entre CPU y GPU

## Speedup y eficiencia -> métricas
Ts(n) tiempo de ejecución del problema A de forma serial.

Tp(n) tiempo de ejecución del problema A utilizando P procesadores.

S = Ts(n)/Tp(n) > S está entre 0 y P por la latencia.

F = S/P; E está entre 0 y 1.

Speedup lineal (nunca pasa): la eficiencia la vamos a obtener de manera proporcional al número de cores.

# Ley de Amdahl
"La mejora obtenida en el rendimiento de un sistema debido a la alteración de uno de sus componentes está limitada por la fracción de tiempo que...".

# Ley de Gustafston
Al incrementar el tamaño del problema, se decrementa la proporción serial del mismo.
(Entre más grande sea el problema, los algoritmos paralelos funcionan mejor).

NVLink -> bus de comunicaciones de envidia entre cpu y gpu (velocidad de 80/200) GB/s.

Nvidia Volta GPU -> arquitectura.


Programación en cuda

# Kernel de cuda
`
__global__ 
funcion()
`




SLURM (Simple Linux Utility for Resource Mnagement).

buena práctica nombrar variables así:
`d_nombrevariabledevice`

La mayoría soporta 1024 hilos por bloque, los hilos se pueden repartir entre bloques

Entre más bloques, más se calendariza (administra el recurso de forma menos eficiente)
Menor cantidad de bloques por mayor cantidad de hilos.

nombrefuncion_kernel<<<NUM_BLOQUES, NUM_HILOS_X_BLOQUE>>>(params ql host);


Buscar en los ejemplos vectorAdd

