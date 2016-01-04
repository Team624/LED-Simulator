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
       strokeWeight(10);
       stroke(red(c), green(c), blue(c));
       point(ledDistance * (i + 1), place + 13);  
    }
    //delay(5);
  }  
  
  public byte numPixels()
  {
    return stripLength; 
  }
  
  
  public int Color(int r, int g, int b)
  {  
    int rgb = ((r&0x0ff)<<16)|((g&0x0ff)<<8)|(b&0x0ff);
    return rgb;
  }
  public int Color(byte r, byte g, byte b)
  {  
    int rgb = ((r&0x0ff)<<16)|((g&0x0ff)<<8)|(b&0x0ff);
    return rgb;
  }
  
  
  public void setPixelColor(byte pixel, int c)
  {
    if(pixel>=0 && pixel<numPixels()) {
      leds[pixel] = c;
      //println(c);
    }
    else {}
  }
  public void setPixelColor(int pixel, int c)
  {
    if(pixel>=0 && pixel<numPixels()) {
      leds[pixel] = c;
      //println(c);
    }
    else {}
  }
  
  public void setPixelColor(byte pixel, int r, int g, int b)
  {
    if(pixel>=0 && pixel<numPixels()) {
      int rgb = ((r&0x0ff)<<16)|((g&0x0ff)<<8)|(b&0x0ff);
      leds[pixel] = rgb;
      //println(rgb);
    }
    else {}
  }
  public void setPixelColor(int pixel, int r, int g, int b)
  {
    if(pixel>=0 && pixel<numPixels()) {
      int rgb = ((r&0x0ff)<<16)|((g&0x0ff)<<8)|(b&0x0ff);
      leds[pixel] = rgb;
      //println(rgb);
    }
    else {}
  }
}