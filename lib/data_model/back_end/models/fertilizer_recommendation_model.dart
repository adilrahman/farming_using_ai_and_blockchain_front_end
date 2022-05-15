class FertilizerRecommendationModel {
  String n;
  String p;
  String k;
  String crop;
  FertilizerRecommendationModel({
    required this.n,
    required this.p,
    required this.k,
    required this.crop,
  });

  Map<String, String> toJson() => {
        "N": n,
        "P": p,
        "K": k,
        "crop": crop,
      };
}
