
class ActivityTypologyApi {
    final int id;
    final String nameEs;
    final String nameCa;
    final String iconUrl;
    final DateTime createdAt;
    final DateTime updatedAt;

    ActivityTypologyApi({
        required this.id,
        required this.nameEs,
        required this.nameCa,
        required this.iconUrl,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ActivityTypologyApi.fromJson(Map<String, dynamic> json) => ActivityTypologyApi(
        id: json["id"],
        nameEs: json["name_es"],
        nameCa: json["name_ca"],
        iconUrl: json["icon_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

}