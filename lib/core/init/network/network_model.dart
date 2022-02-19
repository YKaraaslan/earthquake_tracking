class NetworkResponseModel {
  int? status;
  List<NetworkModel>? data;

  NetworkResponseModel({this.status, this.data});

  NetworkResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <NetworkModel>[];
      json['data'].forEach((v) {
        data!.add(NetworkModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NetworkModel {
  String? eventId;
  String? time;
  String? agency;
  String? lat;
  String? lon;
  String? depth;
  String? rms;
  String? type;
  String? m;
  String? place;
  String? country;
  String? city;
  String? district;
  String? town;
  String? other;
  String? mapImagePath;
  String? strike1;
  String? dip1;
  String? rake1;
  String? strike2;
  String? dip2;
  String? rake2;
  String? ftype;
  String? pic;
  String? file;
  String? focalId;
  String? time2;

  NetworkModel(
      {this.eventId,
      this.time,
      this.agency,
      this.lat,
      this.lon,
      this.depth,
      this.rms,
      this.type,
      this.m,
      this.place,
      this.country,
      this.city,
      this.district,
      this.town,
      this.other,
      this.mapImagePath,
      this.strike1,
      this.dip1,
      this.rake1,
      this.strike2,
      this.dip2,
      this.rake2,
      this.ftype,
      this.pic,
      this.file,
      this.focalId,
      this.time2});

  NetworkModel.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    time = json['time'];
    agency = json['agency'];
    lat = json['lat'];
    lon = json['lon'];
    depth = json['depth'];
    rms = json['rms'];
    type = json['type'];
    m = json['m'];
    place = json['place'];
    country = json['country'];
    city = json['city'];
    district = json['district'];
    town = json['town'];
    other = json['other'];
    mapImagePath = json['mapImagePath'];
    strike1 = json['strike1'];
    dip1 = json['dip1'];
    rake1 = json['rake1'];
    strike2 = json['strike2'];
    dip2 = json['dip2'];
    rake2 = json['rake2'];
    ftype = json['ftype'];
    pic = json['pic'];
    file = json['file'];
    focalId = json['focalId'];
    time2 = json['time2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventId'] = eventId;
    data['time'] = time;
    data['agency'] = agency;
    data['lat'] = lat;
    data['lon'] = lon;
    data['depth'] = depth;
    data['rms'] = rms;
    data['type'] = type;
    data['m'] = m;
    data['place'] = place;
    data['country'] = country;
    data['city'] = city;
    data['district'] = district;
    data['town'] = town;
    data['other'] = other;
    data['mapImagePath'] = mapImagePath;
    data['strike1'] = strike1;
    data['dip1'] = dip1;
    data['rake1'] = rake1;
    data['strike2'] = strike2;
    data['dip2'] = dip2;
    data['rake2'] = rake2;
    data['ftype'] = ftype;
    data['pic'] = pic;
    data['file'] = file;
    data['focalId'] = focalId;
    data['time2'] = time2;
    return data;
  }
}