class TimeToFertilize {
  String latitude;
  String longitude;
  TimeToFertilize({required this.latitude, required this.longitude});

  Map<String, String> toJson() =>
      {"latitude": latitude, "longitude": longitude};
}
