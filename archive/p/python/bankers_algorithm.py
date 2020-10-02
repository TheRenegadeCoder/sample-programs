P = 5  # No of processes
R = 3  # Types of resources


def Need(need, maxm, allot):

    for i in range(P):
        for j in range(R):

            need[i][j] = maxm[i][j] - allot[i][j]


def isSequenceSafe(processes, avail, maxm, allot):
    need = []
    for i in range(P):
        l = []
        for j in range(R):
            l.append(0)
        need.append(l)

    Need(need, maxm, allot)

    finish = [0] * P

    safeSequence = [0] * P

    work = [0] * R
    for i in range(R):
        work[i] = avail[i]

    count = 0
    while (count < P):

        found = False
        for p in range(P):

            if (finish[p] == 0):

                for j in range(R):
                    if (need[p][j] > work[j]):
                        break

                if (j == R - 1):

                    for k in range(R):
                        work[k] += allot[p][k]

                    safeSequence[count] = p
                    count += 1

                    finish[p] = 1

                    found = True

        if (found == False):
            print("The System is not in a safe state. A deadlock is present")
            return False

    print("System is in safe state. No deadlock present",
          "\nSafe sequence is: ", end=" ")
    print(*safeSequence)

    return True


processes = [0, 1, 2, 3, 4]

available = [3, 3, 2]

maxm = [[7, 5, 3], [3, 2, 2],
        [9, 0, 2], [4, 2, 2],
        [5, 3, 3]]

allocated = [[0, 1, 0], [2, 0, 0],
             [3, 0, 2], [2, 1, 1],
             [0, 0, 2]]

isSequenceSafe(processes, available, maxm, allocated)
