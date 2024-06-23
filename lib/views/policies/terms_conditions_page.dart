import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  final String termsConditionsText = '''
Términos y Condiciones

1. Introducción
Bienvenido a [Nombre de la Aplicación], una aplicación de chat con traducción automática de mensajes. Al utilizar nuestra aplicación, usted acepta estos términos y condiciones.

2. Uso del Servicio
Debe utilizar la aplicación de manera legal y respetuosa. No puede usar la aplicación para:
- Enviar contenido ilegal, ofensivo o dañino.
- Violar derechos de propiedad intelectual de terceros.
- Realizar actividades de spam o phishing.

3. Cuenta de Usuario
Para utilizar la aplicación, puede ser necesario registrarse y crear una cuenta. Usted es responsable de mantener la confidencialidad de su cuenta y contraseña, y de todas las actividades que ocurran bajo su cuenta.

4. Traducción de Mensajes
Nuestra aplicación ofrece traducción automática de mensajes. Aunque hacemos todo lo posible para proporcionar traducciones precisas, no garantizamos la exactitud de las traducciones.

5. Contenido del Usuario
Usted es responsable del contenido que envía a través de la aplicación. Al enviar contenido, concede a [Nombre de la Aplicación] el derecho a utilizar, modificar y distribuir dicho contenido para operar la aplicación.

6. Privacidad
El uso de la aplicación está sujeto a nuestra Política de Privacidad, que describe cómo manejamos su información personal.

7. Propiedad Intelectual
Todos los derechos sobre el contenido de la aplicación y la aplicación misma pertenecen a [Nombre de la Empresa]. No puede copiar, modificar o distribuir nuestro contenido sin nuestro permiso.

8. Limitación de Responsabilidad
[Nombre de la Empresa] no será responsable de ningún daño directo, indirecto, incidental o consecuente que resulte del uso o la imposibilidad de uso de la aplicación.

9. Modificaciones al Servicio
Nos reservamos el derecho de modificar o discontinuar la aplicación en cualquier momento sin previo aviso.

10. Terminación
Podemos suspender o terminar su cuenta si usted viola estos términos o si dejamos de ofrecer la aplicación.

11. Ley Aplicable
Estos términos se rigen por las leyes de [Jurisdicción]. Cualquier disputa será resuelta en los tribunales de [Jurisdicción].

12. Cambios a estos Términos
Podemos actualizar estos términos ocasionalmente. Le notificaremos sobre cambios importantes publicando los nuevos términos en nuestra aplicación.

13. Contacto
Si tiene preguntas sobre estos términos, puede contactarnos en: soporte@picspeak.com.

Fecha de la última actualización: 24/06/2024

  ''';

  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            termsConditionsText,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
