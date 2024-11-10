class Rollut extends Enemigo {
  float velocidadX, velocidadY;
  float suelo = height - 50;

  Rollut(PImage img, float posX, float posY) {
    super(img, posX, posY);
    velocidadX = random(2, 8);
    velocidadY = random(2, 8);
  }

  @Override
  void mover() {
    x += velocidadX;
    y += velocidadY;

    // Rebote en los bordes
    if (x <= 0 || x >= width - ancho) {
      velocidadX *= -1;
    }
    if (y <= 0 || y >= suelo - alto) {
      velocidadY *= -1;
    }
  }
}
