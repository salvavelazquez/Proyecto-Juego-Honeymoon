// Clase para los círculos que caen desde la nube
class BolaPapel {
  float x, y;
  float velocidadY = 3;
  PImage imagen;
  float ancho = 50, alto = 50;
  
  BolaPapel(float x, float y, PImage imagen) {
    this.x = x;
    this.y = y;
    this.imagen = imagen;
  }
  
  // Método para hacer que la bola de papel caiga
  void caer() {
    if (y + alto < height - 50) { // Detenerse en el "suelo"
      y += velocidadY;
    }
  }
  
  // Método para mostrar la bola de papel en pantalla
  void mostrar() {
    image(imagen, x, y, ancho, alto);
  }
}
