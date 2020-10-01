# program manajemen kontak

def display_kontak (daftar_kontak):
    for kontak in daftar_kontak:
        print ("========================")
        print (f"Nama :{kontak['nama']}")
        print (f"Email :{kontak['email']}")
        print (f"Telepon :{kontak['telepon']}")

def new_kontak ():
    nama = input("Nama :")
    email = input ("Email : ")
    telepon = input ("Telepon : ")
    kontak = {
        "nama" : nama,
        "email" : email,
        "telepon" : telepon
    }
    return kontak

def hapus_kontak (daftar_kontak):
    nama = input("nama yang akan di hapus : ")
    index = -1

    for i in range(0, len(daftar_kontak)):
        kontak = daftar_kontak[i]
        if nama == kontak["nama"]:
            index = i
            break 
    if index == -1:
        print ("data kontak tidak ditemmukan")
    else:
        del daftar_kontak[index]
        print ("berhasil menghapus data kontak")

def cari_kontak (daftar_kontak):
    nama_yg_dicari = input("nama yang di cari : ")

    for kontak in daftar_kontak:
        nama = kontak ["nama"]
        if nama.find(nama_yg_dicari) != -1:
                print ("========================")
                print (f"Nama :{kontak['nama']}")
                print (f"Email :{kontak['email']}")
                print (f"Telepon :{kontak['telepon']}")
