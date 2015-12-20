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
byte robot_state = 0, old_state, first_loop;
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
  
 /*if(robot_state == STATE_AUTO)
 {
  pixelate();
 }
 else if(robot_state == STATE_DISABLED)
 {
  //rainbow((byte)0);
 }
 else if(robot_state == STATE_SCORE)
 {  
 }
 else if(robot_state == STATE_COOP)
 {
 }
 else if(robot_state == STATE_BROWNOUT)
 {
 }
 else if(robot_state == STATE_LOST_COMM)
 {
   fillStrip(strip.Color(255, 0, 0), (byte)255);
   fillStripZ(stripz.Color(255, 0, 0), (byte)255);
 }
 else if(robot_state == STATE_FULL)
 {
 }
 else if(robot_state == STATE_DISABLED)
 {
   lavalamp();
 }
 else
 {
   clearStrip();
 }*/
 fillStrip(strip.Color(255, 0, 0), (byte)255);
 fillStripZ(stripz.Color(255, 0, 0), (byte)255);
 //lavalamp();
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
    strip.setPixelColor(i, strip.Color((r * brightness / 255), (g * brightness / 255), (b * brightness / 255)));
  } 
  //
 // strip.show();
}

void fillStripZ(int c, byte brightness) {
  byte r = (byte)(c >> 16);
  byte g = (byte)(c >>  8);
  byte b = (byte)c;
  for(int i=0; i<120; i++) {
    stripz.setPixelColor(i, strip.Color((r * brightness / 255), (g * brightness / 255), (b * brightness / 255)));
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
    if(mouseX > width - 100 && (mouseY > 0 && mouseY < 50))
    {
      robot_state = (byte)STATE_AUTO;
    }
    if(mouseX > width - 100 && (mouseY > 50 && mouseY < 100))
    {
      robot_state = (byte)STATE_TELEOP;
    }
    if(mouseX > width - 100 && (mouseY > 100 && mouseY < 150))
    {
      robot_state = (byte)STATE_LOST_COMM;
    }
    if(mouseX > width - 100 && (mouseY > 150 && mouseY < 200))
    {
      robot_state = (byte)STATE_SCORE;
    }
    if(mouseX > width - 100 && (mouseY > 200 && mouseY < 250))
    {
      robot_state = (byte)STATE_FULL;
    }
    if(mouseX > width - 100 && (mouseY > 250 && mouseY < 300))
    {
      robot_state = (byte)STATE_BROWNOUT;
    }
    if(mouseX > width - 100 && (mouseY > 300 && mouseY < 350))
    {
      robot_state = (byte)STATE_DISABLED;
    }
    if(mouseX > width - 100 && (mouseY > 350 && mouseY < 400))
    {
      robot_state = (byte)STATE_COOP;
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