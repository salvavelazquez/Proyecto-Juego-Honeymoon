import java.awt.Canvas;
import processing.sound.*;
SoundFile sonidoUno, sonidoDos,win , salto;


Jugadora honeymoon;
Enemigo enemigo; // Declara el objeto enemigo
Enemigo zombie;
Enemigo vampirut;
Dialogo dialogoHada;
Dialogo dialogoJefe;
Nube nube;   


PImage imagenNube, bolaAmarilla, bolaRosa, bolaGris, bolaVerde;
PImage hadaguia, castillo, reina , corona;
PImage fondoNivel1, fondoNivel2, fondoNivel3,fondoNivel4, fondo, fondoRedimensionado;
PImage donaImagen, zombieaux;
PImage plataformaChocolate;
PImage carameloImagen;
PImage imagenBolaDeFuego;


PImage[] slimeFrames = new PImage[4];
PImage[] zombieFrames = new PImage[3];


float  fondoX = 0;  // Variable para controlar la posición del fondo
float  fondoVelocidad = 8;  // Velocidad de desplazamiento del fondo

ArrayList<Plataforma> plataformas;
ArrayList<Enemigo> enemigos;
String[] dialogoInicial = {
  "    ¡Hola Honeymoon! Tienes una nueva misión!!",
  "         Encuentra la corona de la princesa de\n              Caramelos para su coronación.",
  "Los Egs no quieren que sea reina así que robaron \nla corona del reino...",
  "El bosque está todo contaminado, recoje lo que \npuedas para poder avanzar! .",
  "A las Rolluts saltarinas no les afecta tu poder...\n                                            ¡ten mucho cuidado! ¡Suerte!",
  
};

String[] dialogoNivel1 = {
  "¡Bien hecho! Curaste el mundo de caramelos!!",
  "Tengo noticias que la corona lo tiene el lider de los Egs,",
  "Una extraña figura envuelta en una capa oscura...",
  "Escapa del zombie gigante! no dejes que te aplaste!",
  "Continua con tu viaje, fuerzas!!"
};

boolean dialogoCarameloMostrado = false;
String[] dialogoCaramelo = {
    "          ¡Has encontrado el caramelo Sagrado!",
    "           Tendrás nuevos movimientos!! "
};

String[] dialogoJefeFinal = {
    "          ¡bla bla bla soy Vampirut y robé la corona de caramelos",
    "           Podrás detenerme? no lo creo bla bla bla... "
};

boolean juegoIniciado = false; // Controla si el juego ha comenzado
boolean nivel1Completado = false; // Variables para manejar el círculo y los niveles
boolean parteDos = false;
boolean slimeAgregado = false;
boolean zombieAgregado = false;
float plataformaX = 0;
int indicePlataformaActual = -1;


boolean animacionFondoActiva = false;  // Indica si la animación del fondo está activa
int tiempoInicioAnimacion;             // Tiempo de inicio de la animación
int fondoActual = 1;                   // Alterna entre los dos fondos
PImage vampiro; 

boolean  inicioDialogoVampiro = false; 
boolean finalDialogoVampiro = false;
boolean activaSonidoDos = false;

void setup() {
  fullScreen();
   /********* Define las coordenadas de inicio de la segunda pantalla***/
  //int pantallaPrincipalWidth = displayWidth; // Ancho de la pantalla principal
  //int segundaPantallaX = pantallaPrincipalWidth; // Mueve a la derecha de la pantalla principal
  //int segundaPantallaY = 0; // Mantiene la ventana en la parte superior de la segunda pantalla

  //// Ubica la ventana en la segunda pantalla
  //surface.setLocation(segundaPantallaX, segundaPantallaY);
  
  
  //******************************************************************
  sonidoUno = new SoundFile(this, "musica/1.mp3");
  sonidoDos = new SoundFile(this, "musica/2.mp3");
  salto = new SoundFile(this, "musica/jump.wav");
  win = new SoundFile(this, "musica/win.mp3");
  sonidoUno.loop();
  sonidoUno.amp(0.2);
  
  // Inicializar el objeto Honeymon
  honeymoon = new Jugadora();
  
  hadaguia = loadImage("/juego/HadaGuia.png");
  fondoNivel1 = loadImage("/juego/FondoPalido.jpg"); // Fondo para nivel 1
  fondoNivel2 = loadImage("/juego/Fondo2tonos.jpg"); // Fondo para nivel 2
  fondoNivel3 = loadImage("/juego/FondoFuerte.jpg"); // Fondo para nivel 3
  fondoNivel4 = loadImage("/juego/FondoInverso.jpg");
  castillo = loadImage("/juego/castillo.png");
  castillo.resize(757, 737);
  reina = loadImage("/juego/reina1.png");
  corona = loadImage("/juego/corona.png");
  vampiro = loadImage("/enemigos/vampirodona.png");  // Carga la imagen del vampiro
  vampiro.resize(209, 252); 
  
  // Redimensionar los fondos
  fondoNivel1.resize(width, height);
  fondoNivel2.resize(width, height);
  fondoNivel3.resize(width, height);
  fondoNivel4.resize(width, height);
  
  fondo = fondoNivel3;
  
  
  // Inicializar la clase DialogoHada con los diálogos y la imagen del hada
  dialogoHada = new Dialogo(dialogoInicial, hadaguia);
  dialogoJefe = new Dialogo(dialogoJefeFinal, vampiro );
  
 // Cargar la imagen de la nube
  imagenNube = loadImage("/juego/nube.png"); 
  // Inicializar la nube
  nube = new Nube(imagenNube);
  
    // Cargar las imágenes de las bolas de papel
  bolaAmarilla = loadImage("/bolasdepapel/amarilla.png");
  bolaRosa = loadImage("/bolasdepapel/rosa.png");
  bolaGris = loadImage("/bolasdepapel/gris.png");
  bolaVerde = loadImage("/bolasdepapel/verde.png");
  
  donaImagen = loadImage("/enemigos/rollut2.png"); // Cargar la imagen de la dona rollut
  
   // Cargar los frames de animación del monstruo slime
  slimeFrames[0] = loadImage("/enemigos/slime/1.png");
  slimeFrames[1] = loadImage("/enemigos/slime/2.png");
  slimeFrames[2] = loadImage("/enemigos/slime/3.png");
  slimeFrames[3] = loadImage("/enemigos/slime/4.png");
  
  zombieaux = loadImage("/enemigos/zombie/1.png");
  zombieaux.resize(439, 417);
  zombieFrames[0] = zombieaux;
  
  zombieaux = loadImage("/enemigos/zombie/2.png");
  zombieaux.resize(439, 417);
  zombieFrames[1] = zombieaux;
  
  zombieaux = loadImage("/enemigos/zombie/3.png");
  zombieaux.resize(439, 417);
  zombieFrames[2] = zombieaux;
  
  plataformaChocolate = loadImage("/juego/barra.PNG");
  carameloImagen = loadImage("/juego/caramelo.png");
  carameloImagen.resize(100, 70);
  imagenBolaDeFuego = loadImage("/poder/fire.png");
  imagenBolaDeFuego.resize(45, 40);
  plataformas = new ArrayList<Plataforma>();
  
  // Agregar plataformas en posiciones fijas
  
  plataformas.add(new Plataforma(plataformaChocolate, -10,400,100,42));
  plataformas.add(new Plataforma(plataformaChocolate, -2600,500,800,42));
  plataformas.add(new Plataforma(plataformaChocolate, -3000,400,100,52));
  plataformas.add(new Plataforma(plataformaChocolate, -3200,300,200,52));
  plataformas.add(new Plataforma(plataformaChocolate, -3700,250,400,52));
  
  zombie = new Zombie(zombieFrames, width+100, height -464);
  vampirut = new Vampiro(vampiro, -600, height / 2 - vampiro.height / 2, 100);
  
  // Inicializar la lista de enemigos con 3 donas
  enemigos = new ArrayList<Enemigo>();
  for (int i = 0; i < 3; i++) {
    enemigos.add(new Rollut(donaImagen, random(100, width - 100), random(100, height - 150)));
  }
  
  
  
  // Solicita el foco para la ventana al inicio
  Canvas canvas = (Canvas) surface.getNative();
  canvas.requestFocus();
}

void draw() {
  background(255);
  
  // Dibujar el fondo, asegurando que se repita de manera continua
  image(fondo, fondoX, 0);
  image(fondo, fondoX + fondo.width, 0);
  
  if (!juegoIniciado) {
    honeymoon.reiniciar();
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
              //text("Bolas de papel recogidas: " + honeymoon.contadorBolas, width-370, 40);
              text("Vidas: " + honeymoon.vidas, width-150, 50); // Mostrar el número de vidas restantes
              
              
              
              // Verificar si el contadorBolas ha alcanzado el límite
              if (honeymoon.contadorBolas > 11 && slimeAgregado == false) {
                fondo = fondoNivel2;
                // Añadir dos monstruos slime al juego
                enemigos.add(new MonstruoSlime(slimeFrames, random(100, width - 100), height - 150));
                enemigos.add(new MonstruoSlime(slimeFrames, random(100, width - 100), height - 150));
                slimeAgregado = true; // Para evitar que se sigan añadiendo monstruos slime
              }
              
              // Verificar si el contadorBolas ha alcanzado el límite para nivel 2
              if (honeymoon.contadorBolas > 21) {
                fondo = fondoNivel3;
                nivel1Completado = true; // Cambiar a nivel 2
                dialogoHada = new Dialogo(dialogoNivel1, hadaguia); 
                juegoIniciado = false;
              }
              
            } else {
              // Nivel 2: fondo en movimiento
              if(!parteDos){
                  // Mantener honeymoon en el centro de la pantalla
                  honeymoon.posicionX = width / 2;
                  
                  if (honeymoon.enMovimiento) {
                    if (honeymoon.apuntaDerecha) {
                      plataformaX-= fondoVelocidad;
                      fondoX -= fondoVelocidad; // Desplazar el fondo hacia la izquierda
                    } else {
                      fondoX += fondoVelocidad; // Desplazar el fondo hacia la derecha
                      plataformaX += fondoVelocidad;
                    }
                  }
                  
                  
                  
                  
                  
                  // Mantener el fondo en bucle
                  if (fondoX <= -fondo.width) {
                    fondoX = 0;
                  }
                  if (fondoX >= 0) {
                    fondoX = -fondo.width;
                  }
                  
                  
                  int i = 0;
                  // Mostrar y verificar colisiones con las plataformas
                  for (Plataforma plataforma : plataformas) {
                    plataforma.mostrar(plataformaX);
                    if (plataforma.colisionaCon(honeymoon.posicionX, honeymoon.posicionY, honeymoon.ancho, honeymoon.alto, plataformaX)) {
                       honeymoon.posicionY = plataforma.y - honeymoon.alto-2; // Honeymoon se sitúa en la plataforma
                       honeymoon.saltando = false; 
                       honeymoon.sobrePlataforma = true;  
                       indicePlataformaActual = i;
                    }
                    
                    if(indicePlataformaActual == i && honeymoon.sobrePlataforma){
                      if (!plataforma.fueraLimites(honeymoon.posicionX, honeymoon.ancho, plataformaX)) {
                        honeymoon.saltando = true;
                        honeymoon.sobrePlataforma = false;
                       
                      }
                        
                    }
                    
                     i++;
                    
                  }
                  
                  // Mostrar y mover al zombie nivel 2
                  zombie.mover();
                  zombie.mostrar();
                  honeymoon.manejarColisionEnemigo(zombie);                      
              
              }else{
                if(!dialogoCarameloMostrado){
                          dialogoHada = new Dialogo(dialogoCaramelo, hadaguia);
                          juegoIniciado = false;
                          dialogoCarameloMostrado = true;
                          fondoX = 0;
                          honeymoon.apuntaDerecha = false;
                          
                }else{
                
                    if(!activaSonidoDos){
                          sonidoUno.stop();
                          sonidoDos.play();
                          sonidoDos.amp(0.4);
                        activaSonidoDos = true;
                    }
                    
                    if (!animacionFondoActiva) {
                      animacionFondoActiva = true;
                      tiempoInicioAnimacion = millis();  // Guarda el tiempo de inicio de la animación  
                  }
                    
                    int tiempoTranscurrido = millis() - tiempoInicioAnimacion;
                    
                    if (tiempoTranscurrido < 5500) {  // Cambia los fondos durante 5 segundos
                      if (tiempoTranscurrido / 1000 % 2 == 0) {
                        fondo = fondoNivel3;  // Fondo alternativo
                      } else {
                        fondo = fondoNivel4;  // Otro fondo alternativo
                      }
                      image(fondo, 0, 0, width, height);  // Dibuja el fondo actual
                      
                      vampirut.mover();
                      vampirut.mostrar();
                      
                    } else {
                     
                      fondo = fondoNivel4;  // Fija un fondo después de la animación
                      image(fondo, 0, 0, width, height);
                       
                       vampirut.mover();
                       vampirut.mostrar();
                       
                                      
                    if (!finalDialogoVampiro) {
                          inicioDialogoVampiro = true; // Evita que se repita el diálogo
                          dialogoJefe.dialogoVampirut();
                      }
                      
                    fill(#FF4BDE);
                    textSize(30);
                    text("Vidas: " + honeymoon.vidas, width-150, 50);  
                    
                    
                         
                         
                    }
                
                }
                
                
              }
              
                             
            }
             
    }else{
      textSize(90);
        textAlign(CENTER);
        text("Game Over \n", width / 2 , height / 2);
        textSize(50);
        text("(Presiona R para reiniciar el nivel)", width / 2 , height / 2+90);
        textAlign(LEFT);
        noLoop(); // Detiene el juego
    }

    
    honeymoon.mover();
    honeymoon.manejarPoder(); 
    honeymoon.mostrar();
    
    if(!((Vampiro) vampirut).estaVivo()){
                      //dialogoCarameloMostrado = true;
                      win.play();
                      noTint();  
                      image(fondoNivel3, fondoX, 0);
                      image(castillo, 0, height-765);
                      image(reina,300,height/2-40,140,140);
                      image(honeymoon.alzar, width/2+170, height-190);   
                      image(corona,width/2+130,height-300,90,70);
                         fill(#FFFFFF);
                         textSize(80);
                         text("GANASTE!", width/2-150, height/2);
                         noLoop();
                    }
  }
}

void reinicioDeNivel() {
    if(!nivel1Completado){
      juegoIniciado = false;
        fondo = fondoNivel1;
        
        for (Enemigo enemigo : enemigos) {
                if(enemigo instanceof MonstruoSlime){
                  ((MonstruoSlime) enemigo).desaparecer();
                }
              }
        slimeAgregado = false;
        nube.eliminarTodoPapel();
        sonidoUno.stop();
        sonidoUno.loop();
        sonidoUno.amp(0.2);
        
    }else {
      juegoIniciado = false;
      fondo = fondoNivel3;
      ((Zombie)zombie).reiniciar();
      //plataformas.clear();
      plataformaX = 0;
      parteDos = false;
      finalDialogoVampiro = false;
      inicioDialogoVampiro = false;
      animacionFondoActiva = false; 
      dialogoCarameloMostrado = false;
      dialogoHada = new Dialogo(dialogoNivel1, hadaguia); 
      ((Vampiro)vampirut).x = - 600;
      ((Vampiro)vampirut).y = height / 2 - vampiro.height / 2;
      ((Vampiro)vampirut).vida = 100;
      ((Vampiro)vampirut).rolluts.clear();
      activaSonidoDos = false;
      sonidoDos.stop();
      sonidoUno.loop();
      sonidoUno.amp(0.2);
    }
}

void keyPressed() {
 if (!juegoIniciado || inicioDialogoVampiro) {
   if (key == ' ') {
     if(!inicioDialogoVampiro){
         dialogoHada.avanzarDialogo();
         if (dialogoHada.dialogoTerminado()) {
            juegoIniciado = true;  // Cuando se acaba el diálogo, inicia el juego
         }
      }else{ 
          dialogoJefe.avanzarDialogo();
          if (dialogoJefe.dialogoTerminado()) {
             finalDialogoVampiro = true;
             inicioDialogoVampiro = false;
           }
      }
   
   } 
    
  } else {
    if(!parteDos || (parteDos && finalDialogoVampiro)){
          if (keyCode == RIGHT) {
            honeymoon.activarMovimiento(true);
          } else if (keyCode == LEFT) {
            honeymoon.activarMovimiento(false);
          } else if (key == ' ') {
            honeymoon.activarPoder();
          } else if (keyCode == UP) { // Tecla para saltar
            if(!parteDos){
              honeymoon.saltar();
              //if(!honeymoon.saltando) 
            }else{  honeymoon.arriba = true; }
          }else if(keyCode == DOWN){
            if(parteDos){
              honeymoon.arriba = false;
            }
          } else if (key == 'r' || key == 'R') {
                    
              loop();
              honeymoon.reiniciar(); // Reiniciar el estado de la Jugadora
              
              // Reiniciar otros elementos del juego, si es necesario
              reinicioDeNivel();
          }
    }

  }
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    honeymoon.detenerMovimiento();
  }
}
