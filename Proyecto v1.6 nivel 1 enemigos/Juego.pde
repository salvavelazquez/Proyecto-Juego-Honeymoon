Jugadora honeymoon;
Enemigo enemigo; // Declara el objeto enemigo
Dialogo dialogoHada;
Nube nube;   

PImage imagenNube, bolaAmarilla, bolaRosa, bolaGris, bolaVerde;
PImage hadaguia;
PImage fondoNivel1, fondoNivel2, fondo, fondoRedimensionado;
PImage donaImagen;
PImage[] slimeFrames = new PImage[4];

float  fondoX = 0;  // Variable para controlar la posición del fondo
float  fondoVelocidad = 4;  // Velocidad de desplazamiento del fondo


ArrayList<Enemigo> enemigos;
String[] dialogoInicial = {
  "    ¡Hola Honeymoon! Tienes una nueva misión!!",
  "         Encuentra la corona de la princesa de\n              Caramelos para su coronación.",
  "Los Egs no quieren que sea reina así que robaron \nla corona del reino...",
  "El bosque está todo contaminado, recoje lo que \npuedas para poder avanzar! .",
  "Me informaron que las Rolluts saltarinas \nno les afecta tu poder...",
  "  Te enfrentarás a los Egs,\n                                ¡ten mucho cuidado! ¡Suerte!",
};

String[] dialogoNivel1 = {
  "¡Bien hecho! Curaste el mundo de caramelos!!",
  "Tengo noticias que la corona lo tiene el lider de los Egs,",
  "Una extraña figura envuelta en una capa oscura...",
  "Continua con tu viaje, fuerzas!!"
};

//int estadoDialogo = 0; // Controla el estado del diálogo
boolean juegoIniciado = false; // Controla si el juego ha comenzado
boolean nivel1Completado = false; // Variables para manejar el círculo y los niveles
boolean slimeAgregado = false;


void setup() {
  fullScreen();
  // /********* Define las coordenadas de inicio de la segunda pantalla***/
  //int pantallaPrincipalWidth = displayWidth; // Ancho de la pantalla principal
  //int segundaPantallaX = pantallaPrincipalWidth; // Mueve a la derecha de la pantalla principal
  //int segundaPantallaY = 0; // Mantiene la ventana en la parte superior de la segunda pantalla

  // Ubica la ventana en la segunda pantalla
  //surface.setLocation(segundaPantallaX, segundaPantallaY);
  
  
  //******************************************************************
  
  // Inicializar el objeto Honeymon
  honeymoon = new Jugadora();
  
  hadaguia = loadImage("/juego/HadaGuia.png");
  fondoNivel1 = loadImage("/juego/FondoPalido.jpg"); // Fondo para nivel 1
  fondoNivel2 = loadImage("/juego/FondoFuerte.jpg"); // Fondo para nivel 2
  
  // Redimensionar los fondos
  fondoNivel1.resize(width, height);
  fondoNivel2.resize(width, height);
  
  fondo = fondoNivel2;
  
  
  // Inicializar la clase DialogoHada con los diálogos y la imagen del hada
  dialogoHada = new Dialogo(dialogoInicial, hadaguia);
  
  
 // Cargar la imagen de la nube
  imagenNube = loadImage("/juego/nube.png"); 
  // Inicializar la nube
  nube = new Nube(imagenNube);
  
    // Cargar las imágenes de las bolas de papel
  bolaAmarilla = loadImage("/bolasdepapel/amarilla.png");
  bolaRosa = loadImage("/bolasdepapel/rosa.png");
  bolaGris = loadImage("/bolasdepapel/gris.png");
  bolaVerde = loadImage("/bolasdepapel/verde.png");
  
  donaImagen = loadImage("/juego/rollut.png"); // Cargar la imagen de la dona rollut
  
   // Cargar los frames de animación del monstruo slime
  slimeFrames[0] = loadImage("/juego/1.png");
  slimeFrames[1] = loadImage("/juego/2.png");
  slimeFrames[2] = loadImage("/juego/3.png");
  slimeFrames[3] = loadImage("/juego/4.png");
  
  // Inicializar la lista de enemigos con 3 donas
  enemigos = new ArrayList<Enemigo>();
  for (int i = 0; i < 3; i++) {
    enemigos.add(new Rollut(donaImagen, random(100, width - 100), random(100, height - 150)));
  }
  
  // Crear el monstruo slime y lo agrega a la lista de enemigos
  //enemigos.add(new MonstruoSlime(slimeFrames, 200, height - 150));

}

void draw() {
  background(255);
  
  // Dibujar el fondo, asegurando que se repita de manera continua
  image(fondo, fondoX, 0);
  image(fondo, fondoX + fondo.width, 0);
  
  if (!juegoIniciado) {
    honeymoon.mostrar();
    dialogoHada.mostrar(); 
  } else {
    // El juego comienza aquí: Nivel 1
    if(!honeymoon.isJuegoTerminado()){
          if (!nivel1Completado) {
            if(slimeAgregado == false){
              fondo = fondoNivel1;
            }
              
              // Mostrar y mover la nube
              nube.mover();
              nube.mostrar();
              
              // Hacer que la nube lance círculos y actualizarlos
              nube.lanzarCirculo();
              nube.actualizarCirculos();
              
              // Verificar colisiones entre Honeymon y las bolas de papel
              honeymoon.verificarColisiones(nube.bolasPapel);
              
              enemigos.removeIf(enemigo -> enemigo instanceof MonstruoSlime && ((MonstruoSlime) enemigo).destruido);
              
              // Mover y mostrar los enemigos
              for (Enemigo enemigo : enemigos) {
                enemigo.mover();
                enemigo.mostrar();
                honeymoon.manejarColisionEnemigo(enemigo); // Verificar colisión con cada enemigo
              }
              
              // Mostrar el contador de bolas recogidas
              fill(255);
              textSize(30);
              text("Bolas de papel recogidas: " + honeymoon.contadorBolas, width-370, 40);
              text("Vidas: " + honeymoon.vidas, width-370, 80); // Mostrar el número de vidas restantes
              
              
              
              // Verificar si el contadorBolas ha alcanzado el límite
              if (honeymoon.contadorBolas > 20 && slimeAgregado == false) {
                fondo = fondoNivel2;
                // Añadir dos monstruos slime al juego
                enemigos.add(new MonstruoSlime(slimeFrames, random(100, width - 100), height - 150));
                enemigos.add(new MonstruoSlime(slimeFrames, random(100, width - 100), height - 150));
                slimeAgregado = true; // Para evitar que se sigan añadiendo monstruos slime
              }
              
              // Verificar si el contadorBolas ha alcanzado el límite para nivel 2
              if (honeymoon.contadorBolas > 30) {
                nivel1Completado = true; // Cambiar a nivel 2
                dialogoHada = new Dialogo(dialogoNivel1, hadaguia); 
                juegoIniciado = false;
              }
              
            } else {
              // Nivel 2: fondo en movimiento
              fill(255);
              textSize(30);
              text("Vidas: " + honeymoon.vidas, width-370, 80);
              
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
      
    }else{
      textSize(60);
        //fill(255, 0, 0);
        text("Game Over", width / 2 - 160, height / 2);
        noLoop(); // Detiene el juego
    }

    
    
    honeymoon.mover();
    honeymoon.manejarPoder(); 
    honeymoon.mostrar();
  }
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
    } else if (keyCode == UP) { // Tecla para saltar
      honeymoon.saltar();
      //println("Salto!");
    }
  }
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    honeymoon.detenerMovimiento();
  }
}
