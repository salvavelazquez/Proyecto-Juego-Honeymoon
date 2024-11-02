PImage miraDerecha, miraIzquierda, caminaDerecha, caminaIzquierda;
PImage imagenActual;

boolean enMovimiento = false;
boolean apuntaDerecha = false;

float posicionX;  
float velocidad = 5; 

PImage[] secuenciaDePoder = new PImage[3]; 
boolean poderActivado = false;

int poderFrame = 0;
int poderFrameDelay = 5;
int poderFrameCount = 0; 

PImage fondo, fondoRedimensionado;
float  fondoX = 0;  // Variable para controlar la posición del fondo
float  fondoVelocidad = 2;  // Velocidad de desplazamiento del fondo

void setup() {
  fullScreen();
  
  // Cargar las imágenes (sprites)
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
  posicionX = width / 2;
}

void draw() {
  background(255);
  
  // Dibujar el fondo, asegurando que se repita de manera continua
  image(fondoRedimensionado, fondoX, 0);
  image(fondoRedimensionado, fondoX + fondoRedimensionado.width, 0);
  
  // Ajustar el movimiento del fondo cuando el personaje se mueva
  if (enMovimiento) {
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

void keyPressed() {
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

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    enMovimiento = false;
  }
}
