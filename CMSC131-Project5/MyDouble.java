/**
 * MyDouble objects represent floating point values.
 * The MyDouble is immutable.
 *
 * @author Fawzi Emad & Jan Plane
 */

public class MyDouble {
  private double doubleValue;
  private final static double EPSILON = .00001;
  
  /* We don't want students calling toString anywhere except while writing
   * their own ComplexNumber toString method. (Otherwise, they can convert
   * the String to type double and bypass the "fun",) */
  protected static boolean toStringUsed = false;  // set to true in toString.
                                                  // JUnit tests will make use of this to
                                                  // cause failures if student is 
                                                  // illegally using toString
  
  /**
   * Copy Constructor. Initializes the new MyDouble object so that it represents
   * the same value as that of the parameter.
   * @param passedMyDouble is existing MyDouble object that is being copied
   */
  public MyDouble(MyDouble passedMyDouble) {
    doubleValue = passedMyDouble.doubleValue;
  }
  
  /**
   * Returns the sum of the current object and the parameter.
   * Note: This method does not modify the current object.
   * @param passedVal the value that serves as the second operand for the addition
   * @return a MyDouble object that represents the sum of the current object and
   * the parameter
   */
  public MyDouble add(MyDouble passedVal) {
    return new MyDouble(this.doubleValue + passedVal.doubleValue);
  }
  
  /**
   * Returns the difference of the current object and the parameter.
   * Note: This method does not modify the current object.
   * @param passedVal the value to be subtracted
   * @return a MyDouble object that represents the current object minus the
   * parameter.
   */
  public MyDouble subtract(MyDouble passedVal) {
    return new MyDouble(this.doubleValue - passedVal.dougbleValue);
  }

/**
	 * Returns the product of the current object and the parameter.
	 * Note:  This method does not modify the current object.
	 * @param passedVal the value that serves as the second operand for the multiplication
	 * @return the product of the current object and the parameter
	 */
	public MyDouble multiply(MyDouble passedVal) {
		return new MyDouble(this.doubleValue * passedVal.doubleValue);
		
	}
	
	/**
	 * Returns the quotient obtained when dividing the current object by the parameter.
	 * Note:  This method does not modify the current object. 
	 * @param passedVal the value that serves as the divisor
	 * @return the result of dividing the current object by the parameter
	 */
	public MyDouble divide(MyDouble passedVal) {
		return new MyDouble(this.doubleValue / passedVal.doubleValue);
	}
	
	/**
	 * Returns a MyDouble representing the square root of the current object.
	 * Note:  This method does not modify the current object.
	 * @return the square root of the current object
	 */
	public MyDouble sqrt() {
		return new MyDouble(Math.sqrt(this.doubleValue));
	}
	
	/**
	 * Compares the current object to the parameter.
	 * @param passedVal the object being compared with the current object
	 * @return a negative value if the current object is less than the parameter,
	 * zero if the current object equals the parameter, a positive value if the 
	 * current object is larger than the parameter.  NOTE:  Due to the lack
	 * of precision in comparing floating point values, in cases where the two
	 * values are NEARLY equal, this method will return 0.
	 */
	public int compareTo(MyDouble passedVal) {
		if (Math.abs(this.doubleValue - passedVal.doubleValue) < EPSILON)
			return 0;
		else if (this.doubleValue < passedVal.doubleValue)
			return -1;
		else
			return 1;
	}  

/**
	 * Checks if the current object is equal to the parameter.  
	 * 
	 * @param passedVal the object being compared for equality with the current object
	 * @return true if the current object is equal to the parameter, false
	 * otherwise.  NOTE:  Due to the lack
	 * of precision in comparing floating point values, in cases where the two
	 * values are NEARLY equal, this method will return true.
	 */
	public boolean equals(MyDouble passedVal) {
		if (passedVal == null){
			return false;
		}
		return Math.abs(this.doubleValue - passedVal.doubleValue) < EPSILON;
	}
	
	/**
	 * Returns the absolute value of the current object.
	 * @return a MyDouble representing the absolute value of the current object.
	 */
	public MyDouble abs() {
		return new MyDouble(Math.abs(this.doubleValue));
	}

	/**
	 * YOU MAY NOT CALL THIS METHOD EXCEPT WHILE YOU ARE IMPLEMENTING
	 * THE toString METHOD OF THE COMPLEX NUMBER CLASS!!
	 * 
	 * Returns a String representation of the current object.
	 */
	public String toString() {
		toStringUsed = true;
		return new Double(this.doubleValue).toString();
	}
}
