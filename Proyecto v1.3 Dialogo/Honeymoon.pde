PImage miraDerecha, miraIzquierda, caminaDerecha, caminaIzquierda;
PImage imagenActual, hadaguia;

boolean enMovimiento = false;
boolean apuntaDerecha = false;

float posicionX;  
float velocidad = 5; 

PImage[] secuenciaDePoder = new PImage[3]; 
boolean poderActivado = false;

int poderFrame = 0;
int poderFrameDelay = 10;
int poderFrameCount = 0; 

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
  
  // Cargar las imágenes (sprites)
  hadaguia = loadImage("/HadaGuia.png");
  
  miraDerecha = loadImage("/caminar/1.png");
  miraIzquierda = loadImage("/caminar/2.png");
  caminaDerecha = loadImage("/caminar/3.png");
  caminaIzquierda = loadImage("/caminar/4.png");
  
  secuenciaDePoder[0] = loadImage("/poder/1.png");
  secuenciaDePoder[1] = loadImage("/poder/2.png");
  secuenciaDePoder[2] = loadImage("/poder/3.png");
  
  fondo = loadImage("/fondocandy22.png");
  
  // Redimensionar el fondo una vez y almacenarlo
  fondoRedimensionado = fondo.copy(); 
  fondoRedimensionado.resize(width, height);

  imagenActual = miraIzquierda;
  posicionX = width -200;
}

void draw() {
  background(255);
  
  // Dibujar el fondo, asegurando que se repita de manera continua
  image(fondoRedimensionado, fondoX, 0);
  image(fondoRedimensionado, fondoX + fondoRedimensionado.width, 0);
  
  if (!juegoIniciado) {
    // Mostrar el personaje mientras el diálogo se muestra
    image(imagenActual, posicionX, height - 180);
    mostrarDialogo();  // Muestra el diálogo hasta que se complete
  } else {
    // El juego comienza aquí
    if (enMovimiento) { // Ajustar el movimiento del fondo cuando el personaje se mueva
      if (apuntaDerecha) {
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
    
    // Sección de poder
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
    } else {
      // Sección de posición en movimiento
  if (enMovimiento) {
    if (apuntaDerecha) {
      // Verifica que el personaje no pase del borde derecho
      if (posicionX + imagenActual.width < width) {
        posicionX += velocidad;
        imagenActual = caminaDerecha;
      }
    } else {
      // Verifica que el personaje no pase del borde izquierdo
      if (posicionX > 0) {
        posicionX -= velocidad;
        imagenActual = caminaIzquierda;
      }
    }
  }
   else {
        // Sección de posición quieta
        if (apuntaDerecha) {
          imagenActual = miraDerecha;
        } else {
          imagenActual = miraIzquierda;
        }
      }
    }
    
    // Mostrar a Honeymoon
    image(imagenActual, posicionX, height - 180);
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
      estadoDialogo++;
      if (estadoDialogo >= dialogos.length) {
        juegoIniciado = true;  // Cuando se acaba el diálogo, inicia el juego
      }
    }
  } else {
    if (keyCode == RIGHT) {
      enMovimiento = true;
      apuntaDerecha = true;
    } else if (keyCode == LEFT) {
      enMovimiento = true;
      apuntaDerecha = false;
    } else if (key == ' ') {
      poderActivado = true;
      poderFrame = 0;
    }
  }
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    enMovimiento = false;
  }
}

//void mostrarDialogo() {
//  // Mostrar el cuadro de diálogo sobre el fondo y el personaje
//  fill(255, 255, 255, 200);  // Fondo blanco semitransparente para el diálogo
//  rect(50, height - 200, width - 100, 150, 20);  // Crea el globo de diálogo
  
//  fill(0); 
//  textSize(24);
//  text(dialogos[estadoDialogo], 70, height - 170, width - 140, 140); // Mostrar texto dentro del cuadro
//}
