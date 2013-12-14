import java.util.Scanner;

public class WhichSystem {

  /* This application will help you determine
   * how much memory you need on the current
   * to do the task you report you
   * want to do.
   * The specifics are in the project description
   * file posted on the class web site.
   */
  
  public static void main(String[] args) {
    Scanner inStream = new Scanner(System.in);
    
    System.out.println("Users?");
    int numUsers = inStream.nextInt();
    
    if (numUsers < 1) {
      System.out.println("None needed");
    }
    
    if (numUsers >= 50) {
      System.out.println("Impossible");
    }
    
    if (numUsers >= 1) {
      if (numUsers < 50) {
        System.out.println("System?");
        String compSystem = inStream.next();
        
        if (compSystem.equals("windows")) {
          System.out.println("Processes?");
          int compProcesses = inStream.nextInt();
          
          if (compProcesses <= 0) {
            System.out.println("Impossible");
          }
          
          if (compProcesses > 0) {
            if (compProcesses * numUsers > 100) {
              System.out.println("Impossible");
            }
            
            if (compProcesses * numUsers >= 1) {
              if (compProcesses * numUsers <= 30) {
                int numUnits = 1;
                System.out.println("On " + compSystem + " with " + numUsers + 
                                   " users each running " + compProcesses + " processes, you will need " +
                                   numUnits + " units of memory.");
              }
            }
            
            if (compProcesses * numUsers >= 31) {
						  if (compProcesses * numUsers <= 50) {
							  int numUnits = 2;
							  System.out.println("On " + compSystem + " with " + numUsers + 
							                     " users each running " + compProcesses + " processes, you will need " +
								                   numUnits + " units of memory.");
						  }
					  }
					
					  if (compProcesses * numUsers >= 51) {
						  if (compProcesses * numUsers <= 75) {
							  int numUnits = 3;
							  System.out.println("On " + compSystem + " with " + numUsers + 
							                     " users each running " + compProcesses + " processes, you will need " +
							                     numUnits + " units of memory.");
					  	}
					  }
					
					  if (compProcesses * numUsers >= 76)	{
						  if (compProcesses * numUsers <= 100) {
							  int numUnits = 4;
							  System.out.println("On " + compSystem + " with " + numUsers + 
							                     " users each running " + compProcesses + " processes, you will need " +
							                     numUnits + " units of memory.");
						  }
					  }
				  }
			  }

        if (compSystem.equals("linux")) {
          System.out.println("Processes?");
          int compProcesses = inStream.nextInt();
          
          if (compProcesses <= 0) {
            System.out.println("Impossible");
          }
          
          if (compProcesses > 0) {
            if (compProcesses * numUsers > 100) {
              System.out.println("Impossible");
            }
            
            if (compProcesses * numUsers >= 1) {
              if (compProcesses * numUsers <= 49) {
                int numUnits = 1;
                System.out.println("On " + compSystem + " with " + numUsers + 
                                   " users each running " + compProcesses + " processes, you will need " +
                                   numUnits + " units of memory.");
              }
            }
            
            if (compProcesses * numUsers >= 50) {
						  if (compProcesses * numUsers <= 100) {
							  int numUnits = 2;
							  System.out.println("On " + compSystem + " with " + numUsers + 
							                     " users each running " + compProcesses + " processes, you will need " +
								                   numUnits + " units of memory.");
						  }
					  }
				  }
			  }
			  
			 if (compSystem.equals("mac")) {
          System.out.println("Processes?");
          int compProcesses = inStream.nextInt();
          
          if (compProcesses <= 0) {
            System.out.println("Impossible");
          }
          
          if (compProcesses > 0) {
            if (compProcesses * numUsers > 100) {
              System.out.println("Impossible");
            }
            
            if (compProcesses * numUsers >= 1) {
              if (compProcesses * numUsers <= 25) {
                int numUnits = 1;
                System.out.println("On " + compSystem + " with " + numUsers + 
                                   " users each running " + compProcesses + " processes, you will need " +
                                   numUnits + " units of memory.");
              }
            }
            
            if (compProcesses * numUsers >= 26) {
						  if (compProcesses * numUsers <= 60) {
							  int numUnits = 2;
							  System.out.println("On " + compSystem + " with " + numUsers + 
							                     " users each running " + compProcesses + " processes, you will need " +
								                   numUnits + " units of memory.");
						  }
					  }
					
					  if (compProcesses * numUsers >= 61) {
						  if (compProcesses * numUsers <= 100) {
							  int numUnits = 3;
							  System.out.println("On " + compSystem + " with " + numUsers + 
							                     " users each running " + compProcesses + " processes, you will need " +
							                     numUnits + " units of memory.");
					  	}
					  }
				  }
			  }
			  
			  if (!compSystem.equals("windows")) {
			    if (!compSystem.equals("linux")) {
			      if (!compSystem.equals("mac")) {
			        System.out.println("Impossible");
			      }
			    }
			  }
			}
	  }
	}
}
