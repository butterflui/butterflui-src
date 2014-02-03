
/*
BISMILLAH
Graphical User Interface Library for Physical Computing
Displaying sensor data and controlling actuators
design and programming by Fatih Aydemir and Laurens Rinke
6th semester interaction design - 2013/14
hochschule für gestaltung schwäbisch gmünd
*/


//speicher
float[] speicher = new float[100];
float zeigerAnzeigeSpeicher;
float [] xPosMinn = new float[100];

int timelapslaenge = 500;
float[] timelaps = new float[timelapslaenge];

//display
boolean display = true;


//darkening
int farbeFull = 0;
int farbeWeg = 5;

//actual values for the barGraph lenght, starting from zero
float poti; //!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!! 
//poti ist die variable, die aus dem arduino kommt. weiter unten im code
// ist poti mit dem zufallsgenerator gekoppelt.

float potiRect;


//name of the sensor
String name = "potentiometer"; //!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
//das ist die beschreibung die im rahmen ist. momentan übernimmt sie
//glaub ich mindestens 10 oder 9 buchstaben. unter dieser zahl
//kommt eine fehlermeldung

//balken
float balkenBreite = 150;
float balkenHoehe = 15;


//positioning
int xpos=3;
int ypos=10;
float mousePositionX = mouseX-xpos;
float mousePositionY = mouseY-ypos;

//frame
float frameHoehe = 250;
float frameAbstandSeite = 40;
float frameAbstandOben = 40;
float frameBreite = frameAbstandSeite*2+balkenBreite;
float frameColor = 180;
boolean frame = true;
int frameFarbe = color(150, 150, 150);

//PLAY
boolean play = false;
boolean pause = true;
float x;
float y;
float xSlider = balkenBreite+frameAbstandSeite;
float frameHoehePlay = 0;

boolean open = false;
float incrementOpen = 1;

//min
boolean minimum =true;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
// mit diesem boolean kann der minimumwert ein oder ausgeschaltet werden
float[] xPosMin = new float[100];
float zeigerAnzeigeMin;
float zeigerMin;
float minn;
color minFarbe = color(48, 56, 58); //backgroundfarbe
//color minFarbe = color(57, 122, 156);

//max
boolean maximum = true;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
// mit diesem boolean kann der maximumwert ein oder ausgeschaltet werden
float[] xPosMax = new float[100];
float maxx;
color maxFarbe = color(255);
//color maxFarbe = color(57, 122, 156);

//treshold
float treshold = 512;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
// mit diesem wert kann der threshold eingestellt werden
color tresholdColor = color(166, 47, 25);
float[] tresMax = new float[200];
float zeigerAnzeigeTres;


//tickMarks
boolean tickMarks = true;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
// mit diesem wert können die tickmarks ein oder ausgeblendet werden

//skalen nummern
boolean scale = true;//!!!!!!!!!!!!!!!! FÜR JAVASCRIPT!!!!!!!!!!!!!!!!
// mit diesem wert können die skalen nummern ein oder ausgeblendet werden
color skalenFarbe = color(150, 150, 150);

//farben generell

color backGround = color(48, 55, 57); //hintergrundfarbe
color barGraph = color(56, 135, 166);
color barGraphGround = color(152, 156, 156);
color textColor = color(255);


//text 
PFont myText;
PFont myTextBold;
PFont myTextIcon;


//zufallsgenerator
float generator;
float startWert = 0.2;
float incrementWert = 0.005;




///////////////////////////////////////////////////////////////////
//Input and Output to JavaScript

//getter
float getValue(){
  return poti;
}

float getThres(){
  return treshold;
}

String getName(){
  return name;
}

boolean getMin(){
  return minimum;
}

boolean getMax(){
  return maximum;
}

boolean getTicks(){
  return tickMarks;
}

boolean getScale(){
  return scale;
}

//setter

void setProperties(obj) {
  name = obj.name;
  treshold = obj.thres;
  minimum = obj.min;
  maximum = obj.max;
  tickMarks = obj.ticks;
  scale = obj.scale;
}

void setValue(value) {
  // if(play)
  //   poti = oldPoti;
  // else
     poti= value;
}

///////////////////////////////////////////////////////////////////




void setup() {
  size(237, 320);
  smooth();
  noStroke();

  //text set up
    myTextIcon = createFont("sosa", 14, false);

  myText = createFont("unit-thin", 14, false);
  myTextBold = createFont("unit-medium", 13, false);

  //initialisierung + nullsetzen für min array
  for (int i = 0; i < xPosMin.length; i ++ ) {
    xPosMin[i] = 0;
  }

  //initialisierung + nullsetzen für max array
  for (int i = 0; i < xPosMax.length; i ++ ) {
    xPosMax[i] = 0;
  }
}













void draw() 
{
  //clear background
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

  
  
      rectMode(CORNER);
    
    
    
    
      //BALKEN UNTERGRUND/////////////////////////////////////////////
      noStroke();
      fill(barGraphGround);
      rect(frameAbstandSeite, frameAbstandOben, balkenBreite, balkenHoehe);
    
      //BALKEN + TRESHOLD ////////////////////////////////////////////
    
      potiRect = map(poti, 0, 1024, 0, 150); // mapping des potiWertes von 1024 auf 150
    
    
        fill(barGraph);  
      rect(frameAbstandSeite, frameAbstandSeite, potiRect, balkenHoehe);  // aktueller wert als balken dargestellt
    
      if (poti >= treshold && treshold >0) { //wenn der schwellwert erreicht ist, 
        fill(tresholdColor);   //füll die farbe rot
        farbeFull = 255;
      }  
      else 
      {
        fill(tresholdColor, farbeFull);
      }
      farbeFull = farbeFull - farbeWeg;
      if (farbeFull < 0) {
        farbeFull = 0;
      }
      //println("pos  "+farbeFull);
    
      rect(frameAbstandSeite, frameAbstandSeite, potiRect, balkenHoehe);  // aktueller wert als balken dargestellt
    
    
    
    
    
    
    
    strokeWeight(1);
stroke(90);
    
    //BESCHREIBUNGEN//////////////////////////////////////
  pushMatrix();
    
    translate((frameBreite-130)/2, frameAbstandOben+balkenHoehe+46);

    textAlign(LEFT, CENTER);

    rectMode(CENTER);

    int yAbstand = 4;
    int yAbstandText = 0;
    int abstandBeschreibung = 17;
    int abstandAktuell = 115;

  line(-6,13,136,13);
  line(-6,37,136,37);
  line(-6,63,136,63);


  //int potention1 ///////////////////////////////
  //rect legende
  fill(barGraph);
  noStroke();
  rect(0, 0, 12, 12);

  //beschreibungstext
  fill(textColor); 
  textFont(myText);
  int potiText = round(poti);
  text("int potentio1", abstandBeschreibung, 0);

  //realtime
  textFont(myTextBold);
  text(potiText, abstandAktuell, 0); 

  //tres potentio1  ///////////////////////////////
  //rect lengende
  textFont(myTextBold);
  int tresText = round(treshold); 
  fill(tresholdColor); 
  noStroke();
  rect(0, 25, 12, 12);

  //beschreibungstext
  fill(textColor);
  textFont(myText);
  text("thres potentio1", abstandBeschreibung, 25);


  //realtime
  fill(textColor);
  textFont(myTextBold);
  text(tresText, abstandAktuell, 25 ); // display des treshold

  //min potentio1   ///////////////////////////////
  //rect lengende
  int minText = round(minn); 
  fill(minFarbe);
  strokeWeight(1);
  stroke(frameColor); 
  rect(0, 50, 12, 12);

  //beschreibung
  fill(textColor);
  textFont(myText);
  text("min potentio1", abstandBeschreibung, 50);

  //realtime
  textFont(myTextBold);
  stroke(frameColor); 
  text(minText, abstandAktuell, 50); 


  //max potentio1    ///////////////////////////////
  //rect lengende
  fill(maxFarbe); 
  noStroke();
  rect(0, 75, 12, 12);

  //beschreibung
  fill(textColor);
  stroke(frameColor);
  textFont(myText);
  text("max potentio1", abstandBeschreibung, 75);

  //realtime
  int maxText = round(maxx); 
  textFont(myTextBold);
  text(maxText, abstandAktuell, 75);
  
  rectMode(CORNER);
popMatrix();


  

    
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
                    if (frameHoehe < balkenHoehe+frameAbstandOben*2+60)
                    {
                     frameHoehe = balkenHoehe+ frameAbstandOben*2+60;
                    }
                }
            }
            
            //ansicht open + play open
            else if(display && play)
            {  //ist wirksam wenn display open ist und play aufgemacht wird
                for(int i=0; i<3; i++)
                {
                  frameHoehe = frameHoehe + incrementOpen;
            
                  if (frameHoehe >= 290)
                  {
                   frameHoehe = 290;
                  }
                 }
            }
            
    
             //ansicht closed + play closed
            else if(!display && !play)
            {  
                for(int i=0; i<10; i++)
                {
                  frameHoehe = frameHoehe + incrementOpen;
            
                  if (frameHoehe >= 128)
                  {
                   frameHoehe = 128;
                  }
                 }
            }
            
            
             //ansicht closed + play closed
            else if(display && !play)
            {  
                for(int i=0; i<10; i++)
                {
                  frameHoehe = frameHoehe + incrementOpen;
            
                  if (frameHoehe >= 245)
                  {
                   frameHoehe = 245;
                  }
                 }
            }
    
         
           
          
            //FRAME//////////////////////////////////////////
            //verschluss
            noStroke();
            fill(backGround);
            rectMode(CORNER); 
            rect(0, frameHoehe-60, frameBreite, 200);     

            //frame/////////////////
            noFill();
            stroke(91, 101, 101); //farbe des Frame
            strokeWeight(1);
            rectMode(CORNER);
            
            rect(0, 0, frameBreite, frameHoehe, 3);

 
    
    
    
    
    
    
    
    
      //FRAME//////////////////////////////////////////////
      //rahmen
      noFill();
      stroke(91, 101, 101); //farbe des frame
      strokeWeight(1);
      rect(0, 0, frameAbstandSeite*2+balkenBreite, frameHoehe, 2);
    
      // untergrund für beschreibung
      fill(backGround); 
      noStroke();
      rect(24, 0, 80, 20); 
    
      //sensor beschreibung
      
      //name = (String) $('#name').val();
      String ss3 = name.substring(0, 9);  // Returns "CC"
      //println(ss3); 
      fill(frameFarbe);
      textAlign(LEFT,CENTER);
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
//  textAlign(CENTER, CENTER);
//  textFont(myTextIcon, 13);  
//  text("ã", frameBreite-20, 12);
  
  pushMatrix();
    translate(frameBreite-20, 14);
    rotate(radians(45));
    rect(0, 0,2,12);
    rotate(radians(-90));
    rect(0, 0,2,12);
  popMatrix();
 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


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
    //grundlinie
    strokeWeight(1);
    stroke(frameColor);
    line(balkenBreite/2-frameAbstandSeite, frameHoehe-45, balkenBreite+frameAbstandSeite, frameHoehe-45);
     
    //korrespodierende linie blau/ tresholdColor
      if(poti >= treshold)
    {
      stroke(tresholdColor);
    }
    else
    {
      stroke(barGraph);
    }
    
    strokeWeight(2);
    line(balkenBreite/2-frameAbstandSeite, frameHoehe-45, xSlider, frameHoehe-45);
   
   
      //timer
     fill(setColorSymbol2);
     textAlign(LEFT, CENTER);
     textFont(myText, 13);  
     int timer = (int)map(xSlider,40,190,0,60);
     text("00:"+ timer , frameBreite/2-17, frameHoehe-65);


    //slider Ellipse
    //hover
        if (dist(xSlider, frameHoehe-45, mousePositionX, mousePositionY) < 13)
      {  noStroke();
        fill(220);
      ellipse(xSlider, frameHoehe-45, 13, 13);  
  }

    if (mousePressed && dist(xSlider, frameHoehe-45, mousePositionX, mousePositionY) < 15)
    {
      noStroke();
      fill(255,180);
      ellipse(xSlider, frameHoehe-45, 17, 17);

      xSlider = mousePositionX;
    }
    noStroke();
    xSlider = constrain(xSlider, frameAbstandSeite, balkenBreite+frameAbstandSeite);
    ellipse(xSlider, frameHoehe-45, 12, 12);

  }

  else
  {
    //pause symbol
    rectMode(CENTER);  
    fill(frameColor);
    rect(frameBreite/2-4, frameHoehe, 4, 14, 1);
    rect(frameBreite/2+5, frameHoehe, 4, 14, 1);

    //slider position zurücksetzen
    xSlider = balkenBreite+frameAbstandSeite;
  }
  



    
    
    
    
    
    
    
    
    
      //TICK MARKS SETZEN//////////////////////////////////////////////
      //tickMarks = (boolean) $('#tick').prop('checked');
    
      if (tickMarks) 
      {  
            //translate(frameAbstandSeite, 0); // tickmarks an die richtige stelle verschieben
            //kleine Tickmarks
            for (int i=0; i<11; i++) // anzahl tickmarks
            {
              pushMatrix();
              translate(frameAbstandSeite, 16); // tickmarks an die richtige stelle verschieben

              fill(frameFarbe);  // farbe der tickmarks
              noStroke();    //keine kontur
              rect(i*15, frameAbstandSeite, 1, 1); // tickmarks setzen
              popMatrix();
            }
        
            
            //große Tickmarks
            for (int i=0; i<6; i++)
            {
              pushMatrix();
                translate(frameAbstandSeite, 16);
                fill(frameFarbe);
                noStroke();
                rect(0+i*30, frameAbstandOben, 1, 3);
              popMatrix();
            }

      }
    
    
      //NUMMERIERUNG DER TICKMARKS//////////////////////////////////////////////
      if (scale) {

        for (int i=0; i<3; i++) // 3 zahlen
        {
          pushMatrix();
            translate(frameAbstandSeite, balkenHoehe+2);
  
            fill(255); // farbe der zahlen
            int value = 0;     //startpunkt für zahlen
            value = value +i*512;  //zahlenabstand als bereich
            //println(value);
            textAlign(CENTER, CENTER);
            textFont(myText, 10);
            text(value, i*75, 10+frameAbstandOben); // zahlen setzen + abstand
          popMatrix();
        }
      }
    
    
    
      //TRESHOLD///////////////////////////////////////////////
      //markierung wird angezeigt nur dann wenn treshold >0
      if (treshold > 0)
      {

        fill(tresholdColor);
        noStroke();
        float tresholdAnzeige = map(treshold, 0, 1024, 0, 150);
    
        if (poti >= treshold)
        {
          stroke(255);
        }
        strokeWeight(1);
        beginShape();
        vertex(0+tresholdAnzeige+frameAbstandSeite, frameAbstandOben+12);
        vertex(-5+tresholdAnzeige+frameAbstandSeite, -8+frameAbstandOben+12);
        vertex(5+tresholdAnzeige+frameAbstandSeite, -8+frameAbstandOben+12);
        endShape(CLOSE);
    
    
        for (int i = 0; i < tresMax.length-1; i ++ ) 
        {
          tresMax[i] = tresMax[i+1];
        }
    
        // New location
        tresMax[tresMax.length-1] =  poti;
    
    
        float tress = max(tresMax);
        // println("minn  "+ minn);
    
        //zeiger min
        noStroke();
    
        zeigerAnzeigeTres = tress;
    
        if (treshold >0 && zeigerAnzeigeTres>treshold) {
          zeigerAnzeigeTres = map(tress, 0, 1024, 0, 150);
          rectMode(CORNER);
          rect(zeigerAnzeigeTres+frameAbstandSeite, frameAbstandOben, 2, 15);
        }
    
    
    
    
    
    
        //MIN VALUE///////////////////////////////////////////////
        if (minimum) {
          // Shift all elements down one spot. 
          // xpos[0] = xpos[1], xpos[1] = xpos = [2], and so on. Stop at the second to last element.
          for (int i = 0; i < xPosMin.length-1; i ++ ) 
          {
            xPosMin[i] = xPosMin[i+1];
          }
    
          // New location
          xPosMin[xPosMin.length-1] =  poti;
    
    
          minn = min(xPosMin);
          // println("minn  "+ minn);
    
          //zeiger min
          fill(minFarbe);
    
          noStroke();
    
          zeigerAnzeigeMin = map(minn, 0, 1024, 0, 150);
    
    
    
          beginShape();
          vertex(zeigerAnzeigeMin+frameAbstandSeite, 0+frameAbstandOben+12);
          vertex(zeigerAnzeigeMin-5+frameAbstandSeite, -8+frameAbstandOben+12);
          vertex(zeigerAnzeigeMin+5+frameAbstandSeite, -8+frameAbstandOben+12);
          endShape();
        }
    
    
        //MAX/////////////////////////////////////////////
        if (maximum) {
    
          // Shift all elements down one spot. 
          // xpos[0] = xpos[1], xpos[1] = xpos = [2], and so on. Stop at the second to last element.
          for (int i = 0; i < xPosMax.length-1; i ++ ) 
          {
            xPosMax[i] = xPosMax[i+1];
          }
    
          // New location
          xPosMax[xPosMax.length-1] = poti; // Update the last spot in the array with the mouse location.
    
    
    
          maxx = max(xPosMax);
          //zeiger max
          fill(maxFarbe);
          noStroke();
          //translate(0, 12);
          float zeigerAnzeigeMax = map(maxx, 0, 1024, 0, 150);
    
          beginShape();
          vertex(zeigerAnzeigeMax+frameAbstandSeite, 0+frameAbstandOben+12);
          vertex(zeigerAnzeigeMax-5+frameAbstandSeite, -8+frameAbstandOben+12);
          vertex(zeigerAnzeigeMax+5+frameAbstandSeite, -8+frameAbstandOben+12);
          endShape();
        }
      }

  popMatrix(); 
  //ZUFALLSGENERATOR/////////////////////////////////////////////////////
  generator =(noise(startWert+= incrementWert));
  generator = map(generator, 0, 1, 0, 1024);
  //println("generator   "+generator);
  poti = generator;
  
  
  
  
   
   if(mousePressed)
   {
   
   fill(255);
   float potiMouse = mouseX-xpos; //ersetzen des generators durch mousex + xpos anpassung
    potiMouse = constrain(potiMouse, 0, 150);
   
   
   ellipse(potiMouse, -20, 10, 10);
    stroke(255);
    line(0, -20, 150, -20);
    noStroke();


  // wenn slider bewegt wird, wird der Wert Poti mit dem Wert aus dem Array gespeist
   poti = timelapsValue(timelaps,potiMouse);
   
   }else{

  // wenn slider nicht angezeigt wird
    poti = noiseValue();
    timeLapsFill(poti);

   }
    
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



   
void timeLapsFill(float sensorValue){

  for (int i=1; i<timelaps.length;i++) {
    timelaps[i-1] = timelaps[i];
  }

  timelaps[timelapslaenge-1] = sensorValue;


}

float noiseValue(){
  //ZUFALLSGENERATOR/////////////////////////////////////////////////////
    generator =(noise(startWert+= incrementWert));
    generator = map(generator,0,1,0,1024);
        //println("generator   "+generator);
        return generator;
}

float timelapsValue(float[] timelapsArr, float sliderValue) {
  int ArrPosition = int(map(sliderValue, 0, 150, 0 , timelapsArr.length-1));
  return timelapsArr[ArrPosition];
}
 
 

 

