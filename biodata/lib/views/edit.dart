import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:biodata/models/msiswa.dart';
import 'package:biodata/models/api.dart';
import 'package:biodata/widgets/form.dart'; // Pastikan path benar

class Edit extends StatefulWidget {
  final SiswaModel sw;
  Edit({required this.sw});

  @override
  EditState createState() => EditState();
}

class EditState extends State<Edit> {
  final formkey = GlobalKey<FormState>();

  late TextEditingController nisController,
      namaController,
      tpController,
      tgController,
      kelaminController,
      agamaController,
      alamatController;

  @override
  void initState() {
    super.initState();
    nisController = TextEditingController(text: widget.sw.nis);
    namaController = TextEditingController(text: widget.sw.nama);
    tpController = TextEditingController(text: widget.sw.tplahir);
    tgController = TextEditingController(text: widget.sw.tglahir);
    kelaminController = TextEditingController(text: widget.sw.kelamin);
    agamaController = TextEditingController(text: widget.sw.agama);
    alamatController = TextEditingController(text: widget.sw.alamat);
  }

  Future editSw() async {
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.edit),
        body: {
          "id": widget.sw.id.toString(),
          "nis": nisController.text,
          "nama": namaController.text,
          "tplahir": tpController.text, 
          "tglahir": tgController.text, 
          "kelamin": kelaminController.text,
          "agama": agamaController.text,
          "alamat": alamatController.text
        },
      ).timeout(const Duration(seconds: 10));
      return response;
    } catch (e) {
      return null;
    }
  }

  void pesan() {
    Fluttertoast.showToast(
        msg: "Data Berhasil Diedit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green, 
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onConfirm(context) async {
    if (formkey.currentState!.validate()) {
      // Tampilkan loading sederhana
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (res) => Center(child: CircularProgressIndicator()));

      var response = await editSw();
      Navigator.pop(context); 

      if (response != null && response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          pesan();
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal Update: Cek Koneksi/IP Server")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text("SIMPAN PERUBAHAN"),
          onPressed: () => _onConfirm(context),
        ),
      ),
      body: AppForm(
        formkey: formkey,
        nisController: nisController,
        namaController: namaController,
        tpController: tpController,
        tgController: tgController,
        kelaminController: kelaminController,
        agamaController: agamaController,
        alamatController: alamatController,
      ),
    );
  }
}