class Zombie extends Enemigo {
  PImage[] frames;
  int currentFrame;
  int frameDelay = 10;
  int frameCount = 0;
  float speed = 9; // Velocidad del zombie
  float anchozombie = 439; // Ancho del monstruo slime (cambiar a un tamaño mayor)
  float altozombie = 417; // Alto del monstruo slime (cambiar a un tamaño mayor)
  PoderCaramelo caramelo;
  boolean carameloActivado = false;
  

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
    
    // Verificar si el zombie ha alcanzado el límite de la pantalla
    if (x < -4500){
       // Agregar un nuevo caramelo en la posición actual del zombie
       if(carameloActivado == false ){
         carameloActivado = true;
         caramelo = new PoderCaramelo(-2800, 20, carameloImagen);
         
       }
       
       
       actualizarCaramelo();
    }
    

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
      image(imagen, x+plataformaX, y);
  }
  
  void actualizarCaramelo() {
    caramelo.mostrar();
    caramelo.mover();
    caramelo.colisionaCon();
  }
  
  void reiniciar(){
    x = width;
    currentFrame = 0;
    carameloActivado = false;
    parteDos = false;
  }
}
