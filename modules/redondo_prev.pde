//actual values for the barGraph lenght, starting from zero
float poti;
float poti2;


//name of the sensor
String name;


//frame
boolean frame = true;
int frameFarbe = color(150, 150, 150);
int radius = 60;
int radius2 = radius-40;
int breiteFrame = 150;
int frameHoehe = 90;




//farben generell
color backGround = color(48, 56, 58); //hintergrundfarbe
color barGraph = color(56, 135, 166);
color barGraphGround = color(152, 156, 156);
color barGraph2 = color(80, 185, 206);



//zufallsgenerator
float generator;
float startWert = 0.7;
float incrementWert = 0.009;

float generator2;
float startWert2 = 0.3;
float incrementWert2 = 0.01;





void setup() {
  size(170, 100);
  noStroke();
  smooth();

}



void draw() {

  // clear background
  background(backGround);



  //KREIS UNTERGRUND 111111111//////////////////////////////////////////////
  noFill();
  stroke(barGraphGround);
  strokeWeight(13);
  ellipseMode(CENTER);
  ellipse(width/2, height/2, radius, radius); 
  noStroke(); 


  //KREIS UNTERGRUND 22222222222//////////////////////////////////////////////
  noFill();
  stroke(barGraphGround);
  strokeWeight(13);
  ellipseMode(CENTER);
  ellipse(width/2, height/2, radius2, radius2); 
  noStroke(); 


  //BALKEN + TRESHOLD 11111111111111//////////////////////////////////////////////

  noFill();
  strokeWeight(13);
  float grad = map(poti, 0, 1024, 0, 360);
  stroke(barGraph);
  //println("graaaaaad  "+grad);
  strokeCap(SQUARE);
  arc(width/2, height/2, radius, radius, radians(-90), radians(grad-90));




  //BALKEN + TRESHOLD22222222222//////////////////////////////////////////////
  noFill();
  strokeWeight(13);
  println("davor    "+poti2);
  float grad2 = map(poti2, 0, 1024, 0, 360);

  println("danach    "+grad2);
  stroke(barGraph);
  //println("graaaaaad  "+grad);
  strokeCap(SQUARE);
  stroke(barGraph2);
  arc(width/2, height/2, radius2, radius2, radians(-90), radians(grad2-90)); //blauer arc der unten liegt



  //FRAME//////////////////////////////////////////////
  noFill();
  stroke(91, 101, 101); //farbe des frame
  strokeWeight(1);
  rectMode(CENTER);

  rect(width/2, height/2, 150, 90, 2);







  //ZUFALLSGENERATOR/////////////////////////////////////////////////////
  generator =(noise(startWert+= incrementWert));
  generator = map(generator, 0, 1, 0, 1024);

  poti = generator;
 

  generator2 =(noise(startWert2+= incrementWert2));
  generator2 = map(generator2, 0, 1, 0, 1024);

  poti2 = generator2;
}

