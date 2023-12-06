import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketTestScreen extends StatefulWidget {
  @override
  _SocketTestScreenState createState() => _SocketTestScreenState();
}

class _SocketTestScreenState extends State<SocketTestScreen> {
  late io.Socket socket;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();

     // Cambia la URL según la configuración de tu servidor
    socket = io.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'query': {'userId': '1'}, // Ajusta el userId según tus necesidades
    }); 
  }

  void connectToSocket() {
    socket.connect();

    socket.on('connect', (_) {
      setState(() {
        isConnected = true;
      });
      print('Conectado al socket');
    });

    socket.on('disconnect', (_) {
      setState(() {
        isConnected = false;
      });
      print('Desconectado del socket');
    });
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Socket Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isConnected ? 'Conectado al socket' : 'Desconectado del socket',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: connectToSocket,
              child: Text('Conectar al socket'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SocketTestScreen(),
  ));
}
