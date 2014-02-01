
/*
BISMILLAH
Graphical User Interface Library for Physical Computing
Displaying sensor data and controlling actuators
design and programming by Fatih Aydemir and Laurens Rinke
6th semester interaction design - 2013/14
hochschule für gestaltung schwäbisch gmünd
*/





//postition



int durchmesserButton = 50;


//frame
boolean frame = true;
int frameFarbe = color(150,150,150);
float frameAbstandSeite = 15;
float frameColor = 180;


float frameBreite = durchmesserButton + frameAbstandSeite*2;
float frameAbstandOben= 32+durchmesserButton/2;
float frameHoehe = frameAbstandOben+durchmesserButton;

//farben generell
color backGround = color(48, 55, 57); //hintergrundfarbe
color barGraph = color(56,135,166);
color barGraphGround = color(152, 156, 156);


//zufallsgenerator
int poti;
int generator;


void setup() {

  // size
  size(170, 100);
  
  smooth();


 
}



void draw() {

  // clear background
  background(backGround);
  pushMatrix();
      


      //STATE ANZEIGE//////////////////////////////////////////
      if(poti == 3 )
      {
      fill(barGraph);
      } 
      else
      {
      fill(barGraphGround);
      }
      rectMode(CENTER);

      //ellipse(frameBreite/2, frameAbstandOben+5,durchmesserButton,durchmesserButton);
      rect(width/2,height/2,45,45,4);
      
      //FRAME//////////////////////////////////////////////
        noFill();
        stroke(91,101,101); //farbe des frame
        strokeWeight(1);
        rect(width/2,height/2,150,90,2);
        
       

          
          
          
          
          //settings/////////////////////////////////////////////////////
  //hover setting rect
  color setColorRect = color(255,0);
  color setColorSymbol = (int)frameColor;

  rectMode(CENTER);

   popMatrix();
   
   
   //ZUFALLSGENERATOR/////////////////////////////////////////////////////
  generator = (int)random(0,5);
  poti = generator;
  //poti = 3;

}



