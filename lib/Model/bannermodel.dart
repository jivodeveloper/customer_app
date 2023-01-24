import 'package:customer_app/Model/Banners.dart';

class bannermodel {

    List<Banners> banners;
    bannermodel({required this.banners});

    factory bannermodel.fromJson(Map<String, dynamic> json) {
        return bannermodel(
            banners: json['banners'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.banners != null) {
            data['banners'] = this.banners.map((v) => v.toJson()).toList();
        }
        return data;
    }

}