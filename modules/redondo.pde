
/*
BISMILLAH
Graphical User Interface Library for Physical Computing
Displaying sensor data and controlling actuators
design and programming by Fatih Aydemir and Laurens
6th semester interaction design - 2013/14
hochschule für gestaltung schwäbisch gmünd
*/


//actual values for the barGraph lenght, starting from zero
float poti;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!! 
//poti ist die variable, die aus dem arduino kommt. weiter unten im code
// ist poti mit dem zufallsgenerator gekoppelt.

float poti2;

//name of the sensor
String name;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
//das ist die beschreibung die im rahmen ist. momentan übernimmt sie
//glaub ich mindestens 10 oder 9 buchstaben. unter dieser zahl
//kommt eine fehlermeldung

//postition
float  xpos=3, ypos=10;
float mousePositionX = mouseX-xpos;
float mousePositionY = mouseY-ypos;

//display
int zufall;
boolean display = true;

//frame
boolean frame = true;
float frameColor = 180;
float durchmesserGross = 150;
float durchmesserKlein = durchmesserGross-40;
float frameAbstandSeite = 40;

float frameBreite = durchmesserGross+frameAbstandSeite*2;
float frameAbstandOben = 40;
//float frameHoehe = frameAbstandOben+durchmesserGross+frameAbstandSeite+300;
float frameHoehe = 440;



boolean open = false;
float incrementOpen = 1;

//play
boolean play = false;
boolean pause = true;
float x;
float y;
float xSlider = durchmesserGross+frameAbstandSeite;
float frameHoehePlay = 0;

//min
boolean minimum =true;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
// mit diesem boolean kann der minimumwert ein oder ausgeschaltet werden

float[] xPosMin = new float[100];
float[] xPosMin2 = new float[100];
float minn;
float minn2;
color minFarbe = color(48, 56, 58); //backgroundfarbe

//max
boolean maximum = true; //!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
// mit diesem boolean kann der maximumwert ein oder ausgeschaltet werden

float[] xPosMax = new float[100];
float[] xPosMax2 = new float[100];
float maxx;
float maxx2;
color maxFarbe = color(255);


//treshold11111
float treshold = 600;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
// mit diesem wert kann der threshold eingestellt werden

color tresholdColor = color(166, 47, 25);
boolean tresholdRand = false;
//darkening
int tresholdFarbeAlpha = 0;
int farbeWeg = 5;
// array für nachschwingen
float zeigerAnzeigeTres;
float[] tresMax = new float[150];
float[] tresMax2 = new float[150];


//treshold2
float treshold2 = 600;
boolean tresholdRand2 = false;
//darkening
int tresholdFarbeAlpha2 = 0;
int farbeWeg2 = 5;


//tickMarks
boolean tickMarks = true;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
// mit diesem wert können die tickmarks ein oder ausgeblendet werden


//skalen nummern
boolean scale = true;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
// mit diesem wert können die skalen nummern ein oder ausgeblendet werden
color skalenFarbe = color(150, 150, 150);
String[] arrayOfScale = {
  "256", "", "768", ""
};


//farben generell
color backGround = color(48, 56, 58); //hintergrundfarbe
color barGraph = color(56, 135, 166);
color barGraph2 = color(80, 185, 206);
color barGraphGround = color(152, 156, 156);
color textColor = color(255);


//text 
PFont myText;
PFont myTextBold;
PFont myTextIcon;

//zufallsgenerator
float generator;
float startWert = 0.09;
float incrementWert = 0.009;

float generator2;
float startWert2 = 0.003;
float incrementWert2 = 0.002;





void setup() {
  size(237, 510);
  noStroke();
  smooth();

  myTextIcon = createFont("sosa", 14, false);
  myText = createFont("unit-light", 14, false);
  myTextBold = createFont("unit-bold", 13, false);

  for (int i = 0; i < xPosMin.length; i ++ ) {
    xPosMin[i] = 0;
  }

  for (int i = 0; i < xPosMin2.length; i ++ ) {
    xPosMin2[i] = 0;
  }
}









void draw() {

  // clear background
  background(backGround);
  pushMatrix();
  
  translate(xpos, ypos);
  mousePositionX = mouseX-xpos;
  mousePositionY = mouseY-ypos;
  
  
  if(play)
  {
  y = frameHoehe;
  }
  else
  {
  x = frameBreite/2-4;
  }
  y = frameHoehe;


  if (durchmesserGross < 100)
  {
    durchmesserGross = 100;
    durchmesserKlein = durchmesserGross-40;
    frameBreite = durchmesserGross+frameAbstandSeite*2;
  }


  
  

  //KREIS UNTERGRUND 111111111//////////////////////////////////////////////
  noFill();
  stroke(barGraphGround);
  strokeWeight(13);
  ellipseMode(CENTER);
  ellipse(frameBreite/2, frameAbstandOben+durchmesserGross/2, durchmesserGross, durchmesserGross); 
  noStroke(); 


  //KREIS UNTERGRUND 22222222222//////////////////////////////////////////////
  noFill();
  stroke(barGraphGround);
  strokeWeight(13);
  ellipseMode(CENTER);
  ellipse(frameBreite/2, frameAbstandOben+durchmesserGross/2, durchmesserKlein, durchmesserKlein); 
  noStroke(); 


  //BALKEN + TRESHOLD 11111111111111//////////////////////////////////////////////

  noFill();
  strokeWeight(13);
  float grad = map(poti, 0, 1024, 0, 360);
  stroke(barGraph);
  //println("graaaaaad  "+grad);
  strokeCap(SQUARE);
  arc(frameBreite/2, frameAbstandOben+durchmesserGross/2, durchmesserGross, durchmesserGross, radians(-90), radians(grad-90));



  if (poti >= treshold && treshold >0) { //wenn der schwellwert erreicht ist, 
    stroke(tresholdColor);
    tresholdFarbeAlpha = 255;
    tresholdRand = true;
  }  //dann gib die farbe rot
  else {
    stroke(tresholdColor, tresholdFarbeAlpha);
    tresholdRand = false;
  } //sonst blau
  tresholdFarbeAlpha = tresholdFarbeAlpha - farbeWeg;
  if (tresholdFarbeAlpha < 0) {
    tresholdFarbeAlpha = 0;
  }


  arc(frameBreite/2, frameAbstandOben+durchmesserGross/2, durchmesserGross, durchmesserGross, radians(-90), radians(grad-90));




  //BALKEN + TRESHOLD22222222222//////////////////////////////////////////////
  noFill();
  strokeWeight(13);
  println("davor    "+poti2);
  float grad2 = map(poti2, 0, 1024, 0, 360);

  println("danach    "+grad2);
  stroke(barGraph2);
  //println("graaaaaad  "+grad);
  strokeCap(SQUARE);

  arc(frameBreite/2, frameAbstandOben+durchmesserGross/2, durchmesserKlein, durchmesserKlein, radians(-90), radians(grad2-90)); //blauer arc der unten liegt

  if (poti2 >= treshold2 && treshold2 >0) { //wenn der schwellwert erreicht ist, 
    stroke(tresholdColor);
    tresholdFarbeAlpha2 = 255;
    tresholdRand2 = true;
  }  //dann gib die farbe rot
  else {
    stroke(tresholdColor, tresholdFarbeAlpha2);
    tresholdRand2 = false;
  } //sonst blau
  tresholdFarbeAlpha2 = tresholdFarbeAlpha2 - farbeWeg2;
  if (tresholdFarbeAlpha2 < 0) {
    tresholdFarbeAlpha2 = 0;
  }
  arc(frameBreite/2, frameAbstandOben+durchmesserGross/2, durchmesserKlein, durchmesserKlein, radians(-90), radians(grad2-90)); // der tres arc der oben liegt


  

strokeWeight(1);
stroke(90);


 //BESCHREIBUNGEN//////////////////////////////////////
  pushMatrix();
    translate((frameBreite-130)/2, frameAbstandOben+durchmesserGross+55);

    textAlign(LEFT, CENTER);

    rectMode(CENTER);

    int yAbstand = 4;
    int yAbstandText = 1;
    int abstandBeschreibung = 17;
    int abstandAktuell = 115;

  line(-6,29+yAbstand,136,29+yAbstand);
  line(-6,69+yAbstand,136,69+yAbstand);
  line(-6,109+yAbstand,136,109+yAbstand);

  


  //int potention1 ///////////////////////////////
  //rect legende
  fill(barGraph);
  noStroke();
  rect(0, 2+yAbstandText, 12, 12);

  //beschreibungstext
  fill(textColor); 
  textFont(myText);
  int potiText = round(poti);
  text("int potentio1", abstandBeschreibung, 0+yAbstandText);

  //realtime
  textFont(myTextBold);
  text(potiText, abstandAktuell, 0+yAbstandText); 


  //int potention2 ///////////////////////////////
  //ellipse Legende
  noStroke();
  fill(barGraph2);
  rect(0, 20+yAbstandText, 12, 12);

  //beschreibungstext
  fill(textColor);
  stroke(frameColor); 
  textFont(myText);
  text("int potentio2", abstandBeschreibung, 20+yAbstandText); 

  //realtime
  fill(255); 
  textFont(myTextBold);
  int potiText2 = round(poti2);
  text(potiText2, abstandAktuell, 20+yAbstandText); 


  

  //tres potentio1  ///////////////////////////////
  //rect lengende
  textFont(myTextBold);
  int tresText = round(treshold); 
  fill(tresholdColor); 
  noStroke();
  rect(0, 40+yAbstand, 12, 12);

  //beschreibungstext
  fill(textColor);
  textFont(myText);
  text("thres potentio1", abstandBeschreibung, 40+yAbstand);


  //realtime
  fill(textColor);
  textFont(myTextBold);
  text(tresText, abstandAktuell, 40+yAbstand ); // display des treshold

  //tres potentio2   ///////////////////////////////
  //rect lengende
  int tresText2 = round(treshold2); //aufrunden des treshold
  fill(tresholdColor); // farbe des treshold
  noStroke();
  rect(0, 60+yAbstandText, 12, 12);

  //beschreibung
  fill(textColor);
  textFont(myText);
  text("thres potentio2", abstandBeschreibung, 60+yAbstandText);

  //realtime
  textFont(myTextBold);
  stroke(120, 130, 130); 
  text(tresText2, abstandAktuell, 60+yAbstandText); 


  //min potentio1   ///////////////////////////////
  //rect lengende
  int minText = round(minn); 
  fill(minFarbe);
  strokeWeight(1);
  stroke(frameColor); 
  rect(0, 80+yAbstand, 12, 12);

  //beschreibung
  fill(textColor);
  textFont(myText);
  text("min potentio1", abstandBeschreibung, 80+yAbstand);

  //realtime
  textFont(myTextBold);
  stroke(frameColor); 
  text(minText, abstandAktuell, 80+yAbstand); 



  //min potentio2   ///////////////////////////////
  //rect lengende
  fill(minFarbe); 
  strokeWeight(1);
  stroke(frameColor); 
  rect(0, 100+yAbstandText, 12, 12);

  //beschreibung
  fill(textColor);
  textFont(myText);
  text("min potentio2", abstandBeschreibung, 100+yAbstandText);

  //realtime
  textFont(myTextBold);
  int minText2 = round(minn2); 
  text(minText2, abstandAktuell, 100+yAbstandText); 



  //max potentio1    ///////////////////////////////
  //rect lengende
  fill(maxFarbe); 
  noStroke();
  rect(0, 120+yAbstand, 12, 12);

  //beschreibung
  fill(textColor);
  stroke(frameColor);
  textFont(myText);
  text("max potentio1", abstandBeschreibung, 120+yAbstand);

  //realtime
  int maxText = round(maxx); 
  textFont(myTextBold);
  text(maxText, abstandAktuell, 120+yAbstand); 



  //max potentio2   ////////////////////////////////
  //rect legende
  fill(maxFarbe); 
  noStroke();
  rect(0, 140+yAbstandText, 12, 12);

  //beschreibung
  fill(textColor);
  stroke(frameColor);  
  textFont(myText);
  text("max potentio2", abstandBeschreibung, 140+yAbstandText);

  //realtime
  textFont(myTextBold);
  int maxText2 = round(maxx2); 
  text(maxText2, abstandAktuell, 140+yAbstandText);    
  popMatrix();


//}























//MINIMIZE/////////////////////////////////////////////////
   
  //hover setting rect
  color setColorRectDisplay = color(255,0);
  color setColorSymbolDisplay = (int)frameColor;

  if (dist(frameBreite-60, 12, mousePositionX, mousePositionY) < 15)
  { 
         setColorRectDisplay = color(255,20); 
         setColorSymbolDisplay = color(255,180);     
    

     if(mousePressed)
     {
       setColorSymbolDisplay = 255;
     }
  }
  noStroke();
  fill(setColorRectDisplay);
  rectMode(CENTER);
  rect(frameBreite-60, 14, 18, 18);

  //symbol minimalize
  fill(setColorSymbolDisplay);
if(display){
  rect(frameBreite-60,14,10,2);
  }
  else
  {
   noStroke();
   fill(setColorSymbolDisplay);
   rect(frameBreite-60,15,10,10,1);
   fill(backGround);
   rect(frameBreite-60,15,6,6,1);
  }
 
             
             
           //ansicht closed + play open
             if(!display && play)
            {    // 8 ist wirksam wenn display closed ist und runter fährt
                  // 8 ist wirksam wenn play open ist und display geclosed wird
                for(int i=0; i<8; i++)
                {
                  frameHoehe = frameHoehe + incrementOpen * -1;;
                    if (frameHoehe < durchmesserGross+ frameAbstandOben*2+50)
                    {
                     frameHoehe = durchmesserGross+ frameAbstandOben*2+50;
                    }
                }
            }
            
            //ansicht open + play open
            else if(display && play)
            {  //ist wirksam wenn display open ist und play aufgemacht wird
                for(int i=0; i<3; i++)
                {
                  frameHoehe = frameHoehe + incrementOpen;
            
                  if (frameHoehe >= 480)
                  {
                   frameHoehe = 480;
                  }
                 }
            }
            
    
             //ansicht closed + play closed
            else if(!display && !play)
            {  
                for(int i=0; i<10; i++)
                {
                  frameHoehe = frameHoehe + incrementOpen;
            
                  if (frameHoehe >= 250)
                  {
                   frameHoehe = 250;
                  }
                 }
            }
            
            
             //ansicht closed + play closed
            else if(display && !play)
            {  
                for(int i=0; i<10; i++)
                {
                  frameHoehe = frameHoehe + incrementOpen;
            
                  if (frameHoehe >= 440)
                  {
                   frameHoehe = 440;
                  }
                 }
            }
    
         
           
          
            //FRAME//////////////////////////////////////////
            //verschluss
            noStroke();
            fill(backGround);
            rectMode(CORNER); 
            rect(0, frameHoehe-40, frameBreite, 200);     

            //frame/////////////////
            noFill();
            stroke(91, 101, 101); //farbe des Frame
            strokeWeight(1);
            rectMode(CORNER);
            
            rect(0, 0, frameBreite, frameHoehe, 2);

 
  //sensor beschreibung untergrund
  fill(backGround); 
  noStroke();
  rectMode(CENTER);
  rect(60, 0, 70, 20);   

  
    
  //sensor beschreibung text
  name = "vergleich"; 
  String ss3 = name.substring(0, 9); 
  fill(frameColor);
  textAlign(LEFT, CENTER);
  textFont(myText, 15);
  text(ss3, 34, 0);



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
  rect(frameBreite-40, 14, 18, 18);

  //symbol setting
   fill(setColorSymbol);
//  textAlign(CENTER, CENTER);
//  textFont(myTextIcon, 13);
//  text("W", frameBreite-40, 12);
  rectMode(CORNER);
  rect(0+frameBreite-46,0+10,2,10);
  rect(-1+frameBreite-46,3+10,4,2);
  
  rect(5+frameBreite-46,0+10,2,10);
  rect(4+frameBreite-46,5+10,4,2);
  
  rect(10+frameBreite-46,0+10,2,10);
  rect(9+frameBreite-46,2+10,4,2);
 
  
  //hover close window////////////////////////////////////
  color setColorRect2 = color(255,0);
  color setColorSymbol2 = (int)frameColor;

  if (dist(frameBreite-20, 12, mousePositionX, mousePositionY) < 15)
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
  rect(frameBreite-20, 14, 18, 18);

  //symbol close
  fill(setColorSymbol2);
  textAlign(CENTER, CENTER);
  textFont(myTextIcon, 13);  
  text("ã", frameBreite-20, 12);
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


  ////play/////////////////////////////
  //frame ellipse
  strokeWeight(1);
  stroke(frameColor);
  fill(backGround);
  ellipseMode(CENTER);
  ellipse(frameBreite/2, frameHoehe, 30, 30);


  noStroke();
  fill(255, 20);
  ellipse(mousePositionX, mousePositionY, 10, 10);

  //hover
  if (dist(x, y, mousePositionX, mousePositionY) < 15) 
  {
    fill(255, 20);
    ellipse(frameBreite/2, frameHoehe, 30, 30);
  }

  //interaction
  if (play) {
    //play button
        fill(255);
    beginShape();
    vertex(frameBreite/2-3, -7+frameHoehe);
    vertex(10+frameBreite/2-3, frameHoehe);
    vertex(frameBreite/2-3, 7+frameHoehe);
    endShape();

    //slider line
    strokeWeight(1);
    stroke(frameColor);
    line(durchmesserGross/2-frameAbstandSeite, frameHoehe-40, durchmesserGross+frameAbstandSeite, frameHoehe-40);



    //slider Ellipse
    if (mousePressed && dist(xSlider, frameHoehe-40, mousePositionX, mousePositionY) < 15)
    {

      xSlider = mousePositionX;
    }
    noStroke();
    xSlider = constrain(xSlider, frameAbstandSeite, durchmesserGross+frameAbstandSeite);
    ellipse(xSlider, frameHoehe-40, 12, 12);
  }

  else
  {
    //pause symbol
    rectMode(CENTER);  
    fill(frameColor);
    rect(frameBreite/2-4, frameHoehe, 4, 14, 1);
    rect(frameBreite/2+5, frameHoehe, 4, 14, 1);

    //slider position zurücksetzen
    xSlider = durchmesserGross+frameAbstandSeite;
  }




  //TICK MARKS//////////////////////////////////////////////
  if (tickMarks) 
  {


    //kleine tickmarks
    pushMatrix();
    translate(frameBreite/2, frameAbstandOben+durchmesserGross/2);

    for (int ii=0; ii<8; ii++) 
    {
      fill(255); 

      rotate(radians(45));
      stroke(255);
      strokeWeight(0);
      rect(0, durchmesserGross/2+11, 1, 2);
    }
    popMatrix();
  }


  //NUMMERIERUNG DER TICKMARKS//////////////////////////////////////////////
  if (scale) 
  {
    pushMatrix();
    translate(frameBreite/2, frameAbstandOben+durchmesserGross/2);
    for (int i=0; i<4; i++) 
    {
      rotate(radians(90));
      textFont(myText, 10);
      fill(255);
      textAlign(CENTER,CENTER);
      text(arrayOfScale[i], 0, -durchmesserGross/2-21);
    }
    popMatrix();

    text("512", frameBreite/2, frameAbstandOben+durchmesserGross+21);

    if (poti >= 1024)
    {
      text("1024", frameBreite/2, -durchmesserGross/2-21);
    }
    else
    {
      text("0", frameBreite/2, frameAbstandOben+-21);
    }
  }


  //TRESHOLD 111111111111111///////////////////////////////////////////////
  //markierung wird angezeigt nur dann wenn treshold >0
  if (treshold > 0)
  {
    fill(tresholdColor);
    noStroke();
    pushMatrix();
    translate(frameBreite/2, frameAbstandOben+durchmesserGross/2);

    float tresholdDreh = map(treshold, 0, 1024, 0, 360);
    rotate(radians(tresholdDreh));
    translate(0, -durchmesserGross/2+5);
    beginShape();
    if (tresholdRand == true)
    {
      stroke(255);
    }
    else 
    {
      noStroke();
    }
    vertex(0, 0);
    vertex(-5, -8);
    vertex(5, -8);
    endShape(CLOSE);
    popMatrix();




    //nachschwingen des treshold
    for (int i = 0; i < tresMax.length-1; i ++ ) 
    {
      tresMax[i] = tresMax[i+1];
    }

    // New location
    float nachTres= map(poti, 0, 1024, 0, 360);

    tresMax[tresMax.length-1] =  nachTres;
    println("poti tres max  "+nachTres);

    float tress = max(tresMax);
    // println("minn  "+ minn);
    float tresholdMax = map(treshold, 0, 1024, 0, 360);
    if (tresholdMax >0 && tress>tresholdMax)
    {
      pushMatrix();
      translate(frameBreite/2, frameAbstandOben+durchmesserGross/2);
      fill(tresholdColor);
      rotate(radians(tress));
      translate(0, -durchmesserGross/2);
      rectMode(CENTER);
      rect(0, 0, 2, 14);
      popMatrix();
    }
  }




  //TRESHOLD2222222222222222///////////////////////////////////////////////
  //markierung wird angezeigt nur dann wenn treshold >0
  if (treshold2 > 0)
  {
    pushMatrix();
    translate(frameBreite/2, frameAbstandOben+durchmesserGross/2);
    fill(tresholdColor);
    noStroke();
    float tresholdDreh2 = map(treshold2, 0, 1024, 0, 360);
    rotate(radians(tresholdDreh2));
    translate(0, -durchmesserKlein/2+5);

    if (tresholdRand2 == true) {
      stroke(255);
    }
    else {
      noStroke();
    }

    beginShape();
    vertex(0, 0);
    vertex(-5, -8);
    vertex(5, -8);
    endShape(CLOSE);
    popMatrix();
  }


  //nachschwingen des treshold
  for (int i = 0; i < tresMax2.length-1; i ++ ) 
  {
    tresMax2[i] = tresMax2[i+1];
  }

  // New location
  float nachTres= map(poti2, 0, 1024, 0, 360);

  tresMax2[tresMax2.length-1] =  nachTres;
  println("poti tres max  "+nachTres);

  float tress2 = max(tresMax2);
  // println("minn  "+ minn);
  float tresholdMax2 = map(treshold2, 0, 1024, 0, 360);
  if (tresholdMax2 >0 && tress2>tresholdMax2)
  {
    pushMatrix();
    translate(frameBreite/2, frameAbstandOben+durchmesserGross/2);
    fill(tresholdColor);
    rotate(radians(tress2));
    translate(0, -durchmesserKlein/2);
    rectMode(CENTER);
    rect(0, 0, 2, 14);
    popMatrix();
  }






  //MIN VALUE 11111111111111///////////////////////////////////////////////
  if (minimum) {
    // Shift all elements down one spot. 
    // xpos[0] = xpos[1], xpos[1] = xpos = [2], and so on. Stop at the second to last element.
    for (int i = 0; i < xPosMin.length-1; i ++ ) 
    {
      xPosMin[i] = xPosMin[i+1];
    }

    // New location
    xPosMin[xPosMin.length-1] = poti;
    minn = min(xPosMin);
    //println("minn  "+ minn);

    pushMatrix();
    translate(frameBreite/2, frameAbstandOben+durchmesserGross/2);
    float zeigerAnzeigeMin = map(minn, 0, 1024, 0, 360);
    rotate(radians(zeigerAnzeigeMin));
    translate(0, -durchmesserGross/2+5);
    fill(minFarbe);
    noStroke();
    beginShape();
    vertex(0, 0);
    vertex(-5, -8);
    vertex(+5, -8);
    endShape(CLOSE);
    popMatrix();
  }


  //MIN VALUE 222222222222///////////////////////////////////////////////
  if (minimum) {
    // Shift all elements down one spot. 
    // xpos[0] = xpos[1], xpos[1] = xpos = [2], and so on. Stop at the second to last element.
    for (int i = 0; i < xPosMin2.length-1; i ++ ) 
    {
      xPosMin2[i] = xPosMin2[i+1];
    }

    // New location
    xPosMin2[xPosMin2.length-1] = poti2;
    minn2 = min(xPosMin2);
    //println("minn  "+ minn);

    pushMatrix();
    translate(frameBreite/2, frameAbstandOben+durchmesserGross/2);
    float zeigerAnzeigeMin2 = map(minn2, 0, 1024, 0, 360);
    rotate(radians(zeigerAnzeigeMin2));
    translate(0, -durchmesserKlein/2+5);
    fill(minFarbe);
    noStroke();
    beginShape();
    vertex(0, 0);
    vertex(-5, -8);
    vertex(+5, -8);
    endShape(CLOSE);
    popMatrix();
  }

  //MAX 111111111111/////////////////////////////////////////////
  if (maximum) {

    // Shift all elements down one spot. 
    // xpos[0] = xpos[1], xpos[1] = xpos = [2], and so on. Stop at the second to last element.
    for (int i = 0; i < xPosMax.length-1; i ++ ) 
    {
      xPosMax[i] = xPosMax[i+1];
    }

    // New location
    xPosMax[xPosMax.length-1] = poti;
    maxx = max(xPosMax);

    pushMatrix();
    translate(frameBreite/2, frameAbstandOben+durchmesserGross/2);
    float zeigerAnzeigeMax = map(maxx, 0, 1024, 0, 360);
    rotate(radians(zeigerAnzeigeMax));
    translate(0, -durchmesserGross/2+5);
    fill(maxFarbe);
    noStroke();
    beginShape();
    vertex(0, 0);
    vertex(-5, -8);
    vertex(+5, -8);
    endShape(CLOSE);
    popMatrix();
  }


  //MAX 2222222222/////////////////////////////////////////////
  if (maximum) {

    // Shift all elements down one spot. 
    // xpos[0] = xpos[1], xpos[1] = xpos = [2], and so on. Stop at the second to last element.
    for (int i = 0; i < xPosMax2.length-1; i ++ ) 
    {
      xPosMax2[i] = xPosMax2[i+1];
    }

    // New location
    xPosMax2[xPosMax2.length-1] = poti2;
    maxx2 = max(xPosMax2);

    pushMatrix();
    translate(frameBreite/2, frameAbstandOben+durchmesserGross/2);
    float zeigerAnzeigeMax2 = map(maxx2, 0, 1024, 0, 360);
    rotate(radians(zeigerAnzeigeMax2));
    translate(0, -durchmesserKlein/2+5);
    fill(maxFarbe);
    noStroke();
    beginShape();
    vertex(0, 0);
    vertex(-5, -8);
    vertex(+5, -8);
    endShape(CLOSE);
    popMatrix();
  }






  //ZUFALLSGENERATOR/////////////////////////////////////////////////////
  generator =(noise(startWert+= incrementWert));
  generator = map(generator, 0, 1, 0, 1024);

  poti = generator;
  //println("POTI    "+poti);


  generator2 =(noise(startWert2+= incrementWert2));
  generator2 = map(generator2, 0, 1, 0, 1024);

  poti2 = generator2;

  popMatrix();
}



void mousePressed()
{
  if (dist(x, y, mousePositionX, mousePositionY) < 15)
  {
    play = !play;
  } 
  
  if (dist(frameBreite-60, 12, mousePositionX, mousePositionY) < 15)
  {
         display = !display;
  
  } 
}


