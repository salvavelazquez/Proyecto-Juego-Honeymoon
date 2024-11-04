Jugadora honeymoon;
Dialogo dialogoHada;
PImage hadaguia;
PImage fondo, fondoRedimensionado;
float  fondoX = 0;  // Variable para controlar la posición del fondo
float  fondoVelocidad = 2;  // Velocidad de desplazamiento del fondo

// Variables for dialogue
String[] dialogos = {
  "¡Hola Honeymon! Tienes una nueva misión!! \nEntregale la corona a la princesa de Caramelos para su coronación.",
  "Los egs no quieren que sea reina así que encantaron \nel bosque ocultando la ubicación del reino...",
  "El secreto del encantamiento está en los envoltorios de caramelos.",
  "Te enfrentarás a los egs, ¡ten mucho cuidado! ¡Suerte!"
};

int estadoDialogo = 0; // Controla el estado del diálogo
boolean juegoIniciado = false; // Controla si el juego ha comenzado

void setup() {
  fullScreen();
  
  // Inicializar el objeto Honeymon
  honeymoon = new Jugadora();
  hadaguia = loadImage("/HadaGuia.png");
  
  // Cargar el fondo
  fondo = loadImage("/fondocandy22.png");
  
  // Redimensionar el fondo una vez y almacenarlo
  fondoRedimensionado = fondo.copy(); 
  fondoRedimensionado.resize(width, height);
  
  // Inicializar la clase DialogoHada con los diálogos y la imagen del hada
  dialogoHada = new Dialogo(dialogos, hadaguia);

}

void draw() {
  background(255);
  
  // Dibujar el fondo, asegurando que se repita de manera continua
  image(fondoRedimensionado, fondoX, 0);
  image(fondoRedimensionado, fondoX + fondoRedimensionado.width, 0);
  
  if (!juegoIniciado) {
    // Mostrar el personaje y los diálogos antes de que comience el juego
    honeymoon.mostrar();
    dialogoHada.mostrar(); 
  } else {
    // El juego comienza aquí
    if (honeymoon.enMovimiento) { // Ajustar el movimiento del fondo cuando el personaje se mueva
      if (honeymoon.apuntaDerecha) {
        fondoX -= fondoVelocidad;  // Desplazar el fondo hacia la izquierda
      } else {
        fondoX += fondoVelocidad;  // Desplazar el fondo hacia la derecha
      }
    }
    
    // Mantener el fondo en bucle
    if (fondoX <= -fondoRedimensionado.width) {
      fondoX = 0;
    }
    if (fondoX >= 0) {
      fondoX = -fondoRedimensionado.width;
    }
    
    honeymoon.mover();
    honeymoon.manejarPoder(); 
    honeymoon.mostrar();
  }
}

void mostrarDialogo() {
  // Mostrar el cuadro de diálogo sobre el fondo y el personaje
  fill(255, 255, 255, 200);  // Fondo blanco semitransparente para el diálogo
  rect(280, 330, width/2+100, 150, 20);  // Crea el globo de diálogo
  
  fill(0); 
  textSize(25);
  text(dialogos[estadoDialogo], 305, height/2-2, width - 140, 140); // Mostrar texto dentro del cuadro
  image(hadaguia, width-400, height /2+50, 130,130);
}

void keyPressed() {
 if (!juegoIniciado) {
    if (key == ' ') {
      dialogoHada.avanzarDialogo();
      if (dialogoHada.dialogoTerminado()) {
        juegoIniciado = true;  // Cuando se acaba el diálogo, inicia el juego
      }
    }
  } else {
    if (keyCode == RIGHT) {
      honeymoon.activarMovimiento(true);
    } else if (keyCode == LEFT) {
      honeymoon.activarMovimiento(false);
    } else if (key == ' ') {
      honeymoon.activarPoder();
    }
  }
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    honeymoon.detenerMovimiento();
  }
}
