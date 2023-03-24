class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;

  boolean dead = false;
  boolean reachedGoal = false;

  float fitness = 0;

  Dot() {
    brain = new Brain(1000); //new brain with 1000 instructions

    // start the dots at the bottom of the window with a no velocity or acceleration
    pos = new PVector(width/2, height - 10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }


  // draws the dot on the screen
  void show() {
    fill(0);
    ellipse(pos.x, pos.y, 4, 4);
  }

  // moves the dot according to the brains directions
  void move() {
    if (brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else {//if at the end of the directions array then the dot is dead
      dead = true;
    }

    //apply the acceleration and move the dot
    vel.add(acc);
    vel.limit(5); // Limit the dot speed to 5
    pos.add(vel);
  }

  //calls the move function and checks for collisions
  void update() {
    if (!dead && !reachedGoal) {
      move();
      if (pos.x< 2|| pos.y<2 || pos.x>width-2 || pos.y>height -2) {//if near the edges of the window then kill it 
        dead = true;
      } else if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {//if reached goal
        reachedGoal = true;
      } /* else if (pos.x< 600 && pos.y < 310 && pos.x > 0 && pos.y > 300) {//if hit obstacle
        dead = true;
      } */
    }
  }

  //calculates the fitness
  void calculateFitness() {
    if (reachedGoal) {//if the dot reached the goal then the fitness is based on the amount of steps it took to get there
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    } else {//if the dot didn't reach the goal then the fitness is based on how close it is to the goal
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }

  //return a clone of the dot (its child)
  Dot getChild() {
    Dot clone = new Dot();
    clone.brain = brain.clone(); //clones have the same brain as their parents
    return clone;
  }
}
