class Contact {
  Contact({
    this.memberId,
    this.value,
    this.type,
    this.priority,
    this.hidden,
    this.id,
  });

  String? memberId;
  String? value;
  String? type;
  int? priority;
  bool? hidden;
  String? id;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        memberId: json["memberId"],
        value: json["value"],
        type: json["type"],
        priority: json["priority"],
        hidden: json["hidden"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "memberId": memberId,
        "value": value,
        "type": type,
        "priority": priority,
        "hidden": hidden,
        "id": id,
      };
}
