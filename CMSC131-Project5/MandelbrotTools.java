public class MandelbrotTools {

  /* STUDENTS: Put your isBig" and "divergence" methods here. */
  
  public static boolean isBig(ComplexNumber c) {
    MyDouble real = new MyDouble(c.getReal());
    MyDouble imag = new MyDouble(c.getImag());
    real = real.multiply(real);
    imag = imag.multiply(imag);
    MyDouble value = new MyDouble (real.add(imag));
    
    if (value.compareTo(Controller.DIVERGENCE_BOUNDARY) == 1) {
      return true;
    }
    else {
      return false;
    }
  }
  
  public static int divergence(ComplexNumber c) {
    int index = 0;
    ComplexNumber cn = new ComplexNumber(c);
    
    do {
      if (MandelbrotTools.isBig(cn))
        return index;
      cn = cn.multiply(cn).add(c);
      index++;
    }
    while (index < Controller.LIMIT);
      return -1;
  }
  
  /* This method selects a non-black color for a point which DIVERGED when tested with the Mandelbrot
   * recurrence, based on how many terms in the sequence were computer before the terms got "too big".
   *
   * The parameter represents the index of the term in the sequence which was first to be "too big".
   * This value could be anything from 0 to Controller.LIMIT. The return value is not the Color to be used
   * to color in the point.
   *
   * STUDENTS: IF you want to have some fun, write code for the else-if cluase below which says
   * "modify this block to create your own color scheme". When someone runs the programs and selects
   * "Student Color Scheme", the code you have written below will determine the colors.
   */
  
  public static Color getColor(int divergence) {
    Color returnValue;
    
    if (Controller.colorScheme == Controller.RED_AND_WHITE_BANDS) {
      return value = (divergence % 2 == 0)? Color.WHITE : Color.RED;
    }
    
    else if (Controller.colorScheme == Controller.CRAZY_COLORS) {
      int value = divergence * 2;
      int redAmount = (value % 5) * (255/5);
      int greenAmount = (value % 7) * (255/7);
      int blueAmount = (value % 9) * (255/9);
      returnValue = new Color(redAmount, greenAmount, blueAmount);
    }
    
    else if (Controller.colorScheme == Controller.STUDENT_DEFINED) {
      /******************************************************************
       * Modify this block to create your own color scheme!             *
       ******************************************************************/
      int value = divergence * 4;
      int redAmount = (value % 7) * (255/7);
      int greenAmount = (value % 9) * (255/9);
      int blueAmount = (value % 7) * (255/7);
      returnValue = new Color(redAmount, greenAmount, blueAmount);
      // take this out and return something useful.
    }
    
    else
      throw new RuntimeException("Unknown color scheme selected!");
    
    return returnValue;
  }
}
