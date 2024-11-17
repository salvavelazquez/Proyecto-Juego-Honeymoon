class Vampiro extends Enemigo {
    int vida; // Vida del vampiro
    PImage imagen;
    float anchovampiro = 209;
    float altovampiro = 252;
    float velocidadY = 3; // Velocidad de movimiento en Y
    int rangoXMax = 100; // Rango máximo en X
    float direccionX = 1; // Dirección en el eje X (1 para ir hacia la derecha, -1 para ir hacia la izquierda)
    ArrayList<Rollut> rolluts; // Lista para almacenar los Rolluts
    float tiempoDeDisparo = 0; // Contador para el tiempo de disparo
    boolean estaHerido = false;
    int tiempoHerido = 0; // Temporizador para el estado de herido
    int duracionHerido = 30; // Duración del efecto (frames)

    Vampiro(PImage img, float posX, float posY, int vidaInicial) {
        super(img, posX, posY);
        this.vida = vidaInicial;
        this.imagen = img;
        this.ancho = anchovampiro;
        this.alto =altovampiro;
        rolluts = new ArrayList<Rollut>();
    }
    
    @Override
    void mostrar() {
      
        if (estaHerido) {
          tint(250, 0, 0); // Aplicar un tinte rojo a Honeymon
        } else {
          noTint(); // Volver a los colores normales
        } 
        image(imagen, x, y);
        //noTint();
        // Controlar el temporizador para el estado herido
        if (estaHerido) {
          tiempoHerido++;
          if (tiempoHerido > duracionHerido) {
            estaHerido = false; // Termina el efecto después de unos frames
            tiempoHerido = 0;  // Reiniciar el temporizador
          }
        }
        
        
        if (finalDialogoVampiro){
          fill(#F7F707);
          textSize(30);
          text("Vampividas: " + vida, 20, 50);
        }
        
        
    }

    @Override
    void mover() {
        // Movimiento a la izquierda
        if ( !finalDialogoVampiro && x < 50) {
            x += 2;  // Aparece de nuevo desde la derecha si sale de la pantalla
        }
        
        if(finalDialogoVampiro){
          // Movimiento en el eje Y (de arriba hacia abajo y luego volver hacia arriba)
          y += velocidadY;
          
          // Si el vampiro llega al fondo (en el eje Y), vuelve hacia arriba
          if (y <= 20 || y > height-292   ) {
              velocidadY *= -1; 
          }
          
          // Movimiento en el eje X dentro del rango
          x += direccionX; // Moverse en X en cada actualización
  
          // Cambiar dirección en el eje X cuando llega a los límites del rango
          if (x <= 0 || x >= rangoXMax) {
              direccionX *= -1; // Cambia la dirección
          }
          
          // Disparo de Rolluts en intervalos
          if (millis() - tiempoDeDisparo > 400) { // Cada 1 segundo
            dispararRollut();
            tiempoDeDisparo = millis(); // Reiniciar el temporizador
          }
      
          // Mover los Rolluts
          for (int i = rolluts.size() - 1; i >= 0; i--) {
            Rollut rollut = rolluts.get(i);
            ((Rollut)rollut).moverDisparo();
            rollut.mostrar();
            honeymoon.manejarColisionEnemigo(rollut);
      
            // Eliminar rolluts fuera de la pantalla
            if (rollut.x < 0 || rollut.x > width || rollut.y < 0 || rollut.y > height) {
              rolluts.remove(i);
            }
          }
          
       }
    }
    
    // Método para disparar un Rollut
    void dispararRollut() {
      // Crear un Rollut en la posición del vampiro
      Rollut nuevoRollut = new Rollut(donaImagen, x + ancho / 2, y + alto / 2);
      rolluts.add(nuevoRollut);
    }

    // Método para reducir vida
    void reducirVida(int cantidad) {
        vida -= cantidad;
        estaHerido= true;
        if (vida <= 0) {
            
            // Acción cuando el vampiro muere (puedes eliminarlo de la lista de enemigos o hacer que desaparezca)
            // Por ejemplo: marcar un flag para eliminar el vampiro o cambiar su imagen
        }
    }

    // Método para verificar si el vampiro está vivo
    boolean estaVivo() {
        return vida > 0;
    }
}
