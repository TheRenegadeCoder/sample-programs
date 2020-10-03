/**
 * A NASA explorer probe has landed on Mars. The landing took place in a rectangular area, in which the probe can navigate using a web interface. 
 * The position of the probe is represented by its x and y axis, and the direction in which it is pointed by the initial letter, being as valid competent:
 * L - Left, R - Right, U - Up, D - Down. The probe accepts three commands: RL - rotate left 90 degrees, RR - rotate 90 degrees to the right,
 * M - move. For each command, a probe moves one position in the direction that your face is pointed.
 */
 
 const quadrant = [
    ['0,4', '1,4', '2,4', '3,4', '4,4'],
    ['0,3', '1,3', '2,3', '3,3', '4,3'],
    ['0,2', '1,2', '2,2', '3,2', '4,2'],
    ['0,1', '1,1', '2,1', '3,1', '4,1'],
    ['0,0', '1,0', '2,0', '3,0', '4,0']
].reverse();

let positionProbe = quadrant[0][0];
let operation = +1;
let direction = 'R';

// inicializer in quadrant (x = 0, y = 0), what translates as the lowest house on the left; it also starts with the face to the right.
function startingPosition() {
    positionProbe = quadrant[0][0];
    operation = +1;
    direction = 'R';
}

// The probe accepts three commands: RL - rotate left 90 degrees, RR - rotate 90 degrees to the right, M - move.
function moveProbe(movement) {
    let movements = movement.movements;
    let statusMovement;

    movements.forEach(movement => {
        switch (movement) {
            case 'RL':
                rotateLeft();
                break;
            case 'RR':
                rotateRight();
                break;
            case 'M':
                statusMovement = moveProbeDirection();
                break;
            default:
                break;
        }
    });

    if(statusMovement !== "Error") {
        return {
            "[x][y]": positionProbe
        };
    } else {
        return {
            "erro": "An invalid movement was detected," +
            "unfortunately the probe does not yet have the ability to traverse dimensions"
        };
    }
}

// Gets the current position of the Probe
function getCurrentPosition() {
    return {
        "[x][y]": startingPosition,
        "Direction": direction
    };
}

// Gets the index of the probe position in the quadrant
function getMatrixIndex(position) {
    let line, column = -1;
    let index;

    for(let i = 0; i < quadrant.length; i++) {
        index = quadrant[i].findIndex(element => element == position);
        if(index != -1) {
            line = i;
            column = index;
        }
    }

    return [line, column];
}

// RL - rotate left 90 degrees
function rotateLeft() {
    switch (direction) {
        case 'L':
            operation = -1;
            direction = 'D';    
            break;
        case 'D':
            operation = +1;
            direction = 'R';
            break;
        case 'R':
            operation = +1;
            direction = 'U';    
            break;
        case 'U':
            operation = -1;
            direction = 'L';    
            break;
        default:
            break;
    }
}

// RR - rotate right 90 degrees
function rotateRight() {
    switch (direction) {
        case 'L':
            operation = +1;
            direction = 'U';    
            break;
        case 'D':
            operation = -1;
            direction = 'L';
            break;
        case 'R':
            operation = -1;
            direction = 'D';
            break;
        case 'U':
            operation = +1;
            direction = 'R';
            break;
        default:
            break;
    }
}

/**
 * Move a probe in the direction it is directing.
 * Consider that an upward movement is the same as saying (x + 1, y), and a rightward movement is the same as (x, y + 1).
 */
function moveProbeDirection() {
    let position = getMatrixIndex(positionProbe);

    if(direction == 'D' || direction == 'U'){
        let operationDU = quadrant[position[0] + operation][position[1]];

        if(typeof operationDU == "undefined"){
            return "Error";
        }
        
        positionProbe = operationDU;
        return "Sucess";

    } else {
        let operationLR = quadrant[position[0]][position[1] + operation];

        if(typeof operationLR == "undefined"){
            return "Error";
        }

        positionProbe = operationLR;
        return "Sucess";
    }
}

