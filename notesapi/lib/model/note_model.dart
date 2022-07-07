class note_model {
  int? notesId;
  String? notesTitle;
  String? notesContent;
  String? notesImage;
  int? notesUserid;

  note_model(
      {this.notesId,
      this.notesTitle,
      this.notesContent,
      this.notesImage,
      this.notesUserid});

  note_model.fromJson(Map<String, dynamic> json) {
    notesId = json['notes_id'];
    notesTitle = json['notes_title'];
    notesContent = json['notes_content'];
    notesImage = json['notes_image'];
    notesUserid = json['notes_userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes_id'] = this.notesId;
    data['notes_title'] = this.notesTitle;
    data['notes_content'] = this.notesContent;
    data['notes_image'] = this.notesImage;
    data['notes_userid'] = this.notesUserid;
    return data;
  }
}