class CropRecommendationModel {
  String n;
  String p;
  String k;
  String pH;
  String rainFall;
  String temp;
  String humidity;
  CropRecommendationModel(
      {required this.n,
      required this.p,
      required this.k,
      required this.pH,
      required this.humidity,
      required this.rainFall,
      required this.temp});

  Map<String, String> toJson() => {
        "N": n,
        "P": p,
        "K": k,
        "pH": pH,
        "rainFall": rainFall,
        "temp": temp,
        "humidity": humidity
      };
}
