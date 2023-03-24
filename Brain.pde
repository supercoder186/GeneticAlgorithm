class Brain {
  PVector[] directions; //series of accelaration vectors which tell the dot how to move
  int step = 0;


  Brain(int size) {
    directions = new PVector[size];
    randomize();
  }

  //sets all the vectors in directions to a random vector with length 1
  void randomize() {
    for (int i = 0; i< directions.length; i++) {
      float randomAngle = random(2 * PI);
      directions[i] = PVector.fromAngle(randomAngle);
    }
  }

  //returns a copy of this brain object
  Brain clone() {
    Brain clone = new Brain(directions.length);
    for (int i = 0; i < directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }

    return clone;
  }

  //mutates the brain by setting some of the directions to random vectors
  void mutate() {
    float mutationRate = 0.01;
    for (int i = 0; i< directions.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) {
        //set this direction as a random direction 
        directions[i].rotate(random(-2/PI,2/PI));
      }
    }
  }
}
