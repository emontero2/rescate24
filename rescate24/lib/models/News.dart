class News {
  late String title;
  late String date;
  late String content;
  late String image;

  News(this.title, this.date, this.content, this.image);

  get getTitle => title;

  set setTitle(title) => this.title = title;

  get getDate => date;

  set setDate(date) => this.date = date;

  get getContent => content;

  set setContent(content) => this.content = content;

  get getImage => image;

  set setImage(image) => this.image = image;

  static List<News> generateNews() {
    return [
      News(
          "Denuncian inclusión de senador haitiano entre ...",
          "18 febrero, 2023",
          "La plataforma Matriz Liberación criticó hoy la inclusión del exsenador haitiano Antonio Cheramy en la lista de personas que tienen prohibida la entrada a la vecina República Dominicana por presuntamente promover la violencia. La organización calificó de maniobra la medida adoptada por el presidente dominicano, Luis Abinader, y aseguró que tienen el propósito de causar confusión y desvío de la situación que vive el país desde hace más de 12 años bajo el régimen del Partido Haitiano Tet Kale.",
          "https://hoy.com.do/wp-content/uploads/2022/08/Ex-senador-de-Haiti-Yvon-Buissereth.jpg"),
      News("Una productiva reunión", "21 febrero, 2023", "",
          "https://www.elocuent.com/wp-content/uploads/2019/08/reuniones-productivas.jpeg")
    ];
  }
}
