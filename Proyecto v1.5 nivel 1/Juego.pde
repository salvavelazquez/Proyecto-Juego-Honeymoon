Jugadora honeymoon;
Dialogo dialogoHada;
Nube nube; 
PImage imagenNube;
PImage bolaAmarilla, bolaRosa, bolaGris, bolaVerde;
PImage hadaguia;
PImage fondoNivel1, fondoNivel2;
PImage fondo, fondoRedimensionado;
float  fondoX = 0;  // Variable para controlar la posición del fondo
float  fondoVelocidad = 4;  // Velocidad de desplazamiento del fondo

PImage donaImagen; // Declara la imagen de la dona
Enemigo enemigo; // Declara el objeto enemigo

// Variables for dialogue
String[] dialogos = {
  "¡Hola Honeymon! Tienes una nueva misión!! \nEntregale la corona a la princesa de Caramelos para su coronación.",
  "Los egs no quieren que sea reina así que robaron \nla corona del reino...",
  "El bosque está todo contaminado, recoje lo que puedas! .",
  "Te enfrentarás a los egs, ¡ten mucho cuidado! ¡Suerte!"
};

int estadoDialogo = 0; // Controla el estado del diálogo
boolean juegoIniciado = false; // Controla si el juego ha comenzado

// Variables para manejar el círculo y los niveles
boolean nivel1Completado = false;


void setup() {
  fullScreen();
  
  // Inicializar el objeto Honeymon
  honeymoon = new Jugadora();
  hadaguia = loadImage("/juego/HadaGuia.png");
  
  // Cargar el fondo
  //fondo = loadImage("/juego/FondoPalido.jpg");
  
  // Redimensionar el fondo una vez y almacenarlo
  //fondo.resize(width, height);
  
  // Cargar las imágenes de los fondos
  fondoNivel1 = loadImage("/juego/FondoPalido.jpg"); // Fondo para nivel 1
  fondoNivel2 = loadImage("/juego/FondoFuerte.jpg"); // Fondo para nivel 2
  
  // Redimensionar los fondos
  fondoNivel1.resize(width, height);
  fondoNivel2.resize(width, height);
  
  fondo = fondoNivel2;
  // Inicializar la clase DialogoHada con los diálogos y la imagen del hada
  dialogoHada = new Dialogo(dialogos, hadaguia);
  
 // Cargar la imagen de la nube
  imagenNube = loadImage("/juego/nube.png"); 
  
  // Inicializar la nube
  nube = new Nube(imagenNube);
  
    // Cargar las imágenes de las bolas de papel
  bolaAmarilla = loadImage("/bolasdepapel/amarilla.png");
  bolaRosa = loadImage("/bolasdepapel/rosa.png");
  bolaGris = loadImage("/bolasdepapel/gris.png");
  bolaVerde = loadImage("/bolasdepapel/verde.png");
  
  donaImagen = loadImage("/juego/rollut.png"); // Cargar la imagen de la dona
  enemigo = new Enemigo(donaImagen, 100, 100);

}

void draw() {
  background(255);
  
  // Dibujar el fondo, asegurando que se repita de manera continua
  image(fondo, fondoX, 0);
  image(fondo, fondoX + fondo.width, 0);
  
  if (!juegoIniciado) {
    // Mostrar el personaje y los diálogos antes de que comience el juego
    honeymoon.mostrar();
    dialogoHada.mostrar(); 
  } else {
    // El juego comienza aquí: Nivel 1
    
    if (!nivel1Completado) {
      fondo = fondoNivel1;
      // Mostrar y mover la nube
      nube.mover();
      nube.mostrar();
      
      // Hacer que la nube lance círculos y actualizarlos
      nube.lanzarCirculo();
      nube.actualizarCirculos();
      
      // Verificar colisiones entre Honeymon y las bolas de papel
      honeymoon.verificarColisiones(nube.bolasPapel);
      
      
      enemigo.mover();
      enemigo.mostrar();
      
      // Mostrar el contador de bolas recogidas
      fill(255);
      textSize(30);
      text("Bolas de papel recogidas: " + honeymoon.contadorBolas, width-370, 40);
      
      // Verificar si el contadorBolas ha alcanzado el límite
      if (honeymoon.contadorBolas > 10) {
        fondo = fondoNivel2;
        if(honeymoon.contadorBolas > 20){
           nivel1Completado = true; // Cambiar a nivel 2
        }

        
      }
      
    } else {
      // Nivel 2: fondo en movimiento
      if (honeymoon.enMovimiento) {
        if (honeymoon.apuntaDerecha) {
          fondoX -= fondoVelocidad; // Desplazar el fondo hacia la izquierda
        } else {
          fondoX += fondoVelocidad; // Desplazar el fondo hacia la derecha
        }
      }
      
      // Mantener el fondo en bucle
      if (fondoX <= -fondo.width) {
        fondoX = 0;
      }
      if (fondoX >= 0) {
        fondoX = -fondo.width;
      }
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
