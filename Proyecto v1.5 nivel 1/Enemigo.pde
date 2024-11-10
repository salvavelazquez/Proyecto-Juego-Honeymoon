class Enemigo {
  PImage imagen;
  float x, y; // Posición
  float velocidadX, velocidadY; // Velocidad de movimiento
  float ancho = 60; // Ancho del enemigo
  float alto = 80; // Alto del enemigo
  float suelo = height-50;

  Enemigo(PImage img, float posX, float posY) {
    imagen = img;
    x = posX;
    y = posY;
    velocidadX = random(2, 5); // Velocidad horizontal aleatoria
    velocidadY = random(2, 5); // Velocidad vertical aleatoria
  }

  void mover() {
    x += velocidadX;
    y += velocidadY;

    // Rebote con las paredes
    if (x <= 0 || x >= width - ancho) {
      velocidadX *= -1; // Invertir dirección horizontal
    }
    if (y <= 0 || y >= (suelo) - alto) {
      velocidadY *= -1; // Invertir dirección vertical
    }
  }

  void mostrar() {
    image(imagen, x, y, ancho, alto); // Mostrar la imagen del enemigo
  }
}
