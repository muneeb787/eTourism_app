class TemperatureModel {
  final int current;
  final int feelsLike;
  final int min;
  final int max;

  TemperatureModel({
    required this.current,
    required this.feelsLike,
    required this.min,
    required this.max,
  });

  factory TemperatureModel.fromJson(Map<String, dynamic> json) {
    return TemperatureModel(
      current: json['current'] as int,
      feelsLike: json['feelsLike'] as int,
      min: json['min'] as int,
      max: json['max'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': current,
      'feelsLike': feelsLike,
      'min': min,
      'max': max,
    };
  }
}
