public class Strip
{
  private byte pinNum = 0;
  private byte stripLength = 0;
  private int place = 0;
  private int[] leds;
  
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
    stroke(#00FF00);
    rect(0, place, width, (place + 25));
    leds = new int[stripLength];
  }
  
  public void show()
  {
    fill(#AAAAAA);
    stroke(#00ff00);
    rect(0, place, width, (place + 25));  
    noStroke();
    
    int ledDistance = (int)((width / stripLength) * 1.2);
    for(int i = 0; i < stripLength; i ++)
    {
      try{
       color c = color(leds[i]);
       strokeWeight(4);
       stroke(red(leds[i]), green(leds[i]), blue(leds[i]));
       point(ledDistance * (i + 1), place + 15);
      }
      catch(ArrayIndexOutOfBoundsException e){
        e.printStackTrace();
      }
    }
}
  
  public byte numPixels()
  {
    return stripLength; 
  }
  
  public int Color(int r, int g, int b)
  {  
    int rgb = r;
    rgb = rgb << 8;
    rgb |= g;
    rgb = rgb << 8;
    rgb |= b;
    return rgb;
  }
  public void setPixelColor(byte pixel, int c)
  {
    try{
    leds[pixel] = c;
    }
    catch(ArrayIndexOutOfBoundsException e)
    {
      e.printStackTrace();
    }
  }
}