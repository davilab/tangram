import static javax.swing.JOptionPane.*;

float tam,xt,yt,xt_,yt_,xc,yc,xtg,ytg,xtg_,ytg_,xp,yp,xtm,ytm;
float lado,area;
int figura = 7;
int colores[][] = {{255,128,0},{153,76,0},{0,255,0},{51,255,255},{255,0,0},{255,0,255},{255,255,0}};  
float rotacion[] = {0,0,0,0,0,0,0};
int flip = 1;
void setup(){
  fullScreen();
  tam = width/10;
  xt_= xc = xtm = width/10;
  xtg = xtg_ =  width/3;
  xt = xp = width*3/5;
  yt = yt_ = height*16/50;
  yc = yp = height*26/50;
  ytm = height*40/50;
  ytg = height*12/50;
  ytg_= height*32/50;
  lado=sqrt(2*pow(tam*2,2));
  area=pow(lado,2);
}
void mousePressed(){
  for(int i = 0 ; i<7 ; i++){
    if(get(mouseX,mouseY) == color(colores[i][0],colores[i][1],colores[i][2])){
      figura = i;
      break;
    }
  }
}
void mouseDragged(){
  switch(figura){
    case 0:
      xt += (mouseX - pmouseX);
      yt += (mouseY - pmouseY);
      break;
    case 1:
      xt_ += (mouseX - pmouseX);
      yt_ += (mouseY - pmouseY);
      break;
    case 2:
      xc += (mouseX - pmouseX);
      yc += (mouseY - pmouseY);
      break;
    case 3:
      xtg += (mouseX - pmouseX);
      ytg += (mouseY - pmouseY);
      break;
    case 4:
      xtg_ += (mouseX - pmouseX);
      ytg_ += (mouseY - pmouseY);
      break;
    case 5:
      xp += (mouseX - pmouseX);
      yp += (mouseY - pmouseY);
      break;
    case 6:
      xtm += (mouseX - pmouseX);
      ytm += (mouseY - pmouseY);
      break;    
  }
}
void mouseClicked(){
  if(mouseButton == RIGHT){
    switch(figura){
      case 0:
        rotacion[0] += PI/4;
        break;
      case 1:
        rotacion[1] += PI/4;
        break;
      case 2:
        rotacion[2] += PI/4;
        break;
      case 3:
        rotacion[3] += PI/4;
        break;
      case 4:
        rotacion[4] += PI/4;
        break;
      case 5:
        rotacion[5] += PI/4;
        break;
      case 6:
        rotacion[6] += PI/4;
        break;
    }
  }
  if(mouseButton == CENTER && get(mouseX,mouseY)==color(colores[5][0],colores[5][1],colores[5][2]))flip *= -1;
}
boolean cuadrado(){
  int cont=0;
  for(int i=width/3; i<=(width/3)+lado; i++){
    for(int j=height/3; j<=(height/3)+lado; j++){
      if(get(i,j)==color(255))
        cont ++;
    }
  }
  if(cont<area*0.01){
    cont=0;
    return true;
  }
  else return false;
}
void draw(){
  background(160,160,160);
  loadPixels();
  strokeWeight(0);
  
  //fuente
  
  PFont font;
  font = loadFont("ShowcardGothic-Reg-70.vlw");  
  textFont(font,width/15);
  fill(255,0,40);
  text("Tangram",width/3,height*1/8);
  textFont(font,width/45);
  
  //cuadrado
  fill(255);
  rect(width/3,height/3,lado,lado);

  
  float coordenadas[][] = {{xt,yt},{xt_,yt_},{xc,yc},{xtg,ytg},{xtg_,ytg_},{xp,yp},{xtm,ytm}};

  //Figuras
  
  for(int i = 0; i<7; i++){
    pushMatrix();
    fill(colores[i][0],colores[i][1],colores[i][2]);
    translate(coordenadas[i][0],coordenadas[i][1]);
    rotate(rotacion[i]);
    switch(i){
      case 0:  
      case 1:    
        beginShape();                                             //triangulo peque
        vertex(-tam/2,-tam/2);
        vertex(-tam/2+tam,-tam/2);
        vertex(-tam/2,-tam/2+tam);
        endShape();
        break;
      case 2:
        rect(-tam/2,-tam/2,tam,tam);                                      //cuadrado
        break;
      case 3:
      case 4:
        beginShape();                                             //triangulo grande
        vertex(-tam/2,-tam/2);
        vertex(-tam/2+tam*2,-tam/2);
        vertex(-tam/2,-tam/2+tam*2);
        endShape();                                               
        break;
      case 5:
        beginShape();                                             //paralelepipedo
        vertex((-tam/2)*flip,-tam/2);
        vertex((tam/2)*flip,-tam/2);
        vertex((3*tam/2)*flip,tam/2);
        vertex((tam/2)*flip,tam/2);
        endShape();
        break;
      case 6:
        beginShape();                                             //triangulo mediano
        vertex(-tam/2,-tam/2);
        vertex(-tam/2+sqrt(2*pow(tam,2)),-tam/2);
        vertex(-tam/2,-tam/2+sqrt(2*pow(tam,2)));
        endShape(); 
        break;
    }
    popMatrix();
  }
  if(cuadrado()){
    showMessageDialog(null,"has ganado");
    exit();
  }
}
