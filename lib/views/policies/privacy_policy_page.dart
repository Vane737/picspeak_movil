import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  final String privacyPolicyText = '''
Política de Privacidad

1. Introducción
Bienvenido a nuestra aplicación de chat con traducción automática de mensajes. Esta política de privacidad describe cómo manejamos la información personal que recopilamos y usamos.

2. Información que Recopilamos
Recopilamos la siguiente información:
- Datos de perfil: nombre, correo electrónico, foto de perfil.
- Datos de uso: historial de chats, traducciones realizadas.
- Datos técnicos: dirección IP, tipo de dispositivo, sistema operativo.

3. Uso de la Información
Utilizamos la información para:
- Proporcionar y mejorar el servicio de traducción de mensajes.
- Personalizar la experiencia del usuario.
- Mantener la seguridad y prevenir fraudes.
- Analizar el uso de la aplicación para mejoras y desarrollo de nuevas funcionalidades.

4. Compartición de Información
No compartimos su información personal con terceros excepto:
- Cuando sea necesario para operar y mejorar la aplicación (ej. proveedores de servicios de traducción).
- Para cumplir con obligaciones legales o responder a solicitudes legales.

5. Seguridad de la Información
Implementamos medidas de seguridad técnicas y organizativas para proteger su información contra accesos no autorizados y pérdidas.

6. Derechos del Usuario
Usted tiene el derecho a:
- Acceder y corregir su información personal.
- Solicitar la eliminación de su información.
- Oponerse al procesamiento de su información para ciertos fines.

7. Retención de Datos
Retenemos su información solo mientras sea necesario para proporcionar nuestros servicios o según lo requerido por la ley.

8. Cambios a esta Política
Podemos actualizar esta política de privacidad ocasionalmente. Le notificaremos sobre cambios importantes publicando la nueva política en nuestra aplicación.

9. Contacto
Si tiene preguntas sobre esta política de privacidad, puede contactarnos en: soporte@picspeak.com.

Fecha de la última actualización: 24/06/2024

  ''';

  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Política de Privacidad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            privacyPolicyText,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
