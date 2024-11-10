class Nube {
  PImage imagenNube;
  float posX, posY;
  float velocidad;
  boolean moviendoDerecha;
  ArrayList<BolaPapel> bolasPapel; // Lista para almacenar las bolas de papel
  
  Nube(PImage imagen) {
    this.imagenNube = imagen;
    this.posX = random(0, width - 200); // Posición inicial aleatoria
    this.posY = 0; // Altura fija para la nube
    this.velocidad = 3;
    this.moviendoDerecha = random(1) > 0.5; // La nube puede comenzar en cualquier dirección
    this.bolasPapel = new ArrayList<BolaPapel>(); // Inicializar la lista de bolasPapel
  }
  
  // Método para mover la nube de izquierda a derecha y viceversa
  void mover() {
    if (moviendoDerecha) {
      posX += velocidad;
      if (posX + imagenNube.width > width) {
        moviendoDerecha = false; // Cambiar de dirección
      }
    } else {
      posX -= velocidad;
      if (posX < 0) {
        moviendoDerecha = true; // Cambiar de dirección
      }
    }
  }
  
  // Método para mostrar la nube en pantalla
  void mostrar() {
    image(imagenNube, posX, posY);
  }
  
  // Método para lanzar un círculo
  void lanzarCirculo() {
    if (frameCount % 60 == 0) { // Lanzar un círculo cada cierto tiempo (60 frames)
      PImage imagenBola = escogerImagenAleatoria();
      bolasPapel.add(new BolaPapel(posX + imagenNube.width / 2, posY + imagenNube.height, imagenBola));
    }
  }
  
   // Método para escoger una imagen aleatoria de las bolas de papel
  PImage escogerImagenAleatoria() {
    int randomIndex = int(random(4));
    if (randomIndex == 0) {
      return bolaAmarilla;
    } else if (randomIndex == 1) {
      return bolaRosa;
    } else if (randomIndex == 2) {
      return bolaGris;
    } else {
      return bolaVerde;
    }
  }
  
  // Actualizar los círculos que caen
  void actualizarCirculos() {
    for (BolaPapel bola : bolasPapel) {
      bola.caer();
      bola.mostrar();
    }
  }
}
