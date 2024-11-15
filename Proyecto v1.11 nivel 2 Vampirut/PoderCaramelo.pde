class PoderCaramelo {
  float x, y;
  PImage imagen;
  float ancho = 100, alto = 70;

  PoderCaramelo(float x, float y, PImage imagen) {
    this.x = x;
    this.y = y;
    this.imagen = imagen;
  }

  void mostrar() {
    image(imagen, x+plataformaX, y);
  }

  void mover() {
     // Velocidad de caída
    if (y + alto < height - 70) { // Detenerse en el "suelo"
      y += 2;
    }
  }
  
  
  void colisionaCon() {
    if( honeymoon.posicionX + honeymoon.ancho-50 > x+plataformaX && honeymoon.posicionX+50 < x+plataformaX + honeymoon.ancho &&
        honeymoon.posicionY + honeymoon.alto > y && honeymoon.posicionY < y + honeymoon.alto-40){
        parteDos = true;       
    }
  }
}
