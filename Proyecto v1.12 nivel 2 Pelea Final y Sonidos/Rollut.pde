class Rollut extends Enemigo {
  float velocidadX, velocidadY, disparo;
  float suelo = height - 50;

  Rollut(PImage img, float posX, float posY) {
    super(img, posX, posY);
    velocidadX = random(2, 8);
    velocidadY = random(2, 8);
    disparo = random(5,10);
  }

  @Override
  void mover() {
    x += velocidadX;
    y += velocidadY;

     //Rebote en los bordes
    if (x <= 0 || x >= width - ancho) {
      velocidadX *= -1;
    }
    if (y <= 0 || y >= suelo - alto) {
      velocidadY *= -1;
    }
  }
  
  void moverDisparo(){
    x += disparo;
  }
}
