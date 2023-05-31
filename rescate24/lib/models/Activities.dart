class Activities {
  late String title;
  late String date;
  late String month;
  late String day;

  Activities(this.title, this.date, this.month, this.day);

  get getTitle => title;

  set setTitle(title) => this.title = title;

  get getDate => date;

  set setDate(date) => this.date = date;

  static List<Activities> generateActivities() {
    return [
      Activities("Actualizacion de datos", "18 febrero, 2023", "Febrero", "18"),
      Activities("Reunion de dirigentes a Nivel Nacional", "21 febrero, 2023",
          "Febrero", "21")
    ];
  }
}
