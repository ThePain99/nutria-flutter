class Aliments {
  final String name;
  final double? calories;
  final double? proteins;
  final double? fats;
  final double? carbohydrates;
  final String date;

  // Constructor
  Aliments({
    required this.name,
    this.calories,
    this.proteins,
    this.fats,
    this.carbohydrates,
    required this.date,
  });

  // Método para crear una instancia de Aliments desde un Map (ej. JSON)
  factory Aliments.fromJson(Map<String, dynamic> map) {
    return Aliments(
      name: map['name'],
      calories: map['calories'],
      proteins: map['proteins'],
      fats: map['fats'],
      carbohydrates: map['carbohydrates'],
      date: map['date'],
    );
  }

  // Método para convertir una instancia de Aliments a un Map (ej. para JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'calories': calories,
      'proteins': proteins,
      'fats': fats,
      'carbohydrates': carbohydrates,
      'date': date,
    };
  }
}
