//actual values for the barGraph lenght, starting from zero
float poti;

//name of the sensor
String name;

//positioning
int xpos=40;
int ypos=55;

//frame
boolean frame = true;
int frameFarbe = color(150,150,150);

//min
boolean minimum =true;
float[] xPosMin = new float[100];
float zeigerMin;
float minn;
color minFarbe = color(57, 122, 156);

//max
boolean maximum = true;
float[] xPosMax = new float[100];
float maxx;
color maxFarbe = color(57, 122, 156);

//treshold
float treshold = 700;
color tresholdColor = color(123, 50, 34);

//tickMarks
boolean tickMarks = true;

//skalen nummern
boolean scale = true;
color skalenFarbe = color(150,150,150);

//farben generell
color backGround = color(48, 55, 57); //hintergrundfarbe
color barGraph = color(56, 135, 166);
color barGraphGround = color(97, 100, 101);


//zufallsgenerator
float generator;
float startWert = 0.7;
float incrementWert = 0.005;





void setup() {
  size(170, 100);
  smooth();
  noStroke();

  
  
  
  
}



void draw() {

  // clear background
  background(backGround);
    rectMode(CORNER);
pushMatrix();
translate(35,55);
//BALKEN UNTERGRUND//////////////////////////////////////////////
  noStroke();
  fill(barGraphGround);
  int breite = 100;
  rect(0,-10, breite, 15,2);
  
  
//BALKEN //////////////////////////////////////////////
  
    fill(barGraph);
  float potiRect = map(poti,0,1024,0,100); // mapping des potiWertes von 1024 auf 150
  rect(0, -10, potiRect, 15,2);  // aktueller wert als balken dargestellt
  
popMatrix();





//FRAME//////////////////////////////////////////////
  //rahmen
  noFill();
  stroke(91,101,101); //farbe des frame
  strokeWeight(1);
  rectMode(CENTER);
  rect(width/2,height/2,150,90,2);



  
  
//ZUFALLSGENERATOR/////////////////////////////////////////////////////
    generator =(noise(startWert+= incrementWert));
    generator = map(generator,0,1,0,1024);
        //println("generator   "+generator);

    poti = generator;
  
}


