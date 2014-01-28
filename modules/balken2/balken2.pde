//speicher
float[] speicher = new float[100];
float zeigerAnzeigeSpeicher;
float [] xPosMinn = new float[100];

int timelapslaenge = 500;
float[] timelaps = new float[timelapslaenge];

//darkening
int farbeFull = 0;
int farbeWeg = 5;

//actual values for the barGraph lenght, starting from zero
float poti;
float potiRect;


//name of the sensor
String name;


//positioning
int xpos=25;
int ypos=45;

//frame
boolean frame = true;
int frameFarbe = color(150,150,150);

//min
boolean minimum =true;
float[] xPosMin = new float[100];
float zeigerAnzeigeMin;
float zeigerMin;
float minn;
color minFarbe = color(48, 56, 58); //backgroundfarbe
//color minFarbe = color(57, 122, 156);

//max
boolean maximum = true;
float[] xPosMax = new float[100];
float maxx;
color maxFarbe = color(255);
//color maxFarbe = color(57, 122, 156);

//treshold
float treshold = 300;
color tresholdColor = color(123, 50, 34);
float[] tresMax = new float[200];
float zeigerAnzeigeTres;


//tickMarks
boolean tickMarks = true;

//skalen nummern
boolean scale = true;
color skalenFarbe = color(150,150,150);

//farben generell
color backGround = color(48, 55, 57); //hintergrundfarbe
color barGraph = color(56,135,166);
//color barGraph = color(144, 197, 194);  //aktueller wert als bargraph
color barGraphGround = color(152, 156, 156);
//color barGraphGround = color(97, 100, 101);

//text 
PFont myText;
PFont myTextBold;

//zufallsgenerator
float generator;
float startWert = 0.2;
float incrementWert = 0.005;












void setup() {
  size(200, 220);
  smooth();
  noStroke();
  
  //text set up
  myText = createFont("unit-light", 14, false);
  myTextBold = createFont("unit-bold", 13, false);
  
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
  translate(xpos, ypos);





//BALKEN UNTERGRUND/////////////////////////////////////////////
  noStroke();
  fill(barGraphGround);
  int breite = 150;
  rect(0, 0, breite, 15);
  
//BALKEN + TRESHOLD ////////////////////////////////////////////

  potiRect = map(poti,0,1024,0,150); // mapping des potiWertes von 1024 auf 150

  
  fill(barGraph);  
  rect(0, 0, potiRect, 15);  // aktueller wert als balken dargestellt
  
  if (poti >= treshold && treshold >0) { //wenn der schwellwert erreicht ist, 
    fill(tresholdColor);   //füll die farbe rot
    farbeFull = 255;
  }  else 
     {
     fill(tresholdColor,farbeFull);
     }
  farbeFull = farbeFull - farbeWeg;
        if(farbeFull < 0){farbeFull = 0;}
        //println("pos  "+farbeFull);
        
  rect(0, 0, potiRect, 15);  // aktueller wert als balken dargestellt







//FRAME//////////////////////////////////////////////
  //rahmen
  noFill();
  stroke(91,101,101); //farbe des frame
  strokeWeight(1);
  int breiteFrame = 190;
  rect((breite-breiteFrame)/2,-40,breiteFrame,200,3);

   // untergrund für beschreibung
  fill(backGround); 
  noStroke();
  rect(10,150,42,20); 
  
  //sensor beschreibung
  name = "potentiometer"; 
  //name = (String) $('#name').val();
  String ss3 = name.substring(0, 5);  // Returns "CC"
  //println(ss3); 
  fill(frameFarbe);
  textAlign(RIGHT);
  textFont(myText,15);
  text(ss3, 48, 165);


  

 
//TICK MARKS SETZEN//////////////////////////////////////////////
  //tickMarks = (boolean) $('#tick').prop('checked');

  if (tickMarks) 
  {
    pushMatrix();
      translate(0, 16); // tickmarks an die richtige stelle verschieben
      //kleine Tickmarks
      for (int i=0; i<11; i++) // anzahl tickmarks
      {
        fill(frameFarbe);  // farbe der tickmarks
        noStroke();    //keine kontur
        rect(0+i*15, 0, 1, 1); // tickmarks setzen
      }
      //große Tickmarks
      for (int i=0; i<6; i++)
      {
        fill(frameFarbe);
        noStroke();
        rect(0+i*30, 0, 1, 3);
      }
    popMatrix();
  }


//NUMMERIERUNG DER TICKMARKS//////////////////////////////////////////////
  if (scale) {
    for (int i=0; i<3; i++) // 3 zahlen
    {
      fill(255); // farbe der zahlen
      int value = 0;     //startpunkt für zahlen
      value = value +i*512;  //zahlenabstand als bereich
      //println(value);
      textAlign(CENTER);
      textFont(myText, 10);
      text(value, i*75, 30); // zahlen setzen + abstand
    }
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
    pushMatrix();
    fill(minFarbe);
    noStroke();
    translate(0, 12);
    
   zeigerAnzeigeMin = map(minn,0,1024,0,150);

      

    beginShape();
    vertex(zeigerAnzeigeMin, 0);
    vertex(zeigerAnzeigeMin-5, -8);
    vertex(zeigerAnzeigeMin+5, -8);
    endShape();
    popMatrix();
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
      pushMatrix();
      fill(maxFarbe);
      noStroke();
      translate(0, 12);
      float zeigerAnzeigeMax = map(maxx,0,1024,0,150);
      
      beginShape();
      vertex(zeigerAnzeigeMax, 0);
      vertex(zeigerAnzeigeMax-5, -8);
      vertex(zeigerAnzeigeMax+5, -8);
      endShape();
      popMatrix();
    
  }
  

//TRESHOLD///////////////////////////////////////////////
  //markierung wird angezeigt nur dann wenn treshold >0
  if (treshold > 0)
  {
    pushMatrix();
    fill(tresholdColor);
    noStroke();
    float tresholdAnzeige = map(treshold,0,1024,0,150);
    translate(tresholdAnzeige, 12);
    
    if(poti >= treshold)
    {
      stroke(255);
    }
    beginShape();
    vertex(0, 0);
    vertex(-5, -8);
    vertex(5, -8);
    endShape(CLOSE);
    popMatrix();
    
    
     for (int i = 0; i < tresMax.length-1; i ++ ) 
    {
      tresMax[i] = tresMax[i+1];
    }

    // New location
    tresMax[tresMax.length-1] =  poti;


    float tress = max(tresMax);
       // println("minn  "+ minn);

    //zeiger min
    pushMatrix();
    noStroke();

   zeigerAnzeigeTres = tress;

    if(treshold >0 && zeigerAnzeigeTres>treshold){
    zeigerAnzeigeTres = map(tress,0,1024,0,150);

    rect(zeigerAnzeigeTres, 0, 2, 15);
    }
    
    popMatrix();
  
    
  }

  
  
  
  
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
 
