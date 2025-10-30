import java.util.*;

public class TransposeMatrix {
    private static final int MAX_MATRIX_SIZE = 100;
    private static final String USAGE_MSG = "Usage: please enter the dimension of the matrix and the serialized matrix";

    public static void transposeMatrix(int[] matrix, int rows, int cols, int[] transposed) {
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                transposed[j * rows + i] = matrix[i * cols + j];
            }
        }
    }

    public static void main(String[] args) {
        if (args.length != 3) {
            System.out.println(USAGE_MSG);
            return;
        }

        int cols, rows;
        String input = args[2];

        try {
            cols = Integer.parseInt(args[0]);
            rows = Integer.parseInt(args[1]);
        } catch (Exception e) {
            System.out.println(USAGE_MSG);
            return;
        }

        if (cols <= 0 || rows <= 0 || input.isEmpty()) {
            System.out.println(USAGE_MSG);
            return;
        }

        int[] matrix = new int[MAX_MATRIX_SIZE];
        int[] transposed = new int[MAX_MATRIX_SIZE];
        int count = 0;

        String[] tokens = input.split(",");
        for (String token : tokens) {
            if (count >= rows * cols) break;

            token = token.trim();
            try {
                matrix[count++] = Integer.parseInt(token);
            } catch (Exception e) {
                System.out.println(USAGE_MSG);
                return;
            }
        }

        if (count != rows * cols) {
            System.out.println(USAGE_MSG);
            return;
        }

        transposeMatrix(matrix, rows, cols, transposed);

        for (int i = 0; i < cols * rows; i++) {
            System.out.print(transposed[i]);
            if (i < cols * rows - 1) {
                System.out.print(", ");
            }
        }
        System.out.println();
    }
}
