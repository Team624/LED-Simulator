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
  size(700,500);
  background(#000000);
  
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
  robot_state = (byte)STATE_AUTO;
 /* 
 *  this is the place where all of your drawing code goes. what would go into loop()
 *  would be put here
 */
 if(robot_state == STATE_AUTO)
 {
   pixelate(); 
 }
 /*
 *  end of looped code
 */ 
 //delay(1000);
}


/* 
*  Put any methods in here
*/
void pixelate()
{
  byte i, px, pxs, pxss, pxz, pxsz, pxssz, randColor;
  int g, w, b, c;
  g = strip.Color(255,255,49);
  b = strip.Color(255,255,0);
  w = strip.Color(255,255,255);
  c = strip.Color(0,0,0);

  int gz, wz, bz, cz;
  gz = stripz.Color(255,255,49);
  bz = stripz.Color(255,255,0);
  wz = stripz.Color(255,255,255);
  cz = stripz.Color(0,0,0);

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

void score()
{
  for (byte i = 0; i < 64; i++) {
    byte whiteness = (byte)(i * 4);
    fillStrip(strip.Color(whiteness, 255, whiteness), (byte)255);
    fillStripZ(stripz.Color(whiteness, 255, whiteness), (byte)255);
    strip.show();
    stripz.show();
  }
}

void fillStrip(int c, byte brightness) {
  byte r = (byte)(c >> 16);
  byte g = (byte)(c >>  8);
  byte b = (byte)c;
  for(byte i=0; i<strip.numPixels(); i++) {
    strip.setPixelColor(i, strip.Color((r * brightness / 255), (g * brightness / 255), (b * brightness / 255)));
  } 
  //
 // strip.show();
}

void fillStripZ(int c, byte brightness) {
  byte r = (byte)(c >> 16);
  byte g = (byte)(c >>  8);
  byte b = (byte)c;
  for(byte i=0; i<strip.numPixels(); i++) {
    stripz.setPixelColor(i, stripz.Color((r * brightness / 255), (g * brightness / 255), (b * brightness / 255)));
  } 
  //
 // strip.show();
}



/* 
*  End of User entered methods
*/

//necessary methods in code
void pinMode(int pin, boolean output)
{
}