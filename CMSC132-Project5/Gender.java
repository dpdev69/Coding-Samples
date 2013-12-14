/*
 * Name: Emmanuel Taylor
 * Discussion Section: Section 0202
 * Student ID Number: 111615834
 * Student Terpconnect Login ID: etaylor5
 */

/*
 * The purpose of this class is to hold the gender for both boys and girls. The 
 * class creates field variables for name and rank and passes them in. Next
 * they'll be checked to see if the name of the current class has the same name
 * as the string being passed in and the name and rank of the current object 
 * will be returned.
 */

package names;

public class Gender {
	private String name;
	private int rank;

	/*
	 * This method initializes the class and passes in both name and rank.
	 */
	public Gender(String name, int rank){
		this.name = name;
		this.rank = rank;
	}

	/*
	 * This method checks to see if the name of the current class matches the
	 * name of the string that is being passed in.
	 */
	public boolean matchName(String otherName){
		if(otherName.equals(name)){
			return true;
		} else
			return false;
	}

	/*
	 * This method returns the name of the current object that was passed in.
	 */
	public String getName(){
		return name;
	}

	/*
	 * This method returns the rank of the current object that was passed in.
	 */
	public int getRank(){
		return rank;
	}
}
