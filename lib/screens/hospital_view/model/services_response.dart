class ServicesResponse {
  int? status;
  List<ServiceList>? serviceList;

  ServicesResponse({this.status, this.serviceList});

  ServicesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['serviceList'] != null) {
      serviceList = <ServiceList>[];
      json['serviceList'].forEach((v) {
        serviceList!.add(new ServiceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.serviceList != null) {
      data['serviceList'] = this.serviceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceList {
  String? services;

  ServiceList({this.services});

  ServiceList.fromJson(Map<String, dynamic> json) {
    services = json['services'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services'] = this.services;
    return data;
  }
}
