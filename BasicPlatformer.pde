float baseLevel;
float speed = 1;
int xs = 16;
int ys = 16;
Runner player;
PVector gravity = new PVector(0,-0.2);
PVector jumpStrength = new PVector(0,6);
Mover[][] obstacles;

void setup(){
 size(640, 480);
 rectMode(CORNER);
 obstacles  = new Mover[width/xs][height/ys];
 baseLevel = 1;
 loadMap();
 //setupGround();
 player = new Runner(100, 60);
 player.applyForce(new PVector(0,0));
}

String[] map = {
                  "########################################",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "#                                      #",
                  "########################################",
                 };

void loadMap(){
  for (int x = 0; x<40; x++)
    for (int y = 0; y<30; y++)
    {
       if (map[y].charAt(x)=='#')
         obstacles[x][y] = new Mover(0,0);
    }
}

void keyPressed(){
 if (!player.isDying)
  if (key == CODED){
    if (keyCode == UP){
      if (player.speed.y == 0)
        player.applyForce(jumpStrength);
    }
    else
    if (keyCode == DOWN){
      player.isCrawling = true;
    }
    else
    if (keyCode == RIGHT){
      player.speed.x = 2;
    }
    else
    if (keyCode == LEFT){
      player.speed.x = -2;
    }
  }
}

void mouseDragged(){
  int x = (int)mouseX/xs;
  int y = (int)(height-mouseY)/ys;
  if (mouseButton == LEFT)
    if (obstacles[x][y] == null) obstacles[x][y] = new Mover(0,0);
  if (mouseButton == RIGHT)
    obstacles[x][y] = null;
}

void keyReleased(){
  if (!player.isDying)
  if (key == CODED){
    if (keyCode == DOWN){
      player.isCrawling = false;
    }
    else
    if (keyCode == LEFT || keyCode == RIGHT){
      player.speed.x = 0;
    }
  }
}

void mouseClicked(){
}

void Collision(int dir)
 {
   for (int i = (int)player.position.x/xs; i<(player.position.x+player.Width)/xs; i++)
     for (int j = (int)player.position.y/ys ; j<(player.position.y+player.Height)/ys; j++){ 
       //print(i+":"+j+" "); 
       if (obstacles[i][j]!= null) 
       { 
          if ((player.speed.x>0) && (dir==0)) player.position.x = i*xs - player.Width; 
          if ((player.speed.x<0) && (dir==0)) player.position.x =  i*xs + xs;
          if ((player.speed.y>0) && (dir==1)) { player.position.y = j*ys - player.Height; player.speed.y=0; player.isOnGround=true; }
          if ((player.speed.y<0) && (dir==1)) { player.position.y = j*ys + ys; player.speed.y=0;}
       }
    }
 }

void draw(){
  background(0);
  pushMatrix();
  translate(0,height);
  scale(1,-1);
  player.applyForce(gravity);
  player.move(0);
  Collision(0);
  
  if (!player.isOnGround){
   player.move(1);
  }
   player.isOnGround = false;
   Collision(1);
    
  for (int x = 0; x < obstacles.length; x++)
    for (int y = 0; y < obstacles[x].length; y++){
       Mover m = obstacles[x][y];   
       if (m != null) rect(x*xs, y*ys, xs, ys);
    }
  player.draw();
  popMatrix();
  cleanup();
}


void cleanup(){
 //ground

}