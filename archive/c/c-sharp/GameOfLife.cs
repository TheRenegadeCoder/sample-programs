using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace GameOfLife
{
    class Program
    {
        private static async Task Main(string[] args)
        {
            var parameters = ParseParametersFromConsoleArguments(args);

            var life = PopulateInitialState(parameters);
            for (int i = 0; i < parameters.NumberOfFrames; ++i)
            {
                PrintLife(life);

                life = NextIteration(life);

                await Task.Delay(1000 / parameters.FrameRate);
            }
        }

        private static StateOfCell[,] PopulateInitialState(Parameters parameters)
        {
            Random random = new Random();

            var initialState = new StateOfCell[parameters.Width, parameters.Width];
            for (int row = 0; row < parameters.Width; row++)
            {
                for (int column = 0; column < parameters.Width; column++)
                {
                    initialState[row, column] = (decimal)random.NextDouble() <= parameters.SpawnRate ? 
                        StateOfCell.Alive : StateOfCell.Dead;
                }
            }
            return initialState;
        }

        private static StateOfCell[,] NextIteration(StateOfCell[,] currentStateOfLife)
        {
            var dimension = currentStateOfLife.GetLength(0);

            var result = new StateOfCell[dimension,dimension];

            for (int row = 0; row < dimension; row++)
            {
                for (int column = 0; column < dimension; column++)
                {
                    var prevRow = row == 0 ? dimension - 1 : row - 1;
                    var nextRow = row == dimension - 1 ? 0 : row + 1;
                    var prevColumn = column == 0 ? dimension - 1 : column - 1;
                    var nextColumn = column == dimension - 1 ? 0 : column + 1;

                    var neighbours = new List<StateOfCell>
                    { 
                        currentStateOfLife[prevRow, prevColumn],
                        currentStateOfLife[prevRow, column],
                        currentStateOfLife[prevRow, nextColumn],
                        currentStateOfLife[row, prevColumn],
                        currentStateOfLife[row, nextColumn],
                        currentStateOfLife[nextRow, prevColumn],
                        currentStateOfLife[nextRow, column],
                        currentStateOfLife[nextRow, nextColumn] 
                    };

                    result[row, column] = GetNewState(currentStateOfLife[row, column], neighbours);
                }
            }
            return result;
        }

        private static StateOfCell GetNewState(StateOfCell currentState, List<StateOfCell> neighbours)
        {
            var amountOfAliveNeighbours = neighbours.Count(n => n == StateOfCell.Alive);

            if (currentState == StateOfCell.Dead && amountOfAliveNeighbours == 3)
                return StateOfCell.Alive;
            if (currentState == StateOfCell.Alive && (amountOfAliveNeighbours == 2 || amountOfAliveNeighbours == 3))
                return StateOfCell.Alive;
            return StateOfCell.Dead;
        }

        private static Parameters ParseParametersFromConsoleArguments(string[] args)
        {
            int? width = null; 
            int? frameRate = null; 
            int? numberOfFrames = null; 
            decimal? spawnRate = null;

            for (int i = 0; i < args.Length; ++i)
            {
                switch (args[i])
                {
                    case "-width":
                        width = int.Parse(args[++i]);
                    break;
                    case "-frameRate":
                        frameRate = int.Parse(args[++i]);
                    break;
                    case "-numberOfFrames":
                        numberOfFrames = int.Parse(args[++i]);
                    break;
                    case "-spawnRate":
                        spawnRate = decimal.Parse(args[++i]);
                    break;
                }
            }

            return new Parameters(width, frameRate, numberOfFrames, spawnRate);
        } 

        private static void PrintLife(StateOfCell[,] life)
        {
            Console.Clear();

            var dimension = life.GetLength(0);
            for (int row = 0; row < dimension; row++)
            {
                for (int column = 0; column < dimension; column++)
                {
                    Console.Write(life[row, column] == StateOfCell.Alive ? "*" : " ");
                }
                Console.Write(Environment.NewLine);
            }
        }
    }

    enum StateOfCell
    {   
        Dead = 0,
        Alive = 1
    }

    struct Parameters
    {
        public Parameters(int? width, int? frameRate, int? numberOfFrames, decimal? spawnRate)
        {
            Width = width ?? 100;
            FrameRate = frameRate ?? 4;
            NumberOfFrames = numberOfFrames ?? 100;
            SpawnRate = spawnRate ?? 0.5m;
        }

        public int Width { get; }

        public int FrameRate { get; }

        public int NumberOfFrames { get; }

        public decimal SpawnRate { get; }
    }
}
