class ListPerkembangan {
  int c;
  int tanggal;
  int kASUS;
  int mENINGGAL;
  int sEMBUH;
  int dIRAWATORISOLASI;
  int aKUMULASIKASUS;
  int aKUMULASISEMBUH;
  int aKUMULASIMENINGGAL;
  int aKUMULASIDIRAWATORISOLASI;

  ListPerkembangan(
      {this.c,
      this.tanggal,
      this.kASUS,
      this.mENINGGAL,
      this.sEMBUH,
      this.dIRAWATORISOLASI,
      this.aKUMULASIKASUS,
      this.aKUMULASISEMBUH,
      this.aKUMULASIMENINGGAL,
      this.aKUMULASIDIRAWATORISOLASI});

  ListPerkembangan.fromJson(int counter, Map<String, dynamic> json) {
    c = counter;
    tanggal = json['tanggal'];
    kASUS = json['KASUS'];
    mENINGGAL = json['MENINGGAL'];
    sEMBUH = json['SEMBUH'];
    dIRAWATORISOLASI = json['DIRAWAT_OR_ISOLASI'];
    aKUMULASIKASUS = json['AKUMULASI_KASUS'];
    aKUMULASISEMBUH = json['AKUMULASI_SEMBUH'];
    aKUMULASIMENINGGAL = json['AKUMULASI_MENINGGAL'];
    aKUMULASIDIRAWATORISOLASI = json['AKUMULASI_DIRAWAT_OR_ISOLASI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tanggal'] = this.tanggal;
    data['KASUS'] = this.kASUS;
    data['MENINGGAL'] = this.mENINGGAL;
    data['SEMBUH'] = this.sEMBUH;
    data['DIRAWAT_OR_ISOLASI'] = this.dIRAWATORISOLASI;
    data['AKUMULASI_KASUS'] = this.aKUMULASIKASUS;
    data['AKUMULASI_SEMBUH'] = this.aKUMULASISEMBUH;
    data['AKUMULASI_MENINGGAL'] = this.aKUMULASIMENINGGAL;
    data['AKUMULASI_DIRAWAT_OR_ISOLASI'] = this.aKUMULASIDIRAWATORISOLASI;
    return data;
  }
}
