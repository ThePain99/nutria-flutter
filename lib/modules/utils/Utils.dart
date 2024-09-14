class Utils {
  static String calculateAge(String fechaNacimiento) {
    // Convertir la fecha de nacimiento del formato dd/MM/yyyy a DateTime
    if(fechaNacimiento == "") return '0';
    DateTime fechaNac = DateTime.parse(
      fechaNacimiento.split('/').reversed.join(), // Convierte "20/01/1999" a "1999-01-20"
    );

    // Obtener la fecha actual
    DateTime fechaActual = DateTime.now();

    // Calcular la diferencia en años
    int edad = fechaActual.year - fechaNac.year;

    // Ajustar si el cumpleaños no ha pasado este año
    if (fechaActual.month < fechaNac.month ||
        (fechaActual.month == fechaNac.month && fechaActual.day < fechaNac.day)) {
      edad--;
    }

    return edad.toString(); // Convertir la edad a String
  }

  static String setObjetive(String objetive) {
    if (objetive == 'Ganar Musculo') {
      return 'Pon tus musculos fuertes y gana fuerza';
    } else if (objetive == 'Perder Grasa') {
      return 'Reduce tu indice de grasa, manteniendote en forma';
    } else {
      return 'Manten tu estilo de vida saludable';
    }
  }
}