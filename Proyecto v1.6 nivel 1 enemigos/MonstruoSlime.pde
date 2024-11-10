class MonstruoSlime extends Enemigo {
  PImage[] frames;  // Arreglo de frames para la animación
  int frameIndex = 0;  // Índice del frame actual
  int frameRate = 10;  // Velocidad de cambio de frames (cuanto mayor, más lento)
  int frameCounter = 0; // Contador para controlar la velocidad del cambio de frames
  float velocidadX;
  boolean destruido = false;
  
  // Ajustar el tamaño aquí
  float ancho = 80; // Ancho del monstruo slime (cambiar a un tamaño mayor)
  float alto = 100; // Alto del monstruo slime (cambiar a un tamaño mayor)

   MonstruoSlime(PImage[] animFrames, float posX, float posY) {
    super(animFrames[0], posX, posY); // Inicializa con el primer frame
    frames = animFrames;
    velocidadX = random(4, 9);
  }


   @Override
  void mover() {
    x += velocidadX;

    // Rebote en los bordes
    if (x <= 0 || x >= width - ancho) {
      velocidadX *= -1;
    }

    // Actualizar el frame para la animación
    frameCounter++;
    if (frameCounter >= frameRate) {
      frameCounter = 0;  // Reinicia el contador
      frameIndex = (frameIndex + 1) % frames.length; // Cambia al siguiente frame
      imagen = frames[frameIndex];  // Actualiza la imagen actual
    }
  }

  @Override
  void mostrar() {
    // Reflejar la imagen si se mueve a la izquierda
    if (velocidadX < 0) {
      pushMatrix(); // Guarda la transformación actual
      translate(x + ancho, y); // Trasladar el origen de la imagen
      scale(-1, 1); // Invertir en el eje X
      image(imagen, 0, 0, ancho, alto); // Mostrar la imagen reflejada
      popMatrix(); // Restaurar la transformación
    } else {
      image(imagen, x, y, ancho, alto); // Mostrar la imagen normal
    }
  }
  
  // Método para marcar al monstruo como destruido
  void desaparecer() {
    destruido = true;
  }
  
}
