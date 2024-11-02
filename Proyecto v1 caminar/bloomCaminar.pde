PImage miraDerecha, miraIzquierda,caminaDerecha, caminaIzquierda;
PImage imagenActual;

boolean enMovimiento = false;
boolean apuntaDerecha = false;

float posicionX;  
float velocidad = 5; 

void setup() {
  size(800, 600);
  
  //Sección Imagenes (sprites)  
  miraDerecha = loadImage("/caminar/1.png");
  miraIzquierda = loadImage("/caminar/2.png");
  caminaDerecha = loadImage("/caminar/3.png");
  caminaIzquierda = loadImage("/caminar/4.png");
  
  imagenActual = miraIzquierda;
  posicionX = width / 2;
}

void draw() {
  background(255);
  
  //Sección de Posicion Moviento para la variable x
  if (enMovimiento) {
    if (apuntaDerecha) {
      posicionX += velocidad;
    } else {
      posicionX -= velocidad;
    }
  }
  
  //Seccion de Posición de movimiento para la variable imagen
  if (apuntaDerecha) {
    if (enMovimiento) {
      imagenActual = caminaDerecha;
    } else {
      imagenActual = miraDerecha;
    }
  } else {
    if (enMovimiento) {
      imagenActual = caminaIzquierda;
    } else {
      imagenActual = miraIzquierda;
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
  }
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    enMovimiento = false;
  }
}
