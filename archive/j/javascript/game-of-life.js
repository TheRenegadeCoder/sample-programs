main();

async function main() {
	let parameters = {
		dimension: 20,
		fps: 4,
		frameCount: 60,
		spawnRate: 0.3,
	};

	for (let i = 0; i < process.argv.length - 1; i++) {
		if (process.argv[i] == "--dimension") parameters.dimension = process.argv[++i];
		else if (process.argv[i] == "--fps") parameters.fps = process.argv[++i];
		else if (process.argv[i] == "--frameCount") parameters.frameCount = process.argv[++i];
		else if (process.argv[i] == "--spawnRate") parameters.spawnRate = process.argv[++i];
	}

	// Initialize a board as a lifeless square array.
	let board = new Array(parameters.dimension).fill(new Array(parameters.dimension).fill(false));

	// Load up the array with trues (live) and falses (dead).
	board = board.map((row) => row.map(() => Math.random() < parameters.spawnRate));

	for (let i = 0; i < parameters.frameCount; i++) {
		printBoard(board);

		// Mutate the board
		board = board.map((row, rowIndex) =>
			row.map((cell, colIndex) => {
				prevRowIndex = rowIndex - 1 < 0 ? parameters.dimension - 1 : rowIndex - 1;
				nextRowIndex = rowIndex + 1 > parameters.dimension - 1 ? 0 : rowIndex + 1;
				prevColIndex = colIndex - 1 < 0 ? parameters.dimension - 1 : colIndex - 1;
				nextColIndex = colIndex + 1 > parameters.dimension - 1 ? 0 : colIndex + 1;

				// Get the count of neighbors that are alive
				neighbors = [
					[prevRowIndex, prevColIndex],
					[prevRowIndex, colIndex],
					[prevRowIndex, nextColIndex],
					[rowIndex, prevColIndex],
					[rowIndex, nextColIndex],
					[nextRowIndex, prevColIndex],
					[nextRowIndex, colIndex],
					[nextRowIndex, nextColIndex],
				].reduce((sum, indices) => sum + (board[indices[0]][indices[1]] ? 1 : 0), 0);

				// Mutate the current cell
				if (cell && (neighbors < 2 || neighbors > 3)) return false;
				if (!cell && neighbors == 3) return true;
				return cell;
			})
		);

		await sleep((1 / parameters.fps) * 1000);
	}
}

function printBoard(board) {
	console.clear();
	board.forEach((row) => {
		console.log(row.reduce((prev, curr) => prev.concat(curr ? "█" : " "), ""));
	});
}

function sleep(time) {
	return new Promise((resolve) => {
		setTimeout(resolve, time);
	});
}
