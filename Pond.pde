PShape fishSVG;
Fish player1;
Fish[] spawn;

int numTiles = 65;
color[] tiles;

int numSpawn = 15;

boolean blur = false;

boolean single = true;

CollisionManager _collisionManager;

void setup()
{
  size(1920, 1080);
  frameRate(60);
  fishSVG = loadShape("fish.svg");
  
  player1 = new Fish(#FF9524, width/2, height/2, 24, fishSVG);
  spawn = new Fish[numSpawn];
  for(int i=0; i<numSpawn; i++)
  {
    
    spawn[i] = new Fish(#FF9524, int(random(0,width)), int(random(0,height)), 24, fishSVG);
  }
  
  tiles = makeTiles();
  _collisionManager = new CollisionManager(spawn);
  
}

void draw()
{
  drawMosaic();
  randomDest();
  player1.update();
  //_collisionManager.update();
  player1.draw();
  if(!single)
  for(int i=0; i<numSpawn; i++) { spawn[i].update(); spawn[i].draw(); }
  spawn[1].update(); spawn[1].draw();

}

void randomDest()
{

  for(int i=0; i<numSpawn; i++)
  {
    //int rand = int(random(0,200));
    //println(rand);
    if( int(random(0,200)) == 1 )
    
      spawn[i].setDestination(int(random(0,width)), int(random(0,height)));
  }
}

void mousePressed()
{
  player1.setDestination(mouseX, mouseY);
}


color[] makeTiles()
{
  int r,g,b;
  r = 0; g = 70; b = 100;
  //r = 50; g = 150; b = 200; 
  //r = ()
  
  tiles = new color[numTiles];

  for(int i=0; i<numTiles; i++)
  {
    tiles[i] = color((r),(g+(random(50))),(b+(random(25))));
    //tiles[i] = color((r+(random(100))),(g+(random(100))),(b+(random(50))));
    //tiles[i] = #02486A;
    //tiles[i] = color(random(255),random(255),random(255));
  }
  return tiles;
}

void drawMosaic()
{
  int t = 30;
  stroke(0);
  strokeWeight(2);
  for(int i=0; i<64; i++)
  {
    for(int j=0; j<36; j++)
    {
      //strokeWeight((random(1,2)));
      fill(tiles[(i*t + j)%numTiles]);
      rect(i*t, j*t, t, t);
    }
  }
  fill(#0B2C18, 100);
  //wrect(0,0,width, height);
}
