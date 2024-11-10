// Clase Jugador que maneja al personaje y su comportamiento
class Jugadora {
  PImage miraDerecha, miraIzquierda, caminaDerecha, caminaIzquierda;
  PImage imagenActual;
  float posicionX;
  float velocidad = 5;
  boolean enMovimiento = false;
  boolean apuntaDerecha = false;
  
  PImage[] secuenciaDePoder = new PImage[3]; 
  boolean poderActivado = false;
  
  int poderFrame = 0;
  int poderFrameDelay = 5;
  int poderFrameCount = 0;
  
  int contadorBolas = 0; // Contador para las bolas de papel recogidas

  // Constructor para inicializar las imágenes y el estado inicial
  Jugadora() {
    miraDerecha = loadImage("/caminar/1.png");
    miraIzquierda = loadImage("/caminar/2.png");
    caminaDerecha = loadImage("/caminar/3.png");
    caminaIzquierda = loadImage("/caminar/4.png");
    
    secuenciaDePoder[0] = loadImage("/poder/1.png");
    secuenciaDePoder[1] = loadImage("/poder/2.png");
    secuenciaDePoder[2] = loadImage("/poder/3.png");
    
    imagenActual = miraIzquierda;
    posicionX = width - 200;
  }
  
  // Método para mostrar al personaje en pantalla
  void mostrar() {
    image(imagenActual, posicionX, height - 180);
  }

  // Método para mover el personaje
  void mover() {
    if (enMovimiento) {
      if (apuntaDerecha && posicionX + imagenActual.width < width) {
        posicionX += velocidad;
        imagenActual = caminaDerecha;
      } else if (!apuntaDerecha && posicionX > 0) {
        posicionX -= velocidad;
        imagenActual = caminaIzquierda;
      }
    } else {
      if (apuntaDerecha) {
        imagenActual = miraDerecha;
      } else {
        imagenActual = miraIzquierda;
      }
    }
  }

  // Método para activar el poder
  void activarPoder() {
    poderActivado = true;
    poderFrame = 0;  // Reiniciar la secuencia de poder
  }
  
 // Método para manejar la animación de poder
  void manejarPoder() {
    if (poderActivado) {
      imagenActual = secuenciaDePoder[poderFrame];
      poderFrameCount++;
      
      if (poderFrameCount > poderFrameDelay) {
        poderFrame++;
        poderFrameCount = 0;
      }
      
      if (poderFrame >= secuenciaDePoder.length) {
        poderActivado = false;
        poderFrame = 0;
      }
    }
  }

  // Método para activar el movimiento
  void activarMovimiento(boolean apuntaDerecha) {
    enMovimiento = true;
    this.apuntaDerecha = apuntaDerecha;
  }

  // Método para detener el movimiento
  void detenerMovimiento() {
    enMovimiento = false;
  }
  
  // Método para manejar la colisión con bolas de papel
  void verificarColisiones(ArrayList<BolaPapel> bolasPapel) {
    for (int i = bolasPapel.size() - 1; i >= 0; i--) {
      BolaPapel bola = bolasPapel.get(i);
      if (dist(posicionX, height - 100, bola.x + bola.ancho / 2, bola.y + bola.alto / 2) < (bola.ancho / 2 + 15)) {
        bolasPapel.remove(i); // Eliminar la bola de papel
        contadorBolas++; // Incrementar el contador
      }
    }
  }

}
