class Plataforma {
  PImage imagen;
  float x, y, ancho, alto;
  
  Plataforma(PImage imagen, float x, float y, float ancho, float alto) {
    this.imagen = imagen;
    this.x = x;
    this.y = y;
    this.ancho = ancho;
    this.alto = alto;
  }
  
  void mostrar(float fondoX) {
    image(imagen, x+fondoX, y,ancho,alto);
  }
   
   
  boolean colisionaCon(float jugadorX, float jugadorY, float jugadorWidth, float jugadorHeight, float platX) {
    //rect(x+platX, y, ancho, alto);
    //rect(jugadorX,jugadorY, jugadorWidth-50, jugadorHeight);
    return jugadorX + jugadorWidth-50 > x+platX && jugadorX+50 < x+platX + ancho &&
           jugadorY + jugadorHeight > y && jugadorY < y + alto-40;
  }
  
  boolean fueraLimites(float jugadorX, float jugadorWidth, float platX) {
    return  jugadorX + jugadorWidth-50 > x+platX && jugadorX+50 < x+platX + ancho;
    
  }
 
}
