PImage miraDerecha, miraIzquierda,caminaDerecha, caminaIzquierda;
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

void setup() {
  size(800, 600);
  
  //Sección Imagenes (sprites)  
  miraDerecha = loadImage("/caminar/1.png");
  miraIzquierda = loadImage("/caminar/2.png");
  caminaDerecha = loadImage("/caminar/3.png");
  caminaIzquierda = loadImage("/caminar/4.png");
  
  secuenciaDePoder[0] = loadImage("/poder/1.png");
  secuenciaDePoder[1] = loadImage("/poder/2.png");
  secuenciaDePoder[2] = loadImage("/poder/3.png");

  
  imagenActual = miraIzquierda;
  posicionX = width / 2;
}

void draw() {
  background(255);
  
  //Sección de poder
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
    
    //Sección de Posición en movimiento
    if (enMovimiento) {
      if (apuntaDerecha) {
        posicionX += velocidad;
        imagenActual = caminaDerecha;
      } else {
        posicionX -= velocidad;
        imagenActual = caminaIzquierda;
      }
    } else {
      
    //Sección de Posicion quieta
      if (apuntaDerecha) {
        imagenActual = miraDerecha;
      } else {
        imagenActual = miraIzquierda;
      }
    }
  }
  
  //Muestra a honneymoon
  image(imagenActual, posicionX, height/2);
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
