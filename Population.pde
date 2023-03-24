class Population {
  Dot[] dots;

  float fitnessSum;
  int gen = 0;

  int bestDot = 0;//the index of the best dot in the dots[]

  int minStep = 1000;

  Population(int size) {
    dots = new Dot[size];
    for (int i = 0; i< size; i++) {
      dots[i] = new Dot();
    }
  }

  //show all dots
  void show() {
    for (int i = 1; i< dots.length; i++) {
      dots[i].show();
    }
    dots[0].show();
  }

  //update all dots 
  void update() {
    for (int i = 0; i< dots.length; i++) {
      if (dots[i].brain.step > minStep) {//if the dot has already taken more steps than the best dot has taken to reach the goal
        dots[i].dead = true;//then it dead
      } else {
        dots[i].update();
      }
    }
  }

  //calculate all the fitnesses
  void calculateFitness() {
    for (int i = 0; i< dots.length; i++) {
      dots[i].calculateFitness();
    }
  }


  //returns whether all the dots are either dead or have reached the goal
  boolean allDotsDead() {
    for (int i = 0; i< dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) { 
        return false;
      }
    }

    return true;
  }


  //gets the next generation of dots
  void naturalSelection() {
    Dot[] newDots = new Dot[dots.length];//next gen
    calculateFitnessSum();
    
    for (int i = 0; i< newDots.length; i++) {
      //select parent based on fitness
      Dot parent = selectParent();

      //get baby from them
      newDots[i] = parent.getChild();
    }

    dots = newDots.clone();
    gen ++;
    println("Gen "+gen+" fitness: "+fitnessSum);
  }


  
  // Calculate the sum of the fitness of all the dots
  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i< dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }


  //chooses dot from the population to return randomly(considering fitness)

  //this function works by randomly choosing a value between 0 and the sum of all the fitnesses
  //then go through all the dots and add their fitness to a running sum and if that sum is greater than the random value generated that dot is chosen
  //since dots with a higher fitness function add more to the running sum then they have a higher chance of being chosen
  Dot selectParent() {
    float rand = random(fitnessSum);
    float runningSum = 0;

    for (int i = 0; i< dots.length; i++) {
      runningSum += dots[i].fitness;
      if (runningSum > rand) {
        return dots[i];
      }
    }
    
    return null;
  }

  //mutates the instruction set of the new generation
  void mutatePopulation() {
    for (int i = 1; i< dots.length; i++) {
      dots[i].brain.mutate();
    }
  }
}
