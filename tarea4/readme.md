# Tarea 4

## Como Correr

```bash
  make
  make run
```

Adicionalmente ```make compilemin```, ```make compilemax```,  ```make clean```.

## Archivos
 - ```Makefile``` : para ejecutar compilación y simulaciones.
 - ```modulos/``` : carpeta con los modulos de esta tarea.
   - ```    bitHolder.v``` : maneja las entradas y el estado de un bit.
   - ```registro4bits.v``` : es el registro(estructural) que simula el modelo conductual ya realizado.
   - ```ternarioDoble.v``` : representa una operacion ternaria doble.
 - ```pruebas/``` : carpeta con las pruebas de los modulos.
   - ```testbitHolder.v``` : prueba para el modulo ```bitHolder```[BASTANTE INCOMPLETA]
