class Location {
  final int id;
  final int locationtypeid;
  final int locationdistrictid;
  final String name;
  final String imageurl;
  final String defination;
  final String coordinate;
  final int avaragerating;

  Location({
    required this.id,
    required this.locationtypeid,
    required this.locationdistrictid,
    required this.name,
    required this.imageurl,
    required this.defination,
    required this.coordinate,
    required this.avaragerating,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json['_id'],
        locationtypeid: json['locationTypeId'],
        locationdistrictid: json['locationDistrictId'],
        name: json['locationName'],
        imageurl: json['locationImageUrl'],
        defination: json['locationDefination'],
        coordinate: json['locationCoordinate'],
        avaragerating: json['locationAvarageRating'],
      );
}
