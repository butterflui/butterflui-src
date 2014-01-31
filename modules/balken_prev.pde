//int a = (int) $('#chance').val();





//actual values for the barGraph lenght, starting from zero
float poti;

 
//name of the sensor
String name;

//positioning
int xpos=10;
int ypos=45;

//frame
boolean frame = true;
int frameFarbe = color(110,111,111);



//treshold
float treshold;
color tresholdColor = color(123, 50, 34);

//tickMarks
boolean tickMarks;

//skalen nummern
boolean skala = true;
color skalenFarbe = color(150,150,150);

//farben generell
color backGround = color(48, 55, 57); //hintergrundfarbe
color barGraph = color(144, 197, 194);  //aktueller wert als bargraph
color barGraphGround = color(97, 100, 101);

//text 
PFont myText;
PFont myTextBold;

//zufallsgenerator
float generator;
float startWert = 0.7;
float incrementWert = 0.005;



float printValue() {
  return poti;
}

void setup() {

  // size
  size(150, 100);
  smooth();
  // no strokes
  noStroke();

  
   myText = createFont("unit-light", 14, false);
  myTextBold = createFont("unit-bold", 13, false);
  

 
  
}



void draw() {

  // clear background
  background(0,0);

  translate(xpos, ypos);

//BALKEN-UNTERGRUND//////////////////////////////////////////////
  //untergrund
  noStroke();
  fill(barGraphGround);
  int breite = 130;
  rect(0, 0, breite, 15,2);
  //rect(width/2-75,height/2,150,15);
  
  
//TRESHOLD + BALKEN//////////////////////////////////////////////
  if (poti >= treshold && treshold >0) { //wenn der schwellwert erreicht ist, 
    fill(tresholdColor);
  }  //dann gib die farbe rot
  else {
    fill(barGraph);
  } //sonst blau
  rect(0, 0, poti*1.5, 15,2);
  



// //BESCHREIBUNGEN//////////////////////////////////////
//   //aktueller wert
//   pushMatrix();
//     translate(12,70);
//     textFont(myTextBold);
//     int potiText = round(poti);
//     fill(barGraph); //farbe kleines kästchen
//     noStroke();
//     rect(0,-12,12,12); //kleines kästchen
//     fill(255); //farbe text aktueller wert
//     stroke(120,130,130); //farbe des frame
//     textAlign(LEFT);
//     text(potiText, 110, 0); //display den aktuellen wert als zahl
//     textFont(myText);
//     text("int potentio1",20,0); // beschreibung
//   popMatrix();
  
  
  
  
  
  // //treshold wert
  // pushMatrix();
  //   translate(12,90);
  //   textFont(myTextBold);
  //   treshold = (int) $('#treshold').val();
  //   int tresText = round(treshold); //aufrunden des treshold
  //   fill(tresholdColor); // farbe des treshold
  //   noStroke();
  //   rect(0,-12,12,12);
  //   fill(255);
  //   stroke(120,130,130); //farbe des frame
  //   textAlign(LEFT);
  //   text(tresText, 110, 0); // display des treshold
  //   textFont(myText);
  //   text("tres potentio1",20,0);
  // popMatrix();





// //FRAME//////////////////////////////////////////////
//   noFill();
//   stroke(91,101,101); //farbe des frame
//   strokeWeight(1);
//   int breiteFrame = 190;
//   rect((breite-breiteFrame)/2,-40,breiteFrame,160,3);

//   //sensor beschreibung
//   fill(frameFarbe);
//   textAlign(RIGHT);
//   textFont(myText,15);
//   fill(backGround); // untergrund für text
//   noStroke();
//   rect(10,120,42,20); // untergrund für text
//   fill(frameFarbe);

//   name = (String) $('#name').val();

//   text(name, 48, 125);
  





  tickMarks = (boolean) $('#tick').prop('checked');

    //println("tickMarks      "+tickMarks);


 //tickMarks = (boolean) $('#remember').val();
//TICK MARKS//////////////////////////////////////////////
  if (tickMarks) 
  {
    pushMatrix();
      translate(0, 16);
      for (int i=0; i<11; i++)
      {
        fill(frameFarbe);
        strokeWeight(0);
        rect(0+i*15, 0, 1, 1);
      }
  
      for (int i=0; i<6; i++)
      {
        fill(frameFarbe);
        strokeWeight(0);
        rect(0+i*30, 0, 1, 2);
      }
    popMatrix();
  }





skala = (boolean) $('#scaleNumber').prop('checked');
//SKALA NUMMERIERUNG//////////////////////////////////////////////
  if (skala) {
    for (int i=0; i<6; i++)
    {
      fill(skalenFarbe);
      int value = 0;
      value = value +i*20;
      //println(value);
      textAlign(CENTER);
      textFont(myText, 9);
      text(value, i*30, 30);
    }
  }



//TRESHOLD///////////////////////////////////////////////
  //markierung wird angezeigt nur dann wenn treshold >0
  if (treshold > 0)
  {
    pushMatrix();
    fill(tresholdColor);
    noStroke();
    translate(treshold*1.5, -2);
    beginShape();
    vertex(0, 0);
    vertex(-5, -8);
    vertex(5, -8);
    endShape();
    popMatrix();
  }
  
  
//ZUFALLSGENERATOR/////////////////////////////////////////////////////
    generator =(noise(startWert+= incrementWert)*100);
    //println(generator);
    poti = generator;
  
    
//COLORPICKER/////////////////////////////////////////////////////////////
    // String farbe  = (String) $('#picker').val();
    // println("farbe   " + farbe);
    // if (farbe == "00FF00")
    // {
    //   barGraph = color(255,0,0);

    // }else{


    // }




    // int zufall = (String) $('#picker').val();
    // switch(zufall)
    // {
    
    //   case "90C5C2":
    //   fill(255,0,0); break;
      
    //   case "37C700":
    //   fill(0,255,0); break;
      
    //   case "1BE300":
    //   fill(0,0,255); break;
      
    //   case "00FF00":
    //   fill(255,255,0); break;
    //  }
    
    // rect(0,0,100,100);




  
}












