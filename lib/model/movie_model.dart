
class MovieModel {
  String? id;
  String? rating;
  String? title;
  String? poster;
  String? overview;
  String? releasedate;

  MovieModel(
      {this.id,
      this.rating,
      this.title,
      this.poster,
      this.overview,
      this.releasedate});

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json['id'],
        rating: json['rating'].toString(),
        title: json['title'],
        poster: json['poster'],
        overview: json['overview'],
        releasedate: json['release_date'].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "title": title,
        "poster": poster,
        "overview": overview,
        "release_date": overview,
      };
}
