import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

// ignore: must_be_immutable
class AppForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController nisController,
      namaController,
      tpController,
      tgController,
      kelaminController,
      agamaController,
      alamatController;

  const AppForm({
    super.key,
    required this.formkey,
    required this.nisController,
    required this.namaController,
    required this.tpController,
    required this.tgController,
    required this.kelaminController,
    required this.agamaController,
    required this.alamatController,
  });

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  final _status = ["Laki-laki", "Perempuan"];
  final List<String> items = [
    "Islam",
    "Katholik",
    "Protestan",
    "Hindu",
    "Budha",
    "Khonghucu",
    "Kepercayaan",
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            txtNis(),
            const SizedBox(height: 15),
            txtNama(),
            const SizedBox(height: 15),
            txtTempat(),
            const SizedBox(height: 15),
            txtTanggal(),
            const SizedBox(height: 15),
            tbKelamin(),
            const SizedBox(height: 15),
            tbAgama(),
            const SizedBox(height: 15),
            tbAlamat(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  txtNis() {
    return TextFormField(
      controller: widget.nisController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "NIS",
        prefixIcon: const Icon(Icons.card_membership),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan NIS Anda' : null,
    );
  }

  txtNama() {
    return TextFormField(
      controller: widget.namaController,
      decoration: InputDecoration(
        labelText: "Nama Lengkap",
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan Nama Anda' : null,
    );
  }

  txtTempat() {
    return TextFormField(
      controller: widget.tpController,
      decoration: InputDecoration(
        labelText: "Tempat Lahir",
        prefixIcon: const Icon(Icons.location_city),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan Kota Kelahiran' : null,
    );
  }

  txtTanggal() {
    return TextFormField(
      readOnly: true,
      controller: widget.tgController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.calendar_today),
        labelText: 'Tanggal Lahir',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          widget.tgController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
      validator: (value) => value!.isEmpty ? 'Pilih Tanggal Lahir' : null,
    );
  }

  tbKelamin() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Jenis Kelamin',
        prefixIcon: const Icon(Icons.people),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      
      value: widget.kelaminController.text.isEmpty ? null : widget.kelaminController.text,
      hint: const Text('Pilih Jenis Kelamin'),
      onChanged: (newValue) {
        setState(() {
          widget.kelaminController.text = newValue!;
        });
      },
      items: _status.map((value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      validator: (value) => value == null ? 'Pilih Jenis Kelamin' : null,
    );
  }

  tbAgama() {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: "Agama",
        prefixIcon: const Icon(Icons.mosque),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      value: widget.agamaController.text.isEmpty ? null : widget.agamaController.text,
      hint: const Text('Pilih Agama'),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: (value) {
        setState(() {
          widget.agamaController.text = value.toString();
        });
      },
      validator: (value) => value == null ? 'Pilih Agama' : null,
    );
  }

  tbAlamat() {
    return TextFormField(
      controller: widget.alamatController,
      maxLines: 3, 
      decoration: InputDecoration(
        labelText: "Alamat Lengkap",
        prefixIcon: const Icon(Icons.location_on),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan Alamat' : null,
    );
  }
}