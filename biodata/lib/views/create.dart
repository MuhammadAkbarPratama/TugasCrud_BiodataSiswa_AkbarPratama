import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:biodata/models/api.dart';
import 'package:biodata/widgets/form.dart'; 

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nisController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController tpController = TextEditingController();
  TextEditingController tgController = TextEditingController();
  TextEditingController kelaminController = TextEditingController();
  TextEditingController agamaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();

  
  Future _createSiswa() async {
    try {
      final response = await http.post(
        Uri.parse(BaseUrl.tambah),
        body: {
          "nis": nisController.text,
          "nama": namaController.text,
          "tplahir": tpController.text,
          "tglahir": tgController.text,
          "kelamin": kelaminController.text,
          "agama": agamaController.text,
          "alamat": alamatController.text,
        },
      ).timeout(const Duration(seconds: 10)); 

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'];
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  void _onConfirm(context) async {
   
    if (formkey.currentState!.validate()) {
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Center(child: CircularProgressIndicator()),
      );

      bool success = await _createSiswa();
      
      Navigator.pop(context); 

      if (success) {
        _showPesan("Data Berhasil Disimpan", Colors.green);
        
        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        _showPesan("Gagal Menyimpan Data. Cek Koneksi/IP!", Colors.red);
      }
    }
  }

  void _showPesan(String pesan, Color warna) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan), backgroundColor: warna),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Siswa"),
        backgroundColor: Colors.blue,
        centerTitle: true,
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
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text("SIMPAN DATA"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            _onConfirm(context);
          },
        ),
      ),
    );
  }
}