using System;
using System.Collections;

namespace TransposeMatrix;

class Matrix<T>
{
    int mRows;
    int mCols;
    T[,] mMatrix ~ delete _;

    public this(int rows, int cols, List<T> arr)
    {
        mRows = rows;
        mCols = cols;
        mMatrix = new T[mRows, mCols];
        int index = 0;
        for (int i < mRows)
        {
            for (int j < mCols)
            {
                mMatrix[i, j] = arr[index];
                index++;
            }
        }
    }

    public void ShowMatrixAsList()
    {
        String line = scope .();
        for (int i < mRows)
        {
            for (int j < mCols)
            {
                if (!line.IsEmpty)
                {
                    line += ", ";
                }

                line.AppendF("{}", mMatrix[i, j]);
            }
        }

        Console.WriteLine(line);
    }

    public void Transpose()
    {
        T[,] matrixT = new T[mCols, mRows];
        for (int i < mRows)
        {
            for (int j < mCols)
            {
                matrixT[j, i] = mMatrix[i, j];
            }
        }

        Swap!(mRows, mCols);
        delete mMatrix;
        mMatrix = matrixT;
    }
}

class Program
{
    public static void Usage()
    {
        Console.WriteLine("Usage: please enter the dimension of the matrix and the serialized matrix");
        Environment.Exit(0);
    }

    public static Result<T> ParseInt<T>(StringView str)
    where T : IParseable<T>
    {
        StringView trimmedStr = scope String(str);
        trimmedStr.Trim();

        // T.Parse ignores single quotes since they are treat as digit separators -- e.g. 1'000
        if (trimmedStr.Contains('\''))
        {
            return .Err;
        }

        return T.Parse(trimmedStr);
    }

    public static Result<void> ParseIntList<T>(StringView str, List<T> arr)
    where T: IParseable<T>
    {
        arr.Clear();
        for (StringView item in str.Split(','))
        {
            switch (ParseInt<T>(item))
            {
                case .Ok(let val):
                    arr.Add(val);

                case .Err:
                    return .Err;
            }
        }

        return .Ok;
    }

    public static int Main(String[] args)
    {
        if (args.Count < 3)
        {
            Usage();
        }

        int cols = ?;
        switch (ParseInt<int>(args[0]))
        {
            case .Ok(out cols):
                if (cols < 1)
                {
                    Usage();
                }

            case .Err:
                Usage();
        }

        int rows = ?;
        switch (ParseInt<int>(args[1]))
        {
            case .Ok(out rows):
                if (rows < 1)
                {
                    Usage();
                }

            case .Err:
                Usage();
        }

        List<int32> arr = scope .();
        if (ParseIntList<int32>(args[2], arr) case .Err)
        {
            Usage();
        }

        if (rows * cols != arr.Count)
        {
            Usage();
        }

        Matrix<int32> matrix = scope .(rows, cols, arr);
        matrix.Transpose();
        matrix.ShowMatrixAsList();
        return 0;
    }
}
