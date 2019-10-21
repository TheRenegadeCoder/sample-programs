def sort_list(list1, list2):
    pairs = zip(list2, list1)
    z = [x for _, x in sorted(pairs)]
    return z


def encrpyt(key, msg):
    key_arr = []
    for i in key:
        key_arr.append(i)
    msg_arr = []
    temp = []
    for i in msg:
        if(len(temp) == len(key_arr)):
            msg_arr.append(sort_list(temp, key_arr))
            temp = []
        temp.append(i)
    cipher = ''
    for i in range(len(msg_arr[0])):
        for j in range(len(msg_arr)):
            cipher = cipher + msg_arr[j][i]
    return cipher


def decrpyt(key, cipher):
    key_arr = []
    for i in key:
        key_arr.append(i)
    n = int(len(cipher)/len(key))
    msg_arr = []
    for i in range(n):
        msg_arr.append([])
    for i in range(len(cipher)):
        msg_arr[i % (len(key)-1)].append(cipher[i])
    final = []
    for i in msg_arr:
        final.append(sort_list(i, key_arr))
    msg = ''
    for i in final:
        for j in i:
            msg = msg + j
    return msg


cipher = encrpyt("dcba", "hello world  ")
print(cipher)
message = decrpyt("dcba", cipher)
print(message)
