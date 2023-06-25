class Direccion {
  late int id;
  get getId => this.id;

  set setId(id) => this.id = id;
  String province = "";
  String municipe = "";
  get getProvince => this.province;

  set setProvince(province) => this.province = province;

  get getMunicipe => this.municipe;

  set setMunicipe(municipe) => this.municipe = municipe;
}
