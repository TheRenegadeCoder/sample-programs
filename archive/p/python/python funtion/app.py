# program manajemen kontak

import function
# list of dictionary
daftar_kontak = []
daftar_kontak.append({
    "nama" : "goku",
    "email" : "goku.com",
    "telepon": "019740197047"
})
print("\n")
# menu program
while True:
    print ("1. daftar kontak")
    print ("2. tambah kontak")
    print ("3. hapus kontak")
    print ("4. cari kontak ")
    print ("0. keluar program")

    menu = input ("pilih menu : ")
    if menu == "0":
        break
    elif menu == "1":
        function.display_kontak(daftar_kontak)
    elif menu == "2":
        kontak = function.new_kontak()
        daftar_kontak.append(kontak)
    elif menu == "3":
        function.hapus_kontak(daftar_kontak)
    elif menu  == "4":
        function.cari_kontak (daftar_kontak)
print ("program selesai berjalan, sampai jumpa")