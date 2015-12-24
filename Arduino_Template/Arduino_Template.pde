/*  
*  +-------------------------------------------------------+
* -+ Hello! This Processing file is a template for arduino +-
* -+ files, the following code is Gravity's light code,    +-
* -+ and the following codes and variables may note apply. +-
* -+ However, the structure as created here is designed to +-
* -+ be able to accept arduino code (with a few tweaks)    +-
* -+ and be run as a visual animation using the processing +-
* -+ language.                                             +-
*  +-------------------------------------------------------+
*/


int boxY = 10000;
boolean OUTPUT = true;
boolean INPUT = false;

/*
*  declare all Pins here
*  bool in arduino is declared as a boolean
*  when defining pins, declare as integer, not using #define
*/
byte PIN = 6; //pin of strip 1
byte PINZ = 2; //pin of strip 2

int ROBOT_STATE_PIN  = 12;
int ROBOT_STATE_PIN_TWO = 22;
int ROBOT_STATE_PIN_THREE = 28;

boolean on = true;
boolean stay_white = false;
/*
*  ends pin setup 
*/
//sets up all instances of Serial and LED strips
serial Serial = new serial();
//sets up all LED strips
Strip strip = new Strip(/* Strip Length */(byte)120, PIN, 108); //creates an LED strip
Strip stripz = new Strip(/* Strip Length */ (byte)120, PINZ, 366); //creates an LED strip instance 'stripz' You can create more
//end of setup                                                  //instances below, but to use them, you must use the begin and show methods

void setup()
{
  size(1300,500);
  PFont font;
  font = createFont("Calibri", 14);
  textFont(font);
  
  //background(#000000);
  
  /*
  *  all setup code goes here
  */
  pinMode(PIN, OUTPUT);
  pinMode(PINZ, OUTPUT);
  
  strip.begin();
  strip.show();
  
  stripz.begin();
  stripz.show();
  Serial.begin(9600);
  /*
  *  end setup code
  */
  
}

/*
*  defines states of robot
*  these states are passed from robot code
*/
int STATE_UNKNOWN = 00010;
int STATE_TELEOP = 0b000;
int STATE_AUTO = 0b001;
int STATE_SCORE = 0b010;
int STATE_COOP = 0b011;
int STATE_BROWNOUT = 0b100;
int STATE_LOST_COMM = 0b101;
int STATE_FULL = 0b110;
int STATE_DISABLED = 0b111;
/*
*  end of state declaration
*/

/*
*  Declare all variables used in loop and related 
*  methods here. All uint8_t variables should be 
*  written as bytes and of course, bools are 
*  booleans
*/
byte finger_height;
boolean elevator_auto;
boolean stabilizer_on;
boolean finger_on;
byte robot_state = 8, old_state; 
boolean first_loop;
/*
*  end declarations
*/

void draw()
{
  stateSelector();
  stroke(#00FF00);
  noFill();
  rectMode(CORNER);
  rect(width - 100, boxY, 100, 50);
  rectMode(CORNERS);
  if(old_state != robot_state)
  {
    first_loop = true;
    stay_white = false;
    fillStrip(strip.Color(0,0,0), (byte)255);
    fillStripZ(strip.Color(0,0,0), (byte)255);
  }
  old_state = robot_state;
 /* 
 *  this is the place where all of your drawing code goes. what would go into loop()
 *  would be put here
 */
 
 if(robot_state == STATE_TELEOP)
 {rainbow(0);}
 else if(robot_state == STATE_AUTO) {
   pixelate();
 }
 else if(robot_state == STATE_SCORE) {
   rainbowlaser();
 }
 else if(robot_state == STATE_COOP) {
   coop_rainbowlaser();
 }
 else if(robot_state == STATE_BROWNOUT) {
   fillStrip(strip.Color(70, 25, 0), (byte)255);
   fillStripZ(strip.Color(70, 25, 0), (byte)255);
 }
 else if(robot_state == STATE_LOST_COMM) {
   fillStrip(strip.Color(255, 0, 0), (byte)255);
   fillStripZ(stripz.Color(255, 0, 0), (byte)255);
 }
 else if(robot_state == STATE_FULL) {
   fillStrip(strip.Color(0, 0, 0), (byte)255);
   fillStripZ(stripz.Color(0, 0, 0), (byte)255);
 }
 else if(robot_state == STATE_DISABLED) {
   lavalamp();
 }
 else {
   //clearStrip();
   rainbow(0);
 }
 
 /*
 *  end of looped code
 */ 
 strip.show();
 stripz.show();
}




/* 
*  Put any methods in here
*/
void pixelate()
{
  byte i, px, pxs, pxss, pxz, pxsz, pxssz, Color;
  int g, w, b, c;
  g = strip.Color(255, 255, 49);
  b = strip.Color(255, 255, 0);
  w = strip.Color(255, 255, 255);
  c = strip.Color(0, 0, 0);

  int gz, wz, bz, cz;
  gz = stripz.Color(255, 255, 49);
  bz = stripz.Color(255, 255, 0);
  wz = stripz.Color(255, 255, 255);
  cz = stripz.Color(0, 0, 0);


  px = (byte)random(0, strip.numPixels());
  pxs = (byte)random(0, strip.numPixels());
  pxss = (byte)random(0, strip.numPixels());
  Color = (byte)random(0, 4);
  if (Color == 0)
  {
    strip.setPixelColor(px, g);
    strip.setPixelColor(pxs, g);
    strip.setPixelColor(pxss, g);

    stripz.setPixelColor(px, gz);
    stripz.setPixelColor(pxs, gz);
    stripz.setPixelColor(pxss, gz);
  }
  else if (Color == 1)
  {
    strip.setPixelColor(px, b);
    strip.setPixelColor(pxs, b);
    strip.setPixelColor(pxss, b);

    stripz.setPixelColor(px, bz);
    stripz.setPixelColor(pxs, bz);
    stripz.setPixelColor(pxss, bz);
  }
  else if (Color == 2)
  {
    strip.setPixelColor(px, c);
    strip.setPixelColor(pxs, c);
    strip.setPixelColor(pxss, c);

    stripz.setPixelColor(px, cz);
    stripz.setPixelColor(pxs, cz);
    stripz.setPixelColor(pxss, cz);
  }
  else
  {
    strip.setPixelColor(px, w);
    strip.setPixelColor(pxs, w);
    strip.setPixelColor(pxss, w);

    stripz.setPixelColor(px, w);
    stripz.setPixelColor(pxs, w);
    stripz.setPixelColor(pxss, w);
  }
  strip.show();
  stripz.show();
}

int i = -1;
void rainbowlaser()
{
  
  int ii, c, w, r, o, y, g, b, v;
  r = strip.Color(255, 0, 0);
  o = strip.Color(255, 128, 0);
  y = strip.Color(255, 255, 0);

  g = strip.Color(0, 255, 0);

  b = strip.Color(0, 0, 255);
  ii = strip.Color(128, 0, 255);
  v = strip.Color(255, 0, 255);

  w = 32;

  int iii, cz, wz, rz, oz, yz, gz, bz, iz, vz;
  rz = stripz.Color(255, 0, 0);
  oz = stripz.Color(255, 128, 0);
  yz = stripz.Color(255, 255, 0);

  gz = stripz.Color(0, 255, 0);

  bz = stripz.Color(0, 0, 255);
  iii = stripz.Color(128, 0, 255);
  vz = stripz.Color(255, 0, 255);

  if (!stay_white)
  {
      if(i==-1)
      {
        i=strip.numPixels() + w;
      }
    //for (i = strip.numPixels() + w; i > 0; i--)
    //{
      strip.setPixelColor(i, strip.Color(120, 120, 120));
      strip.setPixelColor(i - 4, v);
      strip.setPixelColor(i - 8, ii);
      strip.setPixelColor(i - 12, b);
      strip.setPixelColor(i - 16, g);
      strip.setPixelColor(i - 20, y);
      strip.setPixelColor(i - 24, o);
      strip.setPixelColor(i - 28, r);
      strip.setPixelColor(i - w, strip.Color(120, 120, 120));

      stripz.setPixelColor(i, strip.Color(120, 120, 120));
      stripz.setPixelColor(i - 4, vz);
      stripz.setPixelColor(i - 8, iii);
      stripz.setPixelColor(i - 12, bz);
      stripz.setPixelColor(i - 16, gz);
      stripz.setPixelColor(i - 20, yz);
      stripz.setPixelColor(i - 24, oz);
      stripz.setPixelColor(i - 28, rz);
      //stripz.setPixelColor(i-w,strip.Color(120,120,120));

      strip.show();
      stripz.show();
      delay(15);
   // }
     if(i>0)
     {
       i--;
     }
     else
     {
        i=-1;
        stay_white = true;
     }
  }
  else
  {
    fillStrip(strip.Color(120, 120, 120), (byte)255);
    fillStripZ(stripz.Color(120, 120, 120), (byte)255);
    strip.show();
    stripz.show();
  }
}

int cri = -1;
void coop_rainbowlaser()
{
  int ii, c, w, r, o, y, g, b, i, v;
  r = strip.Color(255, 0, 0);
  o = strip.Color(255, 128, 0);
  y = strip.Color(255, 255, 0);

  g = strip.Color(0, 255, 0);

  b = strip.Color(0, 0, 255);
  ii = strip.Color(128, 0, 255);
  v = strip.Color(255, 0, 255);

  w = 32;

  int iii, cz, wz, rz, oz, yz, gz, bz, iz, vz;
  rz = stripz.Color(255, 0, 0);
  oz = stripz.Color(255, 128, 0);
  yz = stripz.Color(255, 255, 0);

  gz = stripz.Color(0, 255, 0);

  bz = stripz.Color(0, 0, 255);
  iii = stripz.Color(128, 0, 255);
  vz = stripz.Color(255, 0, 255);

  if (!stay_white)
  {
    if(cri==-1)
    {
       cri=strip.numPixels() + w;
    }
    //for (i = strip.numPixels() + w; i > 0; i--)
    //{
      strip.setPixelColor(cri, y);
      strip.setPixelColor(cri - 4, v);
      strip.setPixelColor(cri - 8, ii);
      strip.setPixelColor(cri - 12, b);
      strip.setPixelColor(cri - 16, g);
      strip.setPixelColor(cri - 20, y);
      strip.setPixelColor(cri - 24, o);
      strip.setPixelColor(cri - 28, r);
      strip.setPixelColor(cri - w, y);

      stripz.setPixelColor(cri, y);
      stripz.setPixelColor(cri - 4, vz);
      stripz.setPixelColor(cri - 8, iii);
      stripz.setPixelColor(cri - 12, bz);
      stripz.setPixelColor(cri - 16, gz);
      stripz.setPixelColor(cri - 20, yz);
      stripz.setPixelColor(cri - 24, oz);
      stripz.setPixelColor(cri - 28, rz);
      //stripz.setPixelColor(i-w,strip.Color(120,120,120));

      strip.show();
      stripz.show();
      
      if(cri>0)
      {
         cri--;
      }
      else
      {
         cri = -1;
         stay_white = true;
      }
      //delay(15);
    //}
    strip.show();
    stripz.show();
    //stay_white = true;
  }
  else
  {
    fillStrip(y, (byte)255);
    fillStripZ(y, (byte)255);
    strip.show();
    stripz.show();
  }
}

void lavalamp()
{
  int t = millis() / 40;
  for (byte i = 0; i < 122; i++) {
    int brightness = (int)(sin((t + i) / 4.0) * 255);
    int other = (int)(cos((t * 1.1 + i) / 3.5) * 255);
    brightness = brightness - other;
    int rrr = (int)(cos((t / 1 + i / 2) << 8) * 255);
    strip.setPixelColor(i, strip.Color(0, brightness, 0));
    stripz.setPixelColor(i, strip.Color(0, brightness, 0));
  }
  //int g;
  strip.show();
  stripz.show();
}

void fillStrip(int c, byte brightness) {
  byte r = (byte)(c >> 16);
  byte g = (byte)(c >>  8);
  byte b = (byte)c;
  for(int i=0; i<strip.numPixels(); i++) {
    int colo = strip.Color((r * brightness / 255), (g * brightness / 255), (b * brightness / 255));
    strip.setPixelColor(i, colo);
  } 
  //
  //strip.show();
}

void fillStripZ(int c, byte brightness) {
  byte r = (byte)(c >> 16);
  byte g = (byte)(c >>  8);
  byte b = (byte)c;
  for(int i=0; i<120; i++) {
    stripz.setPixelColor(i, strip.Color((r * brightness / 255), (g * brightness / 255), (b * brightness / 255)));
  } 
  //
  //stripz.show();
}

int j=0;
void rainbow(int wait) {
  int i;
  
  
    for (i = 0; i < strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel((i + j) & 255));
    }
    for (i = 0; i < stripz.numPixels(); i++) {
      stripz.setPixelColor(i, Wheel((i + j) & 255));
    }


    strip.show();
    stripz.show();
    delay(wait);
  
  if(j<255)
  {
    j++;
  }
  else
  {
    j=0;
  }
}

int Wheel(int WheelPos) {
  WheelPos = 255 - WheelPos;
  if(WheelPos < 85) {
   return strip.Color(255 - WheelPos * 3, 0, WheelPos * 3);
  } else if(WheelPos < 170) {
    WheelPos -= 85;
   return strip.Color(0, WheelPos * 3, 255 - WheelPos * 3);
  } else {
   WheelPos -= 170;
   return strip.Color(WheelPos * 3, 255 - WheelPos * 3, 0);
  }
}


/* 
*  End of User entered methods
*/

//necessary methods in code
void pinMode(int pin, boolean output)
{
}

void stateSelector()
{
  rectMode(CORNERS);
  stroke(#00FF00);
  strokeWeight(3);
  fill(#000000);
  rect(width - 100, 0, width, height);
  
  fill(#00FF00);
  text("Teleop", width - 85, 50);
  text("Auto", width - 85, 100);
  text("Score", width - 85, 150);
  text("COOP", width - 85, 200);
  text("Brownout", width - 85, 250);
  text("Lost Comms", width - 85, 300);
  text("Full", width - 85, 350);
  text("Disable", width - 85, 400);
  text("No State", width - 85, 480);
  
  if(mousePressed == true)
  {
    if(mouseX > width - 100 && mouseY > 25 && 75 > mouseY)
    {
      robot_state = (byte)STATE_TELEOP;
      boxY = 25;
    }
    if(mouseX > width - 100 && mouseY > 75 && 125 > mouseY)
    {
      robot_state = (byte)STATE_AUTO;
      boxY = 75;
    }
    if(mouseX > width - 100 && mouseY > 125 && 175 > mouseY)
    {
      robot_state = (byte)STATE_SCORE;
      boxY = 125;
    }
    if(mouseX > width - 100 && mouseY > 175 && 225 > mouseY)
    {
      robot_state = (byte)STATE_COOP;
      boxY = 175;
    }
    if(mouseX > width - 100 && mouseY > 225 && 275 > mouseY)
    {
      robot_state = (byte)STATE_BROWNOUT;
      boxY = 225;
    }
    if(mouseX > width - 100 && mouseY > 275 && 325 > mouseY)
    {
      robot_state = (byte)STATE_LOST_COMM;
      boxY = 275;
    }
    if(mouseX > width - 100 && mouseY > 325 && 375 > mouseY)
    {
      robot_state = (byte)STATE_FULL;
      boxY = 325;
    }
    if(mouseX > width - 100 && mouseY > 375 && 425 > mouseY)
    {
      robot_state = (byte)STATE_DISABLED;
      boxY = 375;
    }
    if(mouseX > width - 100 && mouseY > 450 && 500 > mouseY)
    {
      robot_state = (byte)STATE_UNKNOWN;
      boxY = 460;
    }
  }
}

void clearStrip()
{
   for(int i = 0; i < strip.numPixels(); i ++)
   {
     strip.setPixelColor(i, 0); 
     strip.show();
     delay(1);
   }
   for(int i = 0; i < stripz.numPixels(); i ++)
   {
     stripz.setPixelColor(i,0); 
     stripz.show();
     delay(1);
   }
}