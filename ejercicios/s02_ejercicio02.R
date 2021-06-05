# Para esta serie de ejercicios usaremos el data frame stars que nos indica 
# atributos de una serie de estrellas como su temperatura, tipo y magnitud. 
# La columna magnitude es la magnitud absoluta, donde un valor más negativo 
# de una estrella respecto a otra quiere decir que es más luminosa.
names(estrellas) <- c("temp", "lumin", "radius", "magnitude", "type", "color", "clase")

# 1. La temperatura está en grados Kelvin. Agrega la columna temp_celsius 
# usando la siguiente fórmula: C = K - 273.15. Reporta un gráfico de 
# dispersión de temperatura versus magnitud coloreando según el clase de estrella. 
# Además, cambia la escala del eje-x a logarítmica en base 10.

estrellas_n <- estrellas %>%
  mutate(temp_celsius = temp - 273.15)

ggplot(estrellas_n, aes(x=temp_celsius, y=magnitude, color=clase)) +
  geom_point() +
  scale_x_log10()

# 2. Dado que los valores positivos indican que hay menos brillo, invierte 
# los valores del gráfico anterior usando la capa scale_y_reverse().

ggplot(estrellas_n, aes(x=temp_celsius, y=magnitude, color=clase)) +
  geom_point() +
  scale_x_log10() +
  scale_y_reverse()

# El Sol es clasificado como una estrella clase G.
# ¿Son las estrellas de clase G las más luminosas? 
# Crea un gráfico de cajas para comparar medianas de la magnitud y determinar 
# qué clase de estrellas son las más luminosas.

ggplot(estrellas_n, aes(x=clase, y=magnitude)) +
  geom_boxplot() +
  scale_y_reverse()
