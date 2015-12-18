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
  font = createFont("Algerian", 14);
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
byte robot_state, old_state, first_loop;
/*
*  end declarations
*/

void draw()
{
  stateSelector();
 /* 
 *  this is the place where all of your drawing code goes. what would go into loop()
 *  would be put here
 */
 
  //bouncelaser(); //doesn't work
  //fillStrip(strip.Color(255,000,255),(byte)255); //works
  //fillStripZ(stripz.Color(255,000,000),(byte)255); //works
  pixelate(); //works
  //rainbow((byte)0); //doesnt work yet
  //coop_rainbowlaser(); //doesnt work yet
  
 if(robot_state == STATE_AUTO)
 {
  //pixelate();
 }
 /*
 *  end of looped code
 */ 
}


/* 
*  Put any methods in here
*/
void rainbow(byte wait) {
  byte i, j;

  for (j = 0; j < 256; j++) {
    for (i = 0; i < strip.numPixels(); i++) {
      strip.setPixelColor(i, Wheel((byte)((i + j) & 255)));
    }
    for (i = 0; i < stripz.numPixels(); i++) {
      stripz.setPixelColor(i, Wheel((byte)((i + j) & 255)));
    }

    strip.show();
    stripz.show();
    delay(wait);
  }
}

void pixelate()
{
  byte i, px, pxs, pxss, pxz, pxsz, pxssz, randColor;
  int g, w, b, c;
  g = strip.Color(255,255,49);
  b = strip.Color(255,255,000);
  w = strip.Color(255,255,255);
  c = strip.Color(000,000,000);

  int gz, wz, bz, cz;
  gz = stripz.Color(255,255,49);
  bz = stripz.Color(255,255,000);
  wz = stripz.Color(255,255,255);
  cz = stripz.Color(000,000,000);

  px = (byte)random(0, strip.numPixels());
  pxs = (byte)random(0, strip.numPixels());
  pxss = (byte)random(0, strip.numPixels());
  randColor = (byte)random(0, 4);
  if (randColor == 0)
  {
    strip.setPixelColor(px, g);
    strip.setPixelColor(pxs, g);
    strip.setPixelColor(pxss, g);

    stripz.setPixelColor(px, gz);
    stripz.setPixelColor(pxs, gz);
    stripz.setPixelColor(pxss, gz);
  }
  else if (randColor == 1)
  {
    strip.setPixelColor(px, b);
    strip.setPixelColor(pxs, b);
    strip.setPixelColor(pxss, b);

    stripz.setPixelColor(px, bz);
    stripz.setPixelColor(pxs, bz);
    stripz.setPixelColor(pxss, bz);
  }
  else if (randColor == 2)
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

void coop_rainbowlaser()
{
  byte i;
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
    for (i = (byte)(strip.numPixels() + w); i > 0; i--)
    {
      strip.setPixelColor(i, y);
      strip.setPixelColor((byte)(i - 4), v);
      strip.setPixelColor((byte)(i - 8), ii);
      strip.setPixelColor((byte)(i - 12), b);
      strip.setPixelColor((byte)(i - 16), g);
      strip.setPixelColor((byte)(i - 20), y);
      strip.setPixelColor((byte)(i - 24), o);
      strip.setPixelColor((byte)(i - 28), r);
      strip.setPixelColor((byte)(i - w), y);

      stripz.setPixelColor(i, y);
      stripz.setPixelColor((byte)(i - 4), vz);
      stripz.setPixelColor((byte)(i - 8), iii);
      stripz.setPixelColor((byte)(i - 12), bz);
      stripz.setPixelColor((byte)(i - 16), gz);
      stripz.setPixelColor((byte)(i - 20), yz);
      stripz.setPixelColor((byte)(i - 24), oz);
      stripz.setPixelColor((byte)(i - 28), rz);
      //stripz.setPixelColor(i-w,strip.Color(120,120,120));

      strip.show();
      stripz.show();
      //delay(15);
    }
    stay_white = true;
  }
  else
  {
    fillStrip(y, (byte)255);
    fillStripZ(y, (byte)255);
    strip.show();
    stripz.show();
  }
}

void bouncelaser()
{
  byte i, w;
  int c;
  c = strip.Color(0, 255, 0);

  w = 12;

  for (i = w; i < (strip.numPixels() + (w - 6)); i++)
  {
    strip.setPixelColor(i, c);
    strip.setPixelColor((byte)(i - w), 0);
    //strip.setPixelColor(i+5,0);
    strip.show();
    //delay(15);
  }

  for (i = (byte)(strip.numPixels() - (w - 6)); (i + 6) > 0; i--)
  {
    strip.setPixelColor(i, c);
    strip.setPixelColor((byte)(i - w), 0);
    //strip.setPixelColor(i+5,0);
    strip.show();
    //delay(15);
  }

}



void fillStrip(int c, byte brightness) {
  int r = (int)(c >> 16);
  int g = (int)(c >>  8);
  int b = (int)c;
  for(byte i=0; i<strip.numPixels(); i++) {
    strip.setPixelColor(i, strip.Color((r * brightness / 255), (g * brightness / 255), (b * brightness / 255)));
  } 
  //
  strip.show();
}

void fillStripZ(int c, byte brightness) {
  int r = (int)(c >> 16);
  int g = (int)(c >>  8);
  int b = (int)c;
  for(byte i=0; i<stripz.numPixels(); i++) {
    stripz.setPixelColor(i, stripz.Color((r * brightness / 255), (g * brightness / 255), (b * brightness / 255)));
  } 
  //
  stripz.show();
}

/*
*  Utilities.h converted to Java
*/
int Wheel(byte WheelPos) {
  WheelPos = (byte)(255 - WheelPos);
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


/*
int STATE_TELEOP = 0b000;
int STATE_AUTO = 0b001;
int STATE_SCORE = 0b010;
int STATE_COOP = 0b011;
int STATE_BROWNOUT = 0b100;
int STATE_LOST_COMM = 0b101;
int STATE_FULL = 0b110;
int STATE_DISABLED = 0b111;
*/
void stateSelector()
{
  rectMode(CORNERS);
  stroke(#00FF00);
  strokeWeight(3);
  fill(#000000);
  rect(width - 100, 0, width, height); 
  fill(#00FF00);
  text("Auto", width - 70, 50);
  text("Teleop", width - 80, 100);
  text("Lost-Comms", width - 90, 150);
  text("Score", width - 75, 200);
  text("Full", width - 70, 250);
  text("Brownout", width - 90, 300);
  text("Disabled", width - 85, 350);
  text("CO OP", width - 70, 400);
  if(mousePressed == true)
  {
  }
}