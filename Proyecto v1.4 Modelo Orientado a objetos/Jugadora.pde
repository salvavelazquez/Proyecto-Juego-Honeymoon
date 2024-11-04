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
  int poderFrameDelay = 10;
  int poderFrameCount = 0;

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
}
