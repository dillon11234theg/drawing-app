// drawing app

int r=0,g=0,b=0;
int size=10;

PGraphics layer1;
PGraphics backup;

PImage emoji;

boolean emojiMode=false;

// slider
float sliderX=150;

// canvas
int canvasX=20;
int canvasY=260;
int canvasW=560;
int canvasH=320;

float colorBoxSize=50;
float sliderSize=10;

void setup(){
  size(600,600);

  emoji=loadImage("emoji.png");

  layer1=createGraphics(canvasW,canvasH);
  backup=createGraphics(canvasW,canvasH);

  layer1.beginDraw();
  layer1.background(255);
  layer1.endDraw();

  backup.beginDraw();
  backup.background(255);
  backup.endDraw();
}

void draw(){

  background(245);

  // top bar
  fill(255);
  rect(10,10,580,80,20);

  // colour box
  if(mouseX<70 && mouseY<70){
    colorBoxSize=55;
  }else{
    colorBoxSize=50;
  }

  fill(r,g,b);
  rect(20,20,colorBoxSize,colorBoxSize,10);

  fill(0);
  text("size:"+size,100,40);

  // slider line
  stroke(180);
  strokeWeight(3);
  line(120,60,320,60);

  // slider circle
  if(dist(mouseX,mouseY,sliderX,60)<10){
    sliderSize=14;
  }else{
    sliderSize=10;
  }

  fill(50);
  ellipse(sliderX,60,sliderSize,sliderSize);
  noStroke();

  size=int(map(sliderX,120,320,1,40));

  if(mousePressed){
    if(mouseY>50 && mouseY<70){
      if(mouseX>120 && mouseX<320){
        sliderX=mouseX;
      }
    }
  }

  // drawing area
  fill(255);
  rect(10,100,580,70,20);

  fill(255,0,0); rect(30,115,40,40,10);
  fill(0,0,255); rect(80,115,40,40,10);
  fill(0,255,0); rect(130,115,40,40,10);
  fill(255,255,0); rect(180,115,40,40,10);
  fill(255,120,0); rect(230,115,40,40,10);
  fill(0); rect(280,115,40,40,10);
  fill(255); rect(330,115,40,40,10);

  // buttons
  fill(255);
  rect(10,180,580,60,20);

  fill(230);
  rect(40,195,80,30,10);
  rect(140,195,80,30,10);
  rect(240,195,80,30,10);
  rect(340,195,80,30,10);

  fill(0);
  text("Reset",55,215);
  text("Reload",150,215);
  text("Save",260,215);
  text("Emoji",355,215);

  // text
  fill(0);
  if(emojiMode){
    text("Mode: Emoji",450,215);
  }else{
    text("Mode: Pen",450,215);
  }

  // canvas bg
  fill(255);
  rect(canvasX,canvasY,canvasW,canvasH,20);

  image(layer1,canvasX,canvasY);

  // drawing part
  if(mousePressed){

    if(mouseX>canvasX && mouseX<canvasX+canvasW &&
       mouseY>canvasY && mouseY<canvasY+canvasH){

      layer1.beginDraw();

      if(emojiMode){
        layer1.image(emoji,
        mouseX-canvasX-10,
        mouseY-canvasY-10,
        25,25);
      }else{
        layer1.stroke(r,g,b);
        layer1.strokeWeight(size);

        layer1.line(
          pmouseX-canvasX,
          pmouseY-canvasY,
          mouseX-canvasX,
          mouseY-canvasY
        );
      }

      layer1.endDraw();
    }
  }

}


// click 
void mousePressed(){

  // save backup
  backup.beginDraw();
  backup.image(layer1,0,0);
  backup.endDraw();

  // color pick
  if(mouseX>30 && mouseX<70 && mouseY>115 && mouseY<155){
    r=255;g=0;b=0;
  }
  if(mouseX>80 && mouseX<120 && mouseY>115 && mouseY<155){
    r=0;g=0;b=255;
  }
  if(mouseX>130 && mouseX<170 && mouseY>115 && mouseY<155){
    r=0;g=255;b=0;
  }
  if(mouseX>180 && mouseX<220 && mouseY>115 && mouseY<155){
    r=255;g=255;b=0;
  }
  if(mouseX>230 && mouseX<270 && mouseY>115 && mouseY<155){
    r=255;g=120;b=0;
  }
  if(mouseX>280 && mouseX<320 && mouseY>115 && mouseY<155){
    r=0;g=0;b=0;
  }
  if(mouseX>330 && mouseX<370 && mouseY>115 && mouseY<155){
    r=255;g=255;b=255;
  }

  // reset
  if(mouseX>40 && mouseX<120){
    if(mouseY>195 && mouseY<225){
      layer1.beginDraw();
      layer1.background(255);
      layer1.endDraw();
    }
  }

  // reload
  if(mouseX>140 && mouseX<220){
    if(mouseY>195 && mouseY<225){
      layer1.beginDraw();
      layer1.image(backup,0,0);
      layer1.endDraw();
    }
  }

  // save
  if(mouseX>240 && mouseX<320){
    if(mouseY>195 && mouseY<225){
      saveFrame("drawing-####.png");
    }
  }

  // emoji toggle
  if(mouseX>340 && mouseX<420){
    if(mouseY>195 && mouseY<225){
      emojiMode=!emojiMode;
    }
  }

}
