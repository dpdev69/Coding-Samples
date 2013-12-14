/*
 * Name: Emmanuel Taylor
 * Discussion Section: Section 0202
 * Student ID Number: 111615834
 * Student Terpconnect Login ID: etaylor5
 */

/*
 * The purpose of this class is to execute different methods that are required
 * for the game Othello such as restarting the game and interchanging between
 * different turns for black or white pieces. This method also creates a board
 * object and can return the number of colored pieces on the board. This method
 * is mostly used to execute commands that are required to move the pieces to
 * a different spot on the board.
 */
package othello;

import java.util.NoSuchElementException;
import java.lang.IllegalArgumentException;

public class Othello {

	/*
	 * Three instance variables for the board, the turn, and the 
	 * number of black and white pieces.
	 */
	Piece[][] board;
	Piece turn;
	int blackPieces, whitePieces;

	/*
	 * These variables are used to store values for the corners of each trap.
	 */
	int trapRightRow = 8;
	int trapRightCol = 8;
	int trapLeftRow = 8;
	int trapLeftCol = 8;
	int trapDownRow = 8;
	int trapDownCol = 8;
	int trapUpRow = 8;
	int trapUpCol = 8;
	int leftUpRow = 8;
	int leftUpCol = 8;
	int leftDownRow = 8;
	int leftDownCol = 8;
	int rightUpRow = 8;
	int rightUpCol = 8;
	int rightDownRow = 8;
	int rightDownCol = 8;

	/*
	 * Constructor in which an othelloBoard is created and filled
	 * with empty game pieces. Sets the board equal to the othelloBoard
	 * in the constructor and sets the default turn to the black piece.
	 */
	public Othello() {
		Piece[][] othelloBoard = new Piece[8][8];
		for(int row = 0; row < 8; row++){
			for(int col = 0; col < 8; col++){
				othelloBoard[row][col] = Piece.NONE;
			}
		}

		this.board = othelloBoard;
		this.turn = Piece.BLACK;
	}

	/*
	 * Copy constructor to set otherObj.board equal to the board
	 * created in the constructor.
	 */
	public Othello(Othello otherObj) {
		for(int row = 0; row < 8; row++){
			for(int col = 0; col < 8; col++){
				this.board[row][col] = otherObj.board[row][col];
			}
		}

		Piece copy = otherObj.turn;
		this.turn = copy;
	}

	/*
	 * Method that sets turns to pieces depending on their color and
	 * returns the board to it's default state with two white and black
	 * pieces at the center of the board.
	 */
	public void restart(Piece color) throws IllegalArgumentException {
		if(color == Piece.WHITE){
			this.turn = Piece.WHITE;
		}else if(color == Piece.BLACK){
			this.turn = Piece.BLACK;
		}else{
			throw new IllegalArgumentException();
		}

		Piece[][] othelloBoard = new Piece[8][8];
		for(int i = 0; i < 8; i++){
			for(int j = 0; j < 8; j++){
				othelloBoard[i][j] = Piece.NONE;
			}
		}

		othelloBoard[3][4] = Piece.BLACK;
		othelloBoard[4][3] = Piece.BLACK;
		othelloBoard[3][3] = Piece.WHITE;
		othelloBoard[4][4] = Piece.WHITE;

		this.board = othelloBoard;
	}

	/*
	 * Method that sets turns to pieces and throws an IllegalArgumentException
	 */
	public void setTurn(Piece color) throws IllegalArgumentException {
		if(color == Piece.BLACK){
			this.turn = Piece.WHITE;
		}else if(color == Piece.WHITE){
			this.turn = Piece.BLACK;
		}else{
			throw new IllegalArgumentException();
		}
	}

	/*
	 * This method is used to return the value of turn whether it is
	 * black or white. If it is neither, it returns none.
	 */
	public Piece getTurn() {
		if(this.turn == Piece.BLACK){
			return Piece.BLACK;
		}else if(this.turn == Piece.WHITE){
			return Piece.WHITE;
		}else{
			return Piece.NONE;
		}
	}

	/*
	 * Method that sets where pieces are located on the board, the method
	 * will throw a NoSuchElementException if the user tries to set a piece
	 * that is out of the board.
	 */
	public void setEntry(Piece color, int row, int col)
			throws NoSuchElementException {
		if((row < 0) || (row > 7) || (col < 0) || (col > 7)){
			throw new NoSuchElementException();
		}else{
			this.board[row][col] = color;
		}
	}

	/*
	 * This method returns the row and column of the pieces that are on
	 * the board.
	 */
	public Piece getEntry(int row, int col) throws NoSuchElementException {
		Piece piece;
		if((row > 7) || (row < 0) || (col > 7) || (col < 0)){ 
			throw new NoSuchElementException();
		}else{
			piece = this.board[row][col];
			return piece;
		}
	}

	/*
	 * This method checks directions from up, down, left, right and diagonally
	 * to determine whether the place the piece is trying to move is valid.
	 */
	public boolean validMove(Piece color, int row, int col) {
		int rowUpperBound = 7 - row;
		int colUpperBound = 7 - col;
		int trapUp = 0;
		int trapDown = 0;
		int trapLeft = 0;
		int trapRight = 0;
		int trapUpRight = 0;
		int trapUpLeft = 0;
		int trapDownRight = 0;
		int trapDownLeft = 0;
		int findOpponentUp = 0;
		int findOpponentDown = 0;
		int findOpponentLeft = 0;
		int findOpponentRight = 0;
		int findOpponentUpRight = 0;
		int findOpponentUpLeft = 0;
		int findOpponentDownRight = 0;
		int findOpponentDownLeft = 0;

		if((row < 0) || (row > 7) || (col < 0) || (col > 7)){
			return false;
		}else if(board[row][col] != Piece.NONE){
			return false;
		}else{
			
			/*
			 * Checks vertically upward.
			 */
			for(int i = 1; i <= row; i++){
				if(board[row - i][col] != color && board[row - i][col] 
						!= Piece.NONE){
					findOpponentUp = 1;
				}else if(board[row - i][col] == color){
					if(findOpponentUp !=0){
						trapUp = 1;
						trapUpRow = row - i;
						trapUpCol = col;
					}else{
						break;
					}
				}else if(board[row - i][col] == Piece.NONE){
					break;
				}
			}

			/*
			 * Checks vertically downward.
			 */
			for(int i = 1; i <= rowUpperBound; i++){
				if(board[row + i][col] != color && board[row + i][col] 
						!= Piece.NONE){
					findOpponentDown = 1;
				}else if(board[row + i][col] == color){
					if(findOpponentDown !=0){
						trapDown = 1;
						trapDownRow = row + i;
						trapDownCol = col;
					}else{
						break;
					}
				}else if(board[row + i][col] == Piece.NONE){
					break;
				}
			}

			/*
			 * Checks horizontally right.
			 */
			for(int i = 1; i <= colUpperBound; i++){
				if(board[row][col + i] != color && board[row][col + i] 
						!= Piece.NONE){
					findOpponentRight = 1;
				}else if(board[row][col + i] == color){
					if(findOpponentRight !=0){
						trapRight = 1;
						trapRightRow = row;
						trapRightCol = col + i;
					}else{
						break;
					}
				}else if(board[row][col + i] == Piece.NONE){
					break;
				}
			}

			/*
			 * Checks horizontally left.
			 */
			for(int i = 1; i <= col; i++){
				if(board[row][col - i] != color && board[row][col - i] 
						!= Piece.NONE){
					findOpponentLeft = 1;
				}else if(board[row][col - i] == color){
					if(findOpponentLeft !=0){
						trapLeft = 1;
						trapLeftRow = row;
						trapLeftCol = col - i;
					}else{
						break;
					}
				}else if(board[row][col - i] == Piece.NONE){
					break;
				}
			}

			/*
			 * Checks diagonally upward and right.
			 */
			for(int i = 1; i <= row && i <= colUpperBound; i++){
				if(board[row - i][col + i] != color && board[row - i][col + i] 
						!= Piece.NONE){
					findOpponentUpRight = 1;
				}else if(board[row - i][col + i] == color){
					if(findOpponentUpRight !=0){
						trapUpRight = 1;
						rightUpRow = row - i;
						rightUpCol = col + i;
					}else{
						break;
					}
				}else if(board[row - i][col + i] == Piece.NONE){
					break;
				}
			}

			/*
			 * Checks diagonally upward and left.
			 */
			for(int r = 1; r<=row && r <=col; r++){
				if(board[row-r][col-r] != color && board[row-r][col-r] 
						!= Piece.NONE){
					findOpponentUpLeft = 1;
				}else if(board[row-r][col-r] == color){
					if(findOpponentUpLeft !=0){
						trapUpLeft = 1;
						leftUpRow = row-r;
						leftUpCol = col-r;
					}else{
						break;
					}
				}else if(board[row-r][col-r] == Piece.NONE){
					break;
				}
			}

			/*
			 * Checks diagonally downward and left.
			 */
			for(int i = 1; i <= rowUpperBound && i <= col; i++){
				if(board[row + i][col - i] != color && board[row + i][col - i] 
						!= Piece.NONE){
					findOpponentDownLeft = 1;
				}else if(board[row + i][col - i] == color){
					if(findOpponentDownLeft !=0){
						trapDownLeft = 1;
						leftDownRow = row + i;
						leftDownCol = col - i;
					}else{
						break;
					}
				}else if(board[row + i][col - i] == Piece.NONE){
					break;
				}
			}

			/*
			 * Checks diagonally downward and right.
			 */
			for(int i = 1; i <= rowUpperBound && i <= colUpperBound; i++){
				if(board[row + i][col + i] != color && board[row + i][col + i] 
						!= Piece.NONE){
					findOpponentDownRight = 1;
				}else if(board[row + i][col + i] == color){
					if(findOpponentDownRight !=0){
						trapDownRight = 1;
						rightDownRow = row + i;
						rightDownCol = col + i;
					}else{
						break;
					}
				}else if(board[row + i][col + i] == Piece.NONE){
					break;
				}
			}
		}
		if(trapUp !=0 || trapDown!=0 || trapLeft !=0 || trapRight !=0 || 
				trapDownRight !=0 || trapDownLeft !=0 || trapUpLeft!=0 || 
				trapUpRight !=0){
			return true;
		}else{
			return false;
		}
	}

	/*
	 * Method that controls movements on the actual game board.
	 */
	public void move(int row, int col) {
		Piece color = this.getTurn();
		if(validMove(color, row, col)){
			validMove(color, row, col);
			board[row][col] = color;

			if(trapUpRow != 8){
				for(int i = row; i >= trapUpRow; i--){
					board[i][col] = color;
				}
			}

			if(trapDownRow != 8){
				for(int i = row; i <= trapDownRow; i++){
					board[i][col] = color;
				}
			}

			if(trapLeftRow != 8){
				for(int j = col; j >= trapLeftCol; j--){
					board[row][j] = color;
				}
			}

			if(trapRightRow != 8){
				for(int j = col; j <= trapRightCol; j++){
					board[row][j] = color;
				}
			}

			if(rightUpCol != 8){
				for(int j = 1; (j <= rightUpCol - col) && (j <= row 
						- rightUpRow); j++){
					board[row - j][col + j] = color;
				}
			}

			if(leftUpCol !=8){
				for(int j = 1; (j <= row - leftUpCol) && (j >= col 
						- leftUpCol); j++){
					board[row - j][col - j] = color;
				}
			}

			if(leftDownCol != 8){
				for(int j = 1; (j <= col - leftDownCol) && (j <= leftDownRow
						- row); j++){
					board[row + j][col - j] = color;
				}
			}

			if(rightDownCol != 8){
				for(int j = 1; (j <= rightDownCol - col) && (j <= rightDownRow 
						- row); j++){
					board[row + j][col + j] = color;
				}
			}

			/*
			 * Rests the end pieces of each row and column back to 8.
			 */
			trapLeftRow = 8;
			trapLeftCol = 8;
			trapRightRow = 8;
			trapRightCol = 8;
			trapUpRow = 8;
			trapUpCol = 8;
			trapDownRow = 8;
			trapDownCol = 8;
			rightUpRow = 8;
			rightUpCol = 8;
			leftUpRow = 8;
			leftUpCol = 8;
			leftDownRow = 8;
			leftDownCol = 8;
			rightDownRow = 8;
			rightDownCol = 8;

			if(color == Piece.BLACK){
				turn = Piece.WHITE;
			}else{
				turn = Piece.BLACK;
			}
		}
	}

	/*
	 * Methods that controls moves and moves them in the direction they are 
	 * at by calling the validMove method to determine whether it is valid.
	 */
	public void move(Piece color, int row, int col) {
		if(validMove(color,row,col)){
			validMove(color,row,col);
			board[row][col] = color;

			if(trapUpRow != 8){
				for(int i = row; i >= trapUpRow; i--){
					board[i][col] = color;
				}
			}

			if(trapDownRow != 8){
				for(int i = row; i <= trapDownRow; i++){
					board[i][col] = color;
				}
			}

			if(trapLeftRow != 8){
				for(int j = col; j >= trapLeftCol; j--){
					board[row][j] = color;
				}
			}

			if(trapRightRow != 8){
				for(int j = col; j <= trapRightCol; j++){
					board[row][j] = color;
				}
			}

			if(rightUpCol != 8){
				for(int j = 1; (j <= rightUpCol - col) && (j <= row
						- rightUpRow); j++){
					board[row - j][col + j] = color;
				}
			}

			if(leftUpCol != 8){
				for(int j = 1; (j <= row - leftUpRow) && (j >= col 
						- leftUpCol); j++){
					board[row - j][col - j] = color;
				}
			}

			if(leftDownCol != 8){
				for(int j = 1; (j <= col - leftDownCol) && (j <= leftDownRow 
						- row); j++){
					board[row + j][col - j] = color;
				}
			}

			if(rightDownCol != 8){
				for(int j = 1; (j <= rightDownCol - col) && (j <= rightDownRow 
						- row); j++){
					board[row + j][col + j] = color;
				}
			}

			/*
			 * Rests the end pieces of each row and column back to 8.
			 */
			trapLeftRow = 8;
			trapLeftCol = 8;
			trapRightRow = 8;
			trapRightCol = 8;
			trapUpRow = 8;
			trapUpCol = 8;
			trapDownRow = 8;
			trapDownCol = 8;
			rightUpRow = 8;
			rightUpCol = 8;
			leftUpRow = 8;
			leftUpCol = 8;
			leftDownRow = 8;
			leftDownCol = 8;
			rightDownRow = 8;
			rightDownCol = 8;

			if(color == Piece.BLACK){
				turn = Piece.WHITE;
			}else{
				turn = Piece.BLACK;
			}
		}
	}

	/*
	 * (non-Javadoc)
	 * @see java.lang.Object#toString()
	 * Method that returns the board as a string to check which pieces are
	 * where and which pieces are moving where.
	 */
	public String toString() {
		String var = " ";
		var += " 0 1 2 3 4 5 6 7\n";

		for(int row = 0; row < board.length; row++){
			var += row;
			for(int col = 0; col < board.length; col++){
				if(board[row][col] == Piece.NONE)
					var += " -";
				if(board[row][col] == Piece.BLACK)
					var += " B";
				if(board[row][col] == Piece.WHITE)
					var += " W";
			}

			var += "\n";
		}

		return var;
	}

	/*
	 * Method that returns the count of the number of pieces that 
	 * are on the game board.
	 */
	public int count(Piece color) {
		int count = 0;
		for(int i = 0; i < 8; i++){
			for(int j = 0; j < 8; j++){
				if(board[i][j] == color){
					count++;
				}
			}
		}
		return count;
	}

	/*
	 * Method that determines if there are more black pieces on the game board
	 * than white pieces.
	 */
	public boolean moreBlackPieces() {
		if(whitePieces > blackPieces){
			return false;
		}
		else{
			return true;
		}
	}

	/*
	 * Method that determines if there are more white pieces on the game board
	 * than black pieces.
	 */
	public boolean moreWhitePieces() {
		if(blackPieces > whitePieces){
			return false;
		}
		else{
			return true;
		}
	}

	/*
	 * Method that determines if the number of white pieces and black pieces
	 * on the game board are equal.
	 */
	public boolean equalPieces() {
		if(blackPieces == whitePieces){
			return true;
		}
		else{
			return false;
		}
	}
}
