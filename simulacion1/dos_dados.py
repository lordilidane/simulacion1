def imprimir(vector):
    for x in vector:
        print x

def sumar(vector):
    total = 0
    for x in vector:
        
        total += x
    return total
    
def promedio(vector):
    sum_vector = sumar(vector)
    promedio = float(sum_vector) / len(vector)
    return promedio

# Para calcular la varianza restamos a cada puntancion la media y 
# los sumamos, lo elevamos al cuadrado y lo divimos entre 2
def varianaza(scores, promedio):
    sumatorio = 0
    for data in scores:
        sumatorio += (promedio - float(data))**2
    variance = float(sumatorio)/len(scores)
    return variance



def combinaciones(dado1,dado2):
    aux = []
    for x in range(1,dado1):
        for y in range(1,dado2):
            aux.append(x+y)
    #print(aux)
    return aux
                    
carasDado1 = 8
carasDado2 = 13

aux = combinaciones(carasDado1,carasDado2)
promedio = promedio(aux)
print('mediana')
print(promedio)
print('varianza')
print(varianaza(aux,promedio))
