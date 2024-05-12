import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class EditData extends StatefulWidget {
  final List? list;
  final int? index;

  EditData({this.list, this.index});

  @override
  EditDataState createState() => EditDataState();
}

class EditDataState extends State<EditData> {
  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController prodiController = TextEditingController();

  void editData(String id) {
    var url = Uri.parse(
        "https://65f7c423b4f842e80885fa15.mockapi.io/mahasiswa/$id");
    http.put(url, body: {
      "nim": nimController.text,
      "nama": namaController.text,
      "prodi": prodiController.text,
    });
  }

  void deleteData(String id) {
    var url = Uri.parse(
        "https://65f7c423b4f842e80885fa15.mockapi.io/mahasiswa/$id");
    http.delete(url, body: {'id': widget.list![widget.index!]['id']});
  }

  void konfirmasi() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
          "Apakah anda yakin akan menghapus data '${widget.list![widget.index!]['nama']}' ?"),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: Text(
            "OK DELETE!",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            deleteData(idMhs);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: Text("CANCEL", style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  late String idMhs;
  @override
  void initState() {
    idMhs = widget.list![widget.index!]['id'];
    nimController =
        TextEditingController(text: widget.list![widget.index!]['nim']);
    namaController =
        TextEditingController(text: widget.list![widget.index!]['nama']);
    prodiController =
        TextEditingController(text: widget.list![widget.index!]['prodi']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Mahasiswa"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Ubah Data Mahasiswa",
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: nimController,
              decoration: InputDecoration(
                labelText: "NIM",
              ),
            ),
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: "Nama",
              ),
            ),
            TextFormField(
              controller: prodiController,
              decoration: InputDecoration(
                labelText: "Prodi",
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    editData(idMhs);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text("Ubah"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    konfirmasi();
                  },
                  child: Text("Hapus"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
