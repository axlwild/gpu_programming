Operaciones matriciales.

No podemos reservar memoria en dos dimensiones.

TODO: Revisar cuántos hilos por bloque.


# Hilos
Los hilos tiene mecanismos de comunicación y sincronización.

En CUDA se tratan con eventos.
Si no se incluye la latencia de comunicación se asume que los tiempos...

calendarizando un hilo por cada bloque
Se obtiene casi el mismo rendimiento que la implementación serial