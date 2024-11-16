class BolaDeFuego {
  float x, y;         // Posición de la bola de fuego
  float velocidad = -10;  // Velocidad hacia la izquierda
  PImage imagen;      // Imagen de la bola de fuego

  // Constructor que inicializa la posición y la imagen de la bola de fuego
  BolaDeFuego(float x, float y, PImage imagen) {
    this.x = x;
    this.y = y;
    this.imagen = imagen;
  }

  // Método para mostrar la bola de fuego en pantalla
  void mostrar() {
    image(imagen, x, y);
  }

  // Método para actualizar la posición de la bola de fuego
  void mover() {
    x += velocidad; // Mover la bola hacia la izquierda
  }

  // Método para verificar si la bola de fuego salió de la pantalla
  boolean estaFueraDePantalla() {
    return x < -imagen.width; // Devuelve true si la bola está fuera del lado izquierdo
  }
  
  
  // Verificar colisión con un vampiro
    boolean colisionaCon(Enemigo vampiro) {
        float distanciaX = abs(x - vampiro.x);
        float distanciaY = abs(y - vampiro.y-100);
        return distanciaX < vampiro.ancho / 2 && distanciaY < vampiro.alto / 2;
    }
    
}
