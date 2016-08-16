def print_grades(grades):
    for grade in grades:
        print grade

def grades_sum(grades):
    total = 0
    for grad in grades:
        print(grad)
        total += grad
    return total
    
def grades_promedio(grades):
    sum_of_grades = grades_sum(grades)
    average = float(sum_of_grades) / len(grades)
    return average

# Para calcular la varianza restamos a cada puntancion la media y 
# los sumamos, lo elevamos al cuadrado y lo divimos entre 2
def grades_variance(scores, average):
    sumatorio = 0
    for data in scores:
        sumatorio += (average - float(data))**2
    variance = float(sumatorio)/len(grades)
    return variance

grades = [100, 100, 90, 40, 80, 100, 85, 70, 90, 65, 90, 85, 50.5]

carasDado1 = 8
carasDado2 = 13

def combinaciones(dado1,dado2):
    aux
    for x in range(1,dado1):
        for y in range(1,dado2):
            aux2 = x+y
            aux.append(aux2)
    print(aux)
    
#print grades_variance(grades, grades_promedio(grades))

print(combinaciones(carasDado1,carasDado2))
