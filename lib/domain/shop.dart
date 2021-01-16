class Shop {
  String id;
  String name;
  String address;
  String logoImage;
  String photo;
  String open;
  String station;
  String url;

  Shop({Map<String, dynamic> data}) {
    this.id = data['id'];
    this.name = data['name'];
    this.address = data['address'];
    this.logoImage = data['logo_image'];
    this.photo = data['photo']['mobile']['l'];
    this.open = data['open'];
    this.station = data['station_name'];
    this.url = data['urls']['pc'];
  }
}
