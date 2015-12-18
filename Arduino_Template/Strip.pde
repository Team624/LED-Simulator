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
    fill(#000000);
    stroke(#00FF00);
    strokeWeight(3);
    rect(0, place, width - 100, (place + 25));
    leds = new int[stripLength];
  }
  
  public void show()
  {
    fill(#000000);
    strokeWeight(3);
    stroke(#00ff00);
    rect(0, place, width - 100, (place + 25));  
    noStroke();
    
    float ledDistance = ((width - 100)/ stripLength) * .99;
    for(int i = 0; i < stripLength; i ++)
    {
       color c;
       c = leds[i];
       strokeWeight(6);
       stroke(red(c), green(c), blue(c));
       point(ledDistance * (i + 1), place + 13);
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
    if(pixel>=0 && pixel<numPixels())
        leds[pixel] = c;
    else
      leds[pixel] = 11184810;
  }
}