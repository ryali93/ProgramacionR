# GRAFICOS DE DISPERSION
## Datos de ejemplo
set.seed(12)

n <- 100
x <- runif(n)
eps <- rnorm(n, 0, 0.25)

y <- 2 + 3 * x^2 + eps

##
plot(x, y, pch = 19, col = "black")
plot(y ~ x, pch = 19, col = "black") # Equivalente

##
identify(y ~ x, labels = paste0("(", round(x, 2), ", ", round(y, 2), ")"))


## Nube de puntos en R con colores por grupo
grupo <- as.factor(ifelse(x < 0.5, "Grupo 1", "Grupo 2"))
plot(x, y, pch = as.numeric(grupo), col = grupo)

## Gráfico de dispersión con curva de regresión
plot(x, y, pch = 19, col = "gray52")

# Modelo subyacente
lines(seq(0, 1, 0.05), 2 + 3 * seq(0, 1, 0.05)^2, col = "2", lwd = 3, lty = 2)
# Ajsute lineal
abline(lm(y ~ x), col = "orange", lwd = 3)
# Ajuste suavizado
lines(lowess(x, y), col = "blue", lwd = 3)
# Leyenda
legend("topleft", legend = c("Teórico", "Lineal", "Suavizado"),
       lwd = 3, lty = c(2, 1, 1), col = c("red", "orange", "blue"))


# Calculamos la correlación entre las variables
Corr <- cor(x, y)
# Creamos el gráfico y añadimos el valor calculado
plot(x, y, pch = 19)
text(paste("Correlación:", round(Corr, 2)), x = 0.2, y = 4.5)


## Añadir múltiples series al gráfico de dispersión
set.seed(1)

plot(x, y, pch = 19)

n <- 200

x2 <- runif(n)
y2 <- 2.5 + x2 + rnorm(n, 0, 0.1)

points(x2, y2, col = "green", pch = 19)


## Diagrama de dispersión en R con barras de error
mis_datos <- 1:10
media <- rnorm(10)
desv <- rnorm(10, 1, 0.1)

plot(mis_datos, media,
     ylim = range(c(media - desv, media + desv)),
     pch = 16)

# Barras de error
arrows(x0 = mis_datos, y0 = media - desv, x1 = mis_datos, y1 = media + desv,
       length = 0.15, code = 3, angle = 90)

## Diagrama de dispersión conectado en R
set.seed(1)

x3 <- 0:10
y3 <- (0:10) ^ 1.45 + rnorm(11)
y4 <- (0:10) ^ 1.15 + rnorm(11)
y5 <- (0:10) ^ 1.05 + rnorm(11)

plot(x3, y3,  type = "b", col = 2 , lwd = 3, pch = 1)
lines(x3, y4, type = "b", col = 3 , lwd = 3, pch = 1)
lines(x3, y5, type = "b", col = 4 , lwd = 3, pch = 1)


# Función para conectar lo puntos con flechas
arrowsPlot <- function(x, y, lwd = 1, col = 1, angle = 20, length = 0.2) {
  invisible(sapply(1:length(x),
                   function(i) arrows(x[i], y[i], x[i + 1], y[i + 1], lwd = lwd,
                                      col = col, angle = angle, length = length)))
}

plot(x3, y3, col = 2, lwd = 3, pch = "")
arrowsPlot(x3, y3, col = 2, lwd = 3)

lines(x3, y4, col = 3, lwd = 3)
arrowsPlot(x3, y4, col = 3, lwd = 3)

lines(x3, y5, col = 4 , lwd = 3)
arrowsPlot(x3, y5, col = 4 , lwd = 3)


## mostrar la trayectoria que dibujan dos variables a lo largo del tiempo.
# Datos de ejemplo
x4 <- ifelse(x3 < 5, x3, rev(x3 / 3))
y5 <- ifelse(y3 < 5, y3 ^ 3, rev(y3 + 5))

# Creando el gráfico de puntos conectados
plot(x4, y5, yaxt = "n", xaxt = "n", pch = "",
     xlab = "Popularidad", ylab = "Ventas", xlim = c(-1, 5.5))
arrowsPlot(x4, y5, col = 3, lwd = 3)

# Añadiendo los años a cada punto
text(x4 + 0.3, y5, 1970:1980)


## Diagrama de dispersión suavizado
smoothScatter(x, y)

smoothScatter(x, y, pch = 19,
              transformation = function(x) x ^ 0.5, # Escala
              colramp = colorRampPalette(c("#f7f7f7", "aquamarine"))) # Colores

## Mapa de calor con un scatterplot
smoothScatter(x, y, transformation = function(x) x ^ 0.4,
              colramp = colorRampPalette(c("#000099", "#00FEFF", "#45FE4F",
                                           "#FCFF00", "#FF9400", "#FF3100")))

## Agregar curvas de nivel con la función contour
# install.packages("MASS")
library(MASS)
kern <- kde2d(x, y)

contour(kern, drawlabels = FALSE, nlevels = 6,
        col = rev(heat.colors(6)), add = TRUE, lwd = 3)


## La funcion scatterplot
# install.packages("car")
library(car)

scatterplot(y ~ x)
scatterplot(x, y) # Equivalente


scatterplot(x, y,
            col = 1,   # Color de los puntos
            pch = 15,  # Símbolo
            regLine = list(col = "green", # Color de la regresión lineal
                           lwd = 3),      # Ancho de la línea
            smooth = list(col.smooth = "red",   # Color de la estimación no paramétrica de la media
                          col.spread = "blue")) # Color de la estimación no paramétrica de la varianza

scatterplot(x, y,
            smooth = FALSE,  # Borra la estimación suavizada
            regLine = FALSE) # Borra la estimación lineal

scatterplot(x, y,
            boxplots = "x") # Boxplot marginal del eje X

scatterplot(y ~ x | grupo)

scatterplot(x, y,
            grid = FALSE,   # Eliminar el grid
            ellipse = TRUE) # Dibujar elipses


## Matriz de dispersión en R
pairs(~disp + wt + mpg + hp, data = mtcars)

pairs(~disp + wt + mpg + hp, col = factor(mtcars$am), pch = 19, data = mtcars)

scatterplotMatrix(~ disp + wt + mpg + hp, data = mtcars)

scatterplotMatrix(~ disp + wt + mpg + hp, data = mtcars,
                  diagonal = FALSE,             # Eliminar las estimaciones tipo núcleo
                  regLine = list(col = "green", # Color de la línea de regresión
                                 lwd = 3),      # Ancho de la línea de regresión
                  smooth = list(col.smooth = "red",   # Color de la media no paramétrica
                                col.spread = "blue")) # Color de la varianza no paramétrica

## Gráfico de dispersión 3D
library(scatterplot3d)

set.seed(2)
x <- rnorm(1000)
y <- rnorm(1000, mean = 100)
z <- rnorm(1000)

scatterplot3d(x, y, z, pch = 19, color = "blue")


library(rgl)

plot3d(x, y, z,      # Datos
       type = "s",   # Tipo de gráfico
       radius = 0.1, # Radio de las observaciones
       col = "lightblue",   # Color de las observaciones
       xlab ="X axis lab",  # Etiqueta del eje X
       ylab = "Y axis lab", # Etiqueta del eje Y
       zlab = "Z axis lab") # Etiqueta del eje Z
