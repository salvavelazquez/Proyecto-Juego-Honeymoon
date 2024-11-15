// Clase Jugador que maneja al personaje y su comportamiento
class Jugadora {
  float posicionY; // Posición en Y de Honeymon
  float ancho; // Ancho de la jugadora
  float alto; // Altura de la jugadora

  float velocidadSalto = -15; // Velocidad inicial del salto
  float gravedad = 0.7; // Gravedad que afecta el salto
  boolean saltando = false; // Estado para saber si está saltando
    
  
  PImage miraDerecha, miraIzquierda, caminaDerecha, caminaIzquierda;
  PImage imagenActual,alzar;
  float posicionX;
  float velocidad = 7;
  boolean enMovimiento = false;
  boolean apuntaDerecha = false;
  
  PImage[] secuenciaDePoder = new PImage[3]; 
  boolean poderActivado = false;
  
  int poderFrame = 0;
  int poderFrameDelay = 5;
  int poderFrameCount = 0;
  
  int contadorBolas = 0; // Contador para las bolas de papel recogidas
  
  int vidas = 4; // Añadido: Inicializamos a Honeymon con 4 vidas
  boolean colisionandoConDona = false;
  
  boolean estaHerido = false; // Indica si Honeymon está herido
  int tiempoHerido = 0; // Temporizador para el estado de herido
  int duracionHerido = 30; // Duración del efecto (frames)
  
  private boolean juegoTerminado;
  boolean sobrePlataforma;

  // Constructor para inicializar las imágenes y el estado inicial
  Jugadora() {
    this.juegoTerminado = false;
    miraDerecha = loadImage("/caminar/1.png");
    miraIzquierda = loadImage("/caminar/2.png");
    caminaDerecha = loadImage("/caminar/3.png");
    caminaIzquierda = loadImage("/caminar/4.png");
    
    secuenciaDePoder[0] = loadImage("/poder/1.png");
    secuenciaDePoder[1] = loadImage("/poder/2.png");
    secuenciaDePoder[2] = loadImage("/poder/3.png");
    
    alzar = loadImage("/caminar/alzar.png");
    
    imagenActual = miraIzquierda;
    posicionX = width - 200;
    posicionY = height - 180;
    ancho = 104;
    alto = 118;
    sobrePlataforma = false;
  }
  
  // Método para mostrar al personaje en pantalla
  void mostrar() {
    if (estaHerido) {
      tint(250, 0, 0); // Aplicar un tinte rojo a Honeymon
    } else {
      noTint(); // Volver a los colores normales
    } 
    
    if (poderActivado){
      if (apuntaDerecha) {
        pushMatrix();
        translate(posicionX + imagenActual.width, posicionY); // Trasladar el punto de origen para la inversión
        scale(-1, 1);
        image(imagenActual, 0, 0);
        popMatrix();
      } else{
        image(imagenActual, posicionX, posicionY);
      }
    } else{
        image(imagenActual, posicionX, posicionY);
    }
   
    
    noTint();
    // Controlar el temporizador para el estado herido
    if (estaHerido) {
      tiempoHerido++;
      if (tiempoHerido > duracionHerido) {
        estaHerido = false; // Termina el efecto después de unos frames
        tiempoHerido = 0;  // Reiniciar el temporizador
      }
    }
  }
  
  void saltar() {
      if (!saltando) { // Solo permitir el salto si no está ya en el aire
          saltando = true;
          velocidadSalto = -15; // Define la velocidad inicial de salto
      }
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
    
    // Manejo del salto
    if (saltando) {
     posicionY += velocidadSalto;
        velocidadSalto += gravedad; // Aplica gravedad para hacer que baje

        if (posicionY >= height - 180) { // Chequeo para que caiga al suelo
            posicionY = height - 180;
            saltando = false; // Termina el salto cuando toca el suelo
         
            velocidadSalto = 0;
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
      if (apuntaDerecha) {
        
      
      }
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
      if (dist(posicionX, posicionY+100, bola.x + bola.ancho / 2, bola.y + bola.alto / 2) < (bola.ancho / 2 + 35)) {
        bolasPapel.remove(i); // Eliminar la bola de papel
        contadorBolas++; // Incrementar el contador
      }
    }
  }
  
  // Método para verificar colisión con el enemigo (dona)
  boolean verificarColisionEnemigo(Enemigo enemigo) {
    if (enemigo instanceof Zombie) {
      if (dist(posicionX, posicionY+20, plataformaX+enemigo.x + enemigo.ancho / 2, enemigo.y + enemigo.alto / 2) < (enemigo.ancho / 2 + 25)) {
        return true;
      }
    }else if (dist(posicionX, posicionY+20, enemigo.x + enemigo.ancho / 2, enemigo.y + enemigo.alto / 2) < (enemigo.ancho / 2 + 25)) {
      return true;
    }
    
    return false;
  }
  
  // Método para manejar la colisión y descontar vidas
  void manejarColisionEnemigo(Enemigo enemigo) {
    if (estaHerido) return;
    
    if (poderActivado && enemigo instanceof MonstruoSlime) {
      if (verificarColisionEnemigo(enemigo)) {
        // Si colisiona, llama al método desaparecer del monstruo
        ((MonstruoSlime) enemigo).desaparecer();
        return;
      }
    }
    
    if (verificarColisionEnemigo(enemigo)) {
      if (!colisionandoConDona) {  // Solo restar una vida si no está colisionando
        vidas--; // Reducir vidas en 1
        estaHerido = true; // Activar el estado de herido
        colisionandoConDona = true; // Indicar que está colisionando
        //println("¡Colisión con el enemigo! Vidas restantes: " + vidas);
        if (vidas <= 0 || enemigo instanceof Zombie) {
          juegoTerminado = true;
          //println("Game Over");
          
        }
      }
    } else {
      colisionandoConDona = false; // Resetear el estado de colisión cuando Honeymon ya no esté colisionando
    }
  }
  
  public boolean isJuegoTerminado() {
        return juegoTerminado;
    }
    
  void reiniciar() {
    vidas = 5; // Restablecer vidas
    contadorBolas = 0; // Reiniciar contador de bolas
    posicionX = width - 200; // Reiniciar posición X
    posicionY = height - 180; // Reiniciar posición Y
    juegoTerminado = false; // Marcar que el juego no está terminado
    if(dialogoCarameloMostrado){
      imagenActual = alzar;
    }else{
      imagenActual = miraIzquierda;
    }
    
    
  }


}
