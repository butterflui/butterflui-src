
/*
BISMILLAH
Graphical User Interface Library for Physical Computing
Displaying sensor data and controlling actuators
design and programming by Fatih Aydemir and Laurens Rinke
6th semester interaction design - 2013/14
hochschule für gestaltung schwäbisch gmünd
*/



//text 
PFont myText;
PFont myTextBold;
PFont myTextIcon;


//name of the sensor
String name;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
//das ist die beschreibung die im rahmen ist. momentan übernimmt sie
//glaub ich mindestens 10 oder 9 buchstaben. unter dieser zahl
//kommt eine fehlermeldung

//postition
float xpos = 3;
float ypos = 3;
float mousePositionX = mouseX-xpos;
float mousePositionY = mouseY-ypos;



int durchmesserButton = 45;


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
  size(87, 120);
  
  smooth();
    myTextIcon = createFont("sosa", 14, false);

   myText = createFont("unit-light", 14, false);
  myTextBold = createFont("unit-bold", 13, false);
  

}



void draw() {

  // clear background
  background(backGround);
  pushMatrix();
      translate(xpos,ypos);
      mousePositionX = mouseX-xpos;
      mousePositionY = mouseY-ypos;
  
      


      //STATE ANZEIGE//////////////////////////////////////////
      if(poti == 3)
      {
      fill(barGraph);
      } 
      else
      {
      fill(barGraphGround);
      }
      //ellipse(frameBreite/2, frameAbstandOben+5,durchmesserButton,durchmesserButton);
      rect(frameBreite/2, frameAbstandOben+5,durchmesserButton,durchmesserButton,7);
      
      //FRAME//////////////////////////////////////////////
        noFill();
        stroke(91,101,101); //farbe des frame
        strokeWeight(1);
        rectMode(CORNER);
        rect(0,0,frameBreite,frameHoehe,2);
        
        ///beschreibung
        //untergrund für text
        fill(backGround); // untergrund für text
        noStroke();
        rectMode(CENTER);
        rect(frameBreite/2,frameHoehe,53,20); 
      
        //sensor beschreibung
        name = "motorsteuerung";
        String ss3 = name.substring(0, 5);  // Returns "CC"
        fill(frameFarbe);
        textAlign(CENTER,CENTER);
        textFont(myText,15);
        text(ss3, frameBreite/2, frameHoehe);
        

          
          
          
          
          //settings/////////////////////////////////////////////////////
  //hover setting rect
  color setColorRect = color(255,0);
  color setColorSymbol = (int)frameColor;

  if (dist(frameBreite-40, 12, mousePositionX, mousePositionY) < 15)
  { 
         setColorRect = color(255,20); 
         setColorSymbol = color(255,180);     
    

     if(mousePressed)
     {
       setColorSymbol = 255;
     }
  }
 
  fill(setColorRect);
  rectMode(CENTER);
  rect(frameBreite-35, 14, 18, 18);

  //symbol setting
//  fill(setColorSymbol);
//  textAlign(CENTER, CENTER);
//  textFont(myTextIcon, 13);
//  text("W", frameBreite-35, 12);
  
   //symbol setting
  fill(setColorSymbol);
  rectMode(CORNER);
  rect(0+frameBreite-40,0+10,2,10);
  rect(-1+frameBreite-40,3+10,4,2);
  
  rect(5+frameBreite-40,0+10,2,10);
  rect(4+frameBreite-40,5+10,4,2);
  
  rect(10+frameBreite-40,0+10,2,10);
  rect(9+frameBreite-40,2+10,4,2);
  
  
  
  
  //hover close window////////////////////////////////////
  color setColorRect2 = color(255,0);
  color setColorSymbol2 = (int)frameColor;

  if (dist(frameBreite-15, 12, mousePositionX, mousePositionY) < 15)
  { 
         setColorRect2 = color(255,20); 
         setColorSymbol2 = color(255,180);     
    

     if(mousePressed)
     {
       setColorSymbol2 = 255;
     }
  }
 
  fill(setColorRect2);
  rectMode(CENTER);
  rect(frameBreite-15, 14, 18, 18);

  //symbol close
  fill(setColorSymbol2);
  textAlign(CENTER, CENTER);
  textFont(myTextIcon, 13);  
  text("ã", frameBreite-15, 12);
  
  
   popMatrix();
   
   
   //ZUFALLSGENERATOR/////////////////////////////////////////////////////
  generator = (int)random(0,50);
  poti = generator;
  //poti = 3;

}


