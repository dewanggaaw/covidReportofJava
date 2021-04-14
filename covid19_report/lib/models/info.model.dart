import 'package:covid19_report/models/perkembangan.model.dart';

class Info {
  String lastDate;
  String provinsi;
  int kasusTotal;
  int kasusTanpaTgl;
  int kasusDenganTgl;
  double meninggalPersen;
  int meninggalTanpaTgl;
  int meninggalDenganTgl;
  double sembuhPersen;
  int sembuhTanpaTgl;
  int sembuhDenganTgl;
  List<ListPerkembangan> listPerkembangan;

  Info(
      {this.lastDate,
      this.provinsi,
      this.kasusTotal,
      this.kasusTanpaTgl,
      this.kasusDenganTgl,
      this.meninggalPersen,
      this.meninggalTanpaTgl,
      this.meninggalDenganTgl,
      this.sembuhPersen,
      this.sembuhTanpaTgl,
      this.sembuhDenganTgl,
      this.listPerkembangan});

  Info.fromJson(Map<String, dynamic> json) {
    lastDate = json['last_date'];
    provinsi = json['provinsi'];
    kasusTotal = json['kasus_total'];
    kasusTanpaTgl = json['kasus_tanpa_tgl'];
    kasusDenganTgl = json['kasus_dengan_tgl'];
    meninggalPersen = json['meninggal_persen'];
    meninggalTanpaTgl = json['meninggal_tanpa_tgl'];
    meninggalDenganTgl = json['meninggal_dengan_tgl'];
    sembuhPersen = json['sembuh_persen'];
    sembuhTanpaTgl = json['sembuh_tanpa_tgl'];
    sembuhDenganTgl = json['sembuh_dengan_tgl'];
    listPerkembangan = [];
    if (json['list_perkembangan'] != null) {
      int c = 0;
      var temp = <ListPerkembangan>[];

      json['list_perkembangan'].forEach((v) {
        temp.add(new ListPerkembangan.fromJson(0, v));
      });

      var reversedTemp = new List.from(temp.reversed.toList());
      reversedTemp.forEach((element) {
        element.c = c;
        listPerkembangan.add(element);
        c++;
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_date'] = this.lastDate;
    data['provinsi'] = this.provinsi;
    data['kasus_total'] = this.kasusTotal;
    data['kasus_tanpa_tgl'] = this.kasusTanpaTgl;
    data['kasus_dengan_tgl'] = this.kasusDenganTgl;
    data['meninggal_persen'] = this.meninggalPersen;
    data['meninggal_tanpa_tgl'] = this.meninggalTanpaTgl;
    data['meninggal_dengan_tgl'] = this.meninggalDenganTgl;
    data['sembuh_persen'] = this.sembuhPersen;
    data['sembuh_tanpa_tgl'] = this.sembuhTanpaTgl;
    data['sembuh_dengan_tgl'] = this.sembuhDenganTgl;
    if (this.listPerkembangan != null) {
      data['list_perkembangan'] =
          this.listPerkembangan.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
