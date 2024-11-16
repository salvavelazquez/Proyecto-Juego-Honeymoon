abstract class Enemigo {
  PImage imagen;
  float x, y; // Posición
  float ancho = 60; // Ancho del enemigo
  float alto = 80; // Alto del enemigo

  Enemigo(PImage img, float posX, float posY) {
    imagen = img;
    x = posX;
    y = posY;
  }
  
   // Método abstracto para movimiento, se implementará en cada clase específica
  abstract void mover(); 



  void mostrar() {
    image(imagen, x, y, ancho, alto); // Mostrar la imagen del enemigo
  }
}
