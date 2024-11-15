class Zombie extends Enemigo {
  PImage[] frames;
  int currentFrame;
  int frameDelay = 5;
  int frameCount = 0;
  float speed = 1; // Velocidad del zombie
  // Ajustar el tamaño aquí
  float anchozombie = 339; // Ancho del monstruo slime (cambiar a un tamaño mayor)
  float altozombie = 317; // Alto del monstruo slime (cambiar a un tamaño mayor)
  

  Zombie(PImage[] frames, float startX, float startY) {
    super(frames[0], startX, startY); // Usa el primer frame como imagen inicial
    this.frames = frames;
    this.currentFrame = 0;
    ancho = anchozombie; 
    alto = altozombie;
  }
  


  @Override
  void mover() {
    // Movimiento del zombie hacia la izquierda para perseguir a Honeymon
    x -= speed;

    // Actualización de la animación
    frameCount++;
    if (frameCount >= frameDelay) {
      currentFrame = (currentFrame + 1) % frames.length;
      imagen = frames[currentFrame];
      frameCount = 0;
    }
  }
  
  @Override
  void mostrar() {
      image(imagen, x, y, ancho, alto);
  }
  
  void reiniciar(){
    x = width;
    currentFrame = 0;
  }
}
