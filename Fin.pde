class Fins
{
  float finScale = 1;
  float finScaleBound = 0.3;
  int flapDirection = -1;
  float flapSpeed;
  int _side;
  float _width;
  
  Fish _fish;
  
  Fins(Fish b, int side, float wid)
  {
    _fish = b;
    this._side = side;
    _width = wid;
  }
  
  void update()
  {
    finScaleBound = 0.8 - 0.5*((_fish.speed/_fish.maxSpeed));
    
    if(_fish.speed == 0)
    {
      //finScaleBound = 0.7;
      finScale += (1/180.0*(1-finScaleBound))*flapDirection;
      
    }
    else if(_fish.speed < _fish.maxSpeed)
    {
      //add larger inversely prop to speed.
      finScale += (1/30.0*(1-finScaleBound))*flapDirection;
    }
    else
    {
      finScale += (1/60.0*(1-finScaleBound))*flapDirection;    
    }
  
  
      
    if(finScale >= 1)
       flapDirection = -1;
    if (finScale < finScaleBound)
       flapDirection = 1;
     
  }

void draw()
{
    
    noStroke();
    float i = -1*_width/2*0.8;
    float m = _width/100;
    float my = _width/100 * (finScale);
    beginShape();
    vertex(0*m, 0*my+i);
    bezierVertex(0*m,0*my+i, -5*m,-10*my+i, -4*m,-28*my+i);
    bezierVertex(-3*m,-40*my+i, -4*m,-43*my+i, -5*m,-48*my+i);
    bezierVertex(-5*m,-52*my+i, 17*m,-50*my+i, 28*m,-43*my+i);
    bezierVertex(37*m,-38*my+i, 58*m,-19*my+i, 62*m,0*my+i);
    //bezierVertex(-5,-52, 17,-50, 28,-43);
    //vertex(-4, -28);
    //vertex(-6, -50);
    //vertex(27, -43);
    //vertex(61, 0);
    vertex(0*m,0*my+i);
    //vertex();
    //bezierVertex(80, 0, 80, 75, 30, 75);
    endShape();
    
    i = (_width/2)*0.8;
    m = 1*_width/100;
    //fill(255);
    beginShape();
    vertex(0*m, -1*0*m+i);
    bezierVertex(0*m,-1*0*my+i, -5*m,-1*-10*my+i, -4*m,-1*-28*my+i);
    bezierVertex(-3*m,-1*-40*my+i, -4*m,-1*-43*my+i, -5*m,-1*-48*my+i);
    bezierVertex(-5*m,-1*-52*my+i, 17*m,-1*-50*my+i, 28*m,-1*-43*my+i);
    bezierVertex(37*m,-1*-38*my+i, 58*m,-1*-19*my+i, 62*m,-1*0*my+i);
    //bezierVertex(-5,-52, 17,-50, 28,-43);
    //vertex(-4, -28);
    //vertex(-6, -50);
    //vertex(27, -43);
    //vertex(61, 0);
    vertex(0*m,0*m+i);
    //vertex();
    //bezierVertex(80, 0, 80, 75, 30, 75);
    endShape();
}
}
