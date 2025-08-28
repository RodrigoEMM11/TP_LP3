#include <stdio.h>
#include <stdlib.h>
#include "reciprocal.hpp"

int main(int argc, char **argv) {
	if (argc < 2) {  
        printf("Error: Debe ingresar un argumento valido.\n");
        printf("Uso: %s <numero>\n", argv[0]);
        return 1;  // Salida con error
    }
	
	printf("***main del listing-1.2***\n\nrealiza el reciproco de el valor ingresado al cuadrado\n\n");
	
	int i;
	i = atoi(argv[1]);
	
	if (i == 0) {
        printf("Error: No se puede calcular el reciproco de 0.\n");
        return 1;
    }
	
	printf("The reciprocal of %d is %g\n", i*i, reciprocal(i*i));
	return 0;
}
