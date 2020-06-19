class Fish extends Body
{
  color _color;   
  float _width, _length;

  
  // Child Objects
  Tail _tail; 
  Fins _fins;
  BezierFish _bezier;
  PShape superSVG;
  
  Flagellum flag;
  
  Fins right, left;
  

  
  //Body(position, 20);
  
  Fish(color c, int x, int y, int wid, PShape svg)
   {
     super(new PVector(x,y), 6, (wid*2.5));
     _color = c;     
     _width = wid;
     _length = wid * 2.5;
     _tail = new Tail( new PVector(), wid);
     superSVG = svg;
     _bezier = new BezierFish(wid, this);
     
     _fins = new Fins(this, 1, _width);
      flag = new Flagellum(40, 10, 10);
     

   }
   
void update() 
  {
    super.update();
    _bezier.update();
    _fins.update();
    flag.swim();
  }
  
  void draw()
  {
    pushMatrix();
    translate(super.position.x, super.position.y);
    rotate(super.heading);
    rotate(-2*PI*((_bezier.tailAngle/2.0)/360.0));
    fill(_color);
    noStroke();
    _bezier.draw();
    shape(superSVG, 0-_length/2, 0-_width/2, _length, _width);
    _fins.draw();
    fill(#FF6D12);
    translate(0-_length/2.0,0);
    rotate(PI);
    flag.render();
    popMatrix();
  }
  
  void setDestination(int x, int y)
  {
    super.setWander(x, y);
  }
  

}
