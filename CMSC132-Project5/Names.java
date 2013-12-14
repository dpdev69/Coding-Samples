/*
 * Name: Emmanuel Taylor
 * Discussion Section: Section 0202
 * Student ID Number: 111615834
 * Student Terpconnect Login ID: etaylor5
 */

/*
 * The purpose of this class is to use threads to extract information from a
 * website online that contains a list of popular baby names for certain years.
 * This program will use threads and synchronization and minor networking 
 * concepts to make sure that the correct name is matched with the correct
 * rank and year.
 */
package names;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.UnknownHostException;
import java.util.*;
import java.util.Map.Entry;

public class Names {
	/*
	 * Field data that includes a HashMap which is used to store the names and
	 * a List for the threads.
	 */
	private HashMap<Integer, Year> names;
	private List<Thread> threads;

	/*
	 * This method returns a list of the most popular names for babies of both
	 * genders to whatever time frame of startYear and the endYear.
	 */
	public void getNames(int startYear, int endYear, int numNames) {
		names = new HashMap<Integer, Year>();
		threads = new List<Thread>();

		/*
		 * This for loop is used to iterate through years starting from the
		 * startYear and ending when index is equal to the endYear.
		 */
		for(int index = startYear; index <= endYear; index++){
			Thread temporary = new Thread(new threadClass(index, numNames));
			temporary.start();
			threads.add(temporary);
		}

		/*
		 * An enhanced for loop that joints each thread and throws an 
		 * InterruptedException.
		 */
		for(Thread thread: threads){ 
			try {
				thread.join(); 
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

	/*
	 * This method is used to return the name of the baby girl name in whatever
	 * year and rank is asked for. The method will check for the year located
	 * in the HashMap and then checks to see if the rank exists in the class
	 * named Year. The name will be returned if both checks fail.
	 */
	public String getGirlName(int year, int rank) {
		if(!(names.containsKey(year)) || names.get(year).getListGirls().size() 
				< rank){
			return null;
		} else
			return names.get(year).getListGirls().get(rank - 1).getName();
	}

	/*
	 * This method is used to return the name of the baby boy name in whatever
	 * year and rank is asked for. The method will check for the year located 
	 * in the HashMap and then checks to see if the rank exists in the class
	 * named Year. The name will be returned in both checks fail.
	 */
	public String getBoyName(int year, int rank) {
		if(!(names.containsKey(year)) || names.get(year).getListBoys().size() 
				< rank){
			return null;
		} else
			return names.get(year).getListBoys().get(rank - 1).getName();
	}

	/*
	 * The method returns the rank of a girl's name based on the year that is 
	 * given. First, the method will check to see if the year exists. It will
	 * then iterate through the list of girls names for the year, and will then
	 * return the rank of the name in the year. -1 will be returned if the name
	 * isn't in the year.
	 */
	public int getGirlRank(int year, String name) {
		if(!(names.containsKey(year))){ 
			return -1;
		} else {
			List<Gender> list = names.get(year).getListGirls();
			for(Gender gender: list){
				if(gender.matchName(name)){
					return gender.getRank();
				}
			}
		}
		return -1;
	}

	/*
	 * The method returns the rank of the boy's name based on the year that is
	 * given. First, the method will check to see if the year exists. It will
	 * then iterate through the list of boys names for a the year, and will
	 * then return the rank of the name in the year. -1 will be returned if the
	 * name isn't in the year.
	 */
	public int getBoyRank(int year, String name) {
		if(!(names.containsKey(year))){
			return -1;
		} else {
			List<Gender> list = names.get(year).getListBoys();
			for(Gender gender: list){
				if(gender.matchName(name)){
					return gender.getRank();
				}
			}
		}
		return -1;
	}

	/*
	 * This is an inner class that creates a thread with the method that 
	 * retrieves names in each year that gets passed in.
	 */
	private class threadClass implements Runnable {
		//Instance/Field data
		int year;
		int numNames;
		Year current = new Year();

		//Constructor
		public threadClass(int year, int num){
			this.year = year;
			this.numNames = num;
		}

		/*
		 * (non-Javadoc)
		 * @see java.lang.Runnable#run()
		 * This method creats a url to the SSA website and then opens a 
		 * connection to the URL. A connection for the output will be set and a
		 * request will be sent to the URL. The inputLine will get the line of
		 * the current rank passed in as the count. The HTML for the girls and
		 * boys names will be parsed. Empty white space will be removed and 
		 * adds it to a string. After all of this is completed, it will move to
		 * the next rank.
		 */
		public void run() {
			URL ssa;
			try {
				ssa = new URL("http://www.ssa.gov/cgi-bin/popularnames.cgi");
				URLConnection yc = ssa.openConnection();
				yc.setDoOutput(true);
				OutputStream outputs = yc.getOutputStream();
				OutputStreamWriter writer = new OutputStreamWriter(outputs);
				writer.write("year=" + year + "&top=" + numNames);
				writer.flush();
				BufferedReader in = new BufferedReader(new InputStreamReader(
						yc.getInputStream()));
				String inputLine;
				int count = 1;
				inputLine = in.readLine();
				while ((inputLine = in.readLine()) != null && 
						count <= numNames) {
					if(inputLine.contains("<td>" + count + "</td>")){
						String[] stringValue = inputLine.split("<td>");
						String value = "";
						for(String s: stringValue){
							value += s.trim(); 
						}
						stringValue = value.split("</td>");
						current.addListBoy(new Gender(stringValue[1], count));	
						current.addListGirl(new Gender(stringValue[2], count));
						count++;
					}
				}
				in.close();
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}

			/*
			 * This is used to synchronize the use of the list. This adds the 
			 * year with the lists of both gender's names.
			 */
			synchronized (names){
				add(year, current); 
			}
		}

		public void add(int year, Year yearNames) {
			names.put(year, yearNames);
		}
	}
}
