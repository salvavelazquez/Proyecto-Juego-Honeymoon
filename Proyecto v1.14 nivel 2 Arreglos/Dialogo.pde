class Dialogo {
  PImage hada; // Imagen del hada
  String[] dialogos; // Diálogos del juego
  int estadoDialogo = 0; // Estado actual del diálogo

  Dialogo(String[] dialogos, PImage hada) {
    this.dialogos = dialogos;
    this.hada = hada;
  }

  // Mostrar el diálogo y la imagen del hada
  void mostrar() {
    // Mostrar cuadro de diálogo
    fill(255, 255, 255, 200);  // Fondo blanco semitransparente para el diálogo
    rect(280, 330, width/2 + 100, 150, 20);  // Crear el globo de diálogo
    
    // Mostrar texto del diálogo
    fill(0); 
    textSize(25);
    text(dialogos[estadoDialogo], width/2-300, height/2 - 2, width - 140, 140); 
    
    // Mostrar imagen del hada
    image(hada, width - 400, height / 2 + 50, 130, 130);
    if(dialogoCarameloMostrado) image(carameloImagen, width - 230, height - 280);
  }
  
  //Dialogo Jefe Final
  void dialogoVampirut() {
    fill(255, 255, 255, 200);  // Fondo blanco semitransparente para el diálogo
    rect(280, 330, width/2 + 100, 150, 20);  // Crear el globo de diálogo
    
    // Mostrar texto del diálogo
    fill(0); 
    textSize(25);
    text(dialogos[estadoDialogo], width/2-300, height/2 - 2, width - 140, 140); 
    
  }

  // Avanzar al siguiente diálogo
  void avanzarDialogo() {
    estadoDialogo++;
  }

  // Comprobar si se ha terminado el diálogo
  boolean dialogoTerminado() {
    if(estadoDialogo >= dialogos.length){
      estadoDialogo = 0;
      return true;
    }else{
      return false;
    }
   
  }
  
  
  
  
}
