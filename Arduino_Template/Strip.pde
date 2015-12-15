public class Strip
{
  private byte pinNum = 0;
  private byte stripLength = 0;
  private int place = 0;
  private color[] leds;
  
  public Strip(byte stripLength, byte pinNum, int place)
  {
    this.place = place;
    this.stripLength = stripLength;
    this.pinNum = pinNum;
  }
  
  public void begin()
  {
    rectMode(CORNERS);
    fill(#AAAAAA);
    rect(0, place, width, (place + 25));
    leds = new color[stripLength];
  }
  
  public void show()
  {
    strokeWeight(3);
    stroke(#00FF00);
    fill(#AAAAAA);
    rect(0, place, width, (place + 25));
    noFill();
    int ledDistance = (int)((width / stripLength) * 1.3);
    for(int i = 0; i < stripLength; i ++)
    {
       strokeWeight(4);
       stroke(leds[i]);
       point(ledDistance * (i + 1), place + 15);
    }
  }
  
  public byte numPixels()
  {
    return stripLength; 
  }
  
  public int Color(int r, int g, int b)
  {
    String hex = String.format("#%02X%02X%02X", r, g, b);
    //println(r + " " + g + " " + b);
    //return Integer.parseInt(hex);
    
    return Integer.parseInt(hex.replaceFirst("#", ""), 16);
  }
  
  public void setPixelColor(byte pixel, int c)
  {
    leds[pixel] = c;
  }
}