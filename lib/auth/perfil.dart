import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = _selectedDate != null
        ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
        : '';

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 253, 235, 235), // Color de fondo
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tu Perfil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
                Text(
                  'En PicSpeak todos tenemos un nombre, dinos el tuyo :3',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://domain.net/saintseiya/images/some.jpg'),
                        radius: 70,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt),
                            onPressed: () {
                              // Aquí puedes agregar la lógica para abrir la cámara
                              // o hacer lo que necesites al presionar el ícono de la cámara.
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  obscureText: false,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 22.0, color: Color.fromARGB(255, 5, 5, 6)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Nombre',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 242, 237, 237)),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 232, 229, 229)),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: false,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 22.0, color: Color.fromARGB(255, 0, 0, 0)),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Apellido',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: false,
                  autofocus: false,
                  style: TextStyle(
                      fontSize: 22.0, color: Color.fromARGB(255, 0, 0, 0)),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Username',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _selectDate(context), // Mostrar DatePicker
                  child: AbsorbPointer(
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Cumpleaños',
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                      controller: TextEditingController(text: formattedDate),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Crear Cuenta ',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(232, 83, 172, 1),
                    minimumSize: Size(250.0, 60.0),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Acción cuando se presiona el botón de retroceso
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 40.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
