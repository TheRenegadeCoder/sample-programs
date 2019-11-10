import 'dart:html';
import 'dart:async';
import 'dart:math';

main() {
  bool runStopped = true;
  
  // listen for settings changes and validate
  querySelector("#width").onChange.listen((Event) {
    validateInputs();
  });
  querySelector("#height").onChange.listen((Event) {
    validateInputs();
  });
  querySelector("#frameRate").onChange.listen((Event) {
    validateInputs();
  });
  querySelector("#totalFrames").onChange.listen((Event) {
    validateInputs();
  });
  querySelector("#spawnRate").onChange.listen((Event) {
    validateInputs();
  });
  
  // listen for run button click  
  querySelector("#run").onClick.listen((Event) {
    disableInputs(true);
    
    // read settings
    int cols = int.parse((querySelector("#width") as InputElement).value);
    int rows = int.parse((querySelector("#height") as InputElement).value);
    bool wrap = (querySelector("#wrap") as InputElement).checked;
    int frameRate = (1 / int.parse((querySelector("#frameRate") as InputElement).value) * 1000).round();
    int totalFrames = int.parse((querySelector("#totalFrames") as InputElement).value);
    int spawnRate = int.parse((querySelector("#spawnRate") as InputElement).value);
    
    List currentBoard = [];
    List nextBoard = [];
    int frameCounter = 1;
    int aliveCount = 1;
    
    runStopped = false;
    
    Timer.periodic(Duration(milliseconds: frameRate), (timer) {
   
      // check for stop conditions
      if (frameCounter >= totalFrames || aliveCount <= 0 || runStopped) {
        disableInputs(false);
        timer.cancel();
      }
      
      // on first loop, randomly build board from spawn rate setting
      if (frameCounter == 1) {
        currentBoard = createFirstBoard(rows, cols, spawnRate);
        clearBoard();
        aliveCount = currentBoard[0];
        drawBoard(currentBoard[1]);
      } 
      // on subsequent loops, build board from previous generation
      else {
        nextBoard = createNextBoard(currentBoard[1], wrap);
        clearBoard();
        currentBoard = nextBoard;
        aliveCount = currentBoard[0];
        drawBoard(currentBoard[1]);
      }

      printStats(frameCounter, aliveCount);
      frameCounter++;
    });
  });
  
  //listen for abort button click
  querySelector("#abort").onClick.listen((Event) {
    runStopped = true;
  });
}


// start game related function
int countNeighbors(List<List<int>> board, int r, int c, bool wrap) {
  int count = 0;

  count += (getCellValue(board, (r - 1), (c - 1), wrap) == 1) ? 1 : 0;
  count += (getCellValue(board, (r    ), (c - 1), wrap) == 1) ? 1 : 0;
  count += (getCellValue(board, (r + 1), (c - 1), wrap) == 1) ? 1 : 0;
  count += (getCellValue(board, (r - 1), (c    ), wrap) == 1) ? 1 : 0;
  count += (getCellValue(board, (r + 1), (c    ), wrap) == 1) ? 1 : 0;
  count += (getCellValue(board, (r - 1), (c + 1), wrap) == 1) ? 1 : 0;
  count += (getCellValue(board, (r    ), (c + 1), wrap) == 1) ? 1 : 0;
  count += (getCellValue(board, (r + 1), (c + 1), wrap) == 1) ? 1 : 0;

  return count;
}


int getCellValue(List<List<int>> board, int r, int c, bool wrap) {
  int rows = board.length;
  int cols = board[0].length;
  int value = 0;
  
  // if wrap is enabled, check across board on overflow
  if (wrap) {
    r = (r < 0) ? (rows - 1) : r;
    c = (c < 0) ? (cols - 1) : c;
    r = (r >= rows) ? 0 : r;
    c = (c >= cols) ? 0 : c;
    value = board[r][c];
  }
  // if wrap is disabled, return 0 on overflow
  else {
    if ((r < 0) || (c < 0) || (r >= rows) || (c >= cols)) {
      value = 0;
    }
    else {
      value = board[r][c];
    }
  }
  
  return value;
}


List createFirstBoard(rows, cols, spawnRate) {
  int aliveCount = 0;
  List<List<int>> board = new List.generate(rows, (i) => new List(cols));
  var rng = new Random.secure();

  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      // if randomly generated number is within spawn rate, cell starts living
      if (rng.nextInt(100) <= spawnRate) {
        board[r][c] = 1;
        aliveCount++;
      }
      // if randomly generated number is beyond spawn rate, cell starts dead 
      else {
        board[r][c] = 0;
      }
    }
  }

  return [aliveCount, board];
}


List createNextBoard(List<List<int>> currentBoard, bool wrap) {
  int rows = currentBoard.length;
  int cols = currentBoard[0].length;
  int aliveCount = 0;
  List<List<int>> nextBoard = new List.generate(rows, (i) => new List(cols));

  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      int neighborCount = countNeighbors(currentBoard, r, c, wrap);
      // if current cell is living
      if (getCellValue(currentBoard, r, c, false) == 1) {
        // stay alive if 2 or 3 living neighbors
        if (neighborCount == 2 || neighborCount == 3) {
          nextBoard[r][c] = 1;
          aliveCount++;
        }
      // if current cell is dead
      } else {
        // birth if 3 living neighbors
        if (neighborCount == 3) {
          nextBoard[r][c] = 1;
          aliveCount++;
        }
      }
    }
  }

  return [aliveCount, nextBoard];
}
// end game related function


// start gui related function
drawBoard(List<List<int>> board) {
  TableElement tableBoard = querySelector('#board');
  int rows = board.length;
  int cols = board[0].length;

  for (int r = 0; r < rows; r++) {
    TableRowElement boardRow = tableBoard.insertRow(r);
    for (int c = 0; c < cols; c++) {
      if (board[r][c] == 1) {
        TableCellElement boardCell = boardRow.insertCell(c)
          ..text = ' '
          ..className = 'living';
      } else {
        TableCellElement boardCell = boardRow.insertCell(c)
          ..text = ' '
          ..className = 'dead';
      }
    }
  }
}


clearBoard() {
  TableElement board = querySelector('#board');
  List<TableSectionElement> tBody = board.tBodies;

  if (tBody.isNotEmpty) {
    tBody[0].remove();
  }
}


printStats(int frameNumber, int livingCells) {
  (querySelector("#statsFrame") as Element).text = frameNumber.toString();
  (querySelector("#statsLiving") as Element).text = livingCells.toString();
}


disableInputs(bool disabled) {
  (querySelector("#width") as InputElement).disabled = disabled;
  (querySelector("#height") as InputElement).disabled = disabled;
  (querySelector("#frameRate") as InputElement).disabled = disabled;
  (querySelector("#totalFrames") as InputElement).disabled = disabled;
  (querySelector("#spawnRate") as InputElement).disabled = disabled;
  (querySelector("#run") as InputElement).disabled = disabled;
}


validateInputs() {
  int width = int.parse((querySelector("#width") as InputElement).value);
  int height = int.parse((querySelector("#height") as InputElement).value);
  int frameRate = int.parse((querySelector("#frameRate") as InputElement).value);
  int totalFrames = int.parse((querySelector("#totalFrames") as InputElement).value);
  int spawnRate = int.parse((querySelector("#spawnRate") as InputElement).value);
  bool valid = true;

  if (width <= 0) {
    (querySelector("#widthError") as Element).text = "ERROR: Width must be a positive integer.";
    valid = valid && false;
  } else {
    (querySelector("#widthError") as Element).text = "";
    valid = valid && true;
  }
  
  if (height <= 0) {
    (querySelector("#heightError") as Element).text = "ERROR: Height must be a positive integer.";
    valid = valid && false;
  } else {
    (querySelector("#heightError") as Element).text = "";
    valid = valid && true;
  }

  if (frameRate <= 0) {
    (querySelector("#frameRateError") as Element).text = "ERROR: Frame rate must be a positive integer.";
    valid = valid && false;
  } else {
    (querySelector("#frameRateError") as Element).text = "";
    valid = valid && true;
  }

  if (totalFrames <= 0) {
    (querySelector("#totalFramesError") as Element).text = "ERROR: Total frames must be a positive integer.";
    valid = valid && false;
  } else {
    (querySelector("#totalFramesError") as Element).text = "";
    valid = valid && true;
  }

  if (spawnRate <= 0 || spawnRate > 100) {
    (querySelector("#spawnRateError") as Element).text = "ERROR: Spawn rate must be more than 0 and 100 or less.";
    valid = valid && false;
  } else {
    (querySelector("#spawnRateError") as Element).text = "";
    valid = valid && true;
  }

  (querySelector("#run") as InputElement).disabled = !valid;
}
// end gui related function