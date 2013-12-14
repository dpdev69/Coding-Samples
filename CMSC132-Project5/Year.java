/*
 * Name: Emmanuel Taylor
 * Discussion Section: Section 0202
 * Student ID Number: 111615834
 * Student Terpconnect Login ID: etaylor5
 */

/*
 * The purpose of this class is to hold the year for both boys and girls. The 
 * class creates two List objects for both boys and girls and adds a gender to
 * each. After this is done, both lists will be returned to be used in the 
 * other classes.
 */
package names;

public class Year{
	private List<Gender> boyList;
	private List<Gender> girlList;
	public Year(){
		boyList = new List<Gender>();
		girlList = new List<Gender>();
	}

	/*
	 * This method adds a gender to the list of boys names. First, the method
	 * checks to see if the vertex exists. If not, an IllegalArgumentException
	 * will be thrown else the boy is added as a male.
	 */
	public void addListBoy(Gender male) throws IllegalArgumentException{
		if(boyList.contains(male)){	//Checks if the vertex exists
			throw new IllegalArgumentException();
		} else
			boyList.add(male);
	}
	
	/*
	 * This method adds a gender to the list of girls names. First the method
	 * checks to see if the vertex exists. If not, an IllegalArgumentException
	 * will be thrown else the girl will be added as a female gender.
	 */
	public void addListGirl(Gender female) throws IllegalArgumentException{
		if(girlList.contains(female)){	//Checks if the vertex exists
			throw new IllegalArgumentException();
		} else
			girlList.add(female);
	}

	/*
	 * These two methods are used to return the list of both the boys names and
	 * the girls names.
	 */
	public List<Gender> getListBoys(){
		return boyList;
	}
	
	public List<Gender> getListGirls(){
		return girlList;
	}
}
