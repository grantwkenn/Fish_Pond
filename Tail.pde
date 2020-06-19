class Tail
{
    //TAIL
  float tailx; float taily;
  float tailAngle = 0;
  PVector _base;
  float tailBasex, tailBasey;
  PVector tcp1, tcp2;
  int _width;
  //float tcp1x, tcp1y, tcp2x, tcp2y; //tail control points 1, 2  
  int tailDirection = -1;  
  float tailBoundary = 20;
  Tail(PVector base, int wid)
  {
    _base = base;
    _width = wid;
  }
}
