public class ComplexNumber {

  /* STUDENTS: You may NOT add any further instance of static variables! */
  private final MyDouble real;  // To be initialized in constructors
  private final MyDouble imag;  // To be initialized in constructors
  
  /* This constructor takes two parameters and assigns them to both private
   * final variables. 8/
  public ComplexNumber (MyDouble real, MyDouble imag) {
    this.real = real;
    this.imag = imag;
  }
  
  /* This constructor takes only one parameter and assigns it to the real part
   * however, it assigns the imaginary part to 0. */
  public ComplexNumber (MyDouble real) {
    this.real = real;
    this.imag = new MyDouble(0);
  }
  
  // This is the copy constructor.
  public ComplexNumber (ComplexNumber c) {
    this(c.real, c.imag);
  }
  
  /* STUDENTS: Put your methods here, as described in the project description. */
  
  // This method returns the value of the imaginary part.
  public MyDouble getImag() {
    return this.imag;
  }
  
  // This method adds the values of the real and imaginary parts.
  public ComplexNumber add(ComplexNumber c) {
    MyDouble realPart = new MyDouble(this.real.add(c.real));
    MyDouble imagPart = new MyDouble(this.imag.add(c.imag));
    return(new ComplexNumber(realPart, imagPart));
  }
  
  // This method subtracts the values of the real and imaginary parts.
  public ComplexNumber subtract(ComplexNumber c) {
    MyDouble realPart = new MyDouble(this.real.subtract(c.real));
    MyDouble imagPart = new MyDouble(this.imag.subtract(c.imag));
    return (new ComplexNumber(realPart, imagPart));
  }
  
  // This method multiplies the values of the real and imaginary parts.
  public ComplexNumber multiply(ComplexNumber c) {
    MyDouble real1 = new MyDouble(this.real.multiply(c.real));
    MyDouble real2 = new MyDouble(this.imag.multiply(c.imag));
    MyDouble realPart = new MyDouble(real1.subtract(real2));
    MyDouble imag1 = new MyDouble(this.real.multiply(c.imag));
    MyDouble imag2 = new MyDouble(this.imag.multiply(c.real));
    MyDouble imagPart = new MyDouble(imag1.add(imag2));
    return (new ComplexNumber(realPart, imagPart));
  }
  
  // This method divides the values of the real and imaginary parts.
  public ComplexNumber divide(ComplexNumber c) {
    ComplexNumber conj = new ComplexNumber(c.real, negate(c.imag));
    ComplexNumber denominator = new ComplexNumber(c.multiply(conj));
    MyDouble demon = new MyDouble(denominator.real);
    ComplexNumber numerator = new ComplexNumber(this.multiply(conj));
    MyDouble realPart = numerator.real.divide(denom);
    MyDouble imagPart = numerator.imag.divide(denom);
    return (new ComplexNumber(realPart, imagPart));
  }
  
  // This method multiplies c by -1.
  private MyDouble negate(MyDouble c) {
    MyDouble neg1 = new MyDouble(-1.0);
    return (c.multiply(neg1));
  }
  
  // This method returns true if the real and imaginary parts are equal.
  public boolean equals(ComplexNumber c) {
    if (this.real.equals(c.real) && this.imag.equals(c.imag))
      return true;
    else
      return false;
  }
  
  // This methods compares c to this.
  public int compareTo(ComplexNumber c) {
    MyDouble num1 = ComplexNumber.norm(this);
    MyDouble num2 = ComplexNumber.norm(c);
    int num = num1.compareTo(num2);
    
    if (num < 0)
      return -1;
    else if (num > 0)
      return 1;
    else
      return 0;
  }
  
  public static MyDouble norm(ComplexNumber c) {
    return c.real.multiply(c.real).add(c.imag.multiply(c.imag)).sqrt();
  }
  
  public String toString() {
    boolean posImag = true;
    String text;
    MyDouble zero = new MyDouble(0.0);
    
    if (imag.compareTo(zero) < 0)
      posImag = false;
    text = real.toString();
    
    if (posImag)
      text= text.concat("+");
    
    text = text.concat(imag.toString());
    text = text.concat("i");
    
    if (text.startsWith("+"))
      text = text.substring(1);
    
    return text;
  }
  
  public static ComplexNumber parseComplexNumber (String number) {
    MyDouble realValue;
    MyDouble imagValue;
    boolean negImag;
    int operIndex;
    if (number.contains("+")) {
      negImag = false;
      operIndex = number.indexOf("+");
    }
    else {
      negImag = true;
      operIndex = number.lastIndexOf("-");
    }
    
    String realPart = number.substring(0, operIndex);
    int iLoc = number.indexOf("i");
    String imagPart = number.substring(operIndex, iLoc);
    imagPart = imagPart.substring(1);
    realValue = new MyDouble(Double.parseDouble(realPart));
    imagValue = new MyDouble(Double.parseDouble(imagPart));
    
    if (negImag)
      imagValue = imagValue.multiply(new MyDouble(-1));
    
    return(new ComplexNumber(realValue, imagValue));
  }
}

