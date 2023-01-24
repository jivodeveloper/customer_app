class Banners {

    var banner;
    var bannerpath;
    var id;

    Banners({required this.banner, required this.bannerpath,required this.id});

    factory Banners.fromJson(Map<String, dynamic> json) {
        return Banners(
            banner: json['banner'], 
            bannerpath: json['bannerpath'], 
            id: json['Id'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['banner'] = this.banner;
        data['bannerpath'] = this.bannerpath;
        data['Id'] = this.id;
        return data;
    }

}