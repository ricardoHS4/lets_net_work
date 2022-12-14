import 'package:cloud_firestore/cloud_firestore.dart';

class EventData {
  String id;
  String title;
  String topic;
  List<dynamic> targetAreas;
  int year;
  int month;
  int day;
  String place;
  String description;

  EventData({
    this.id = "",
    this.title = "",
    this.topic = "",
    this.targetAreas = const [],
    this.year = -1,
    this.month = -1,
    this.day = -1,
    this.place = "",
    this.description = "",
  });

  static EventData fromJson(Map<String, dynamic> json) => EventData(
        id: json['id'] ?? "",
        title: json['title'] ?? "",
        topic: json['topic'] ?? "",
        targetAreas: json['targetAreas'] ?? [],
        year: json['year'] ?? -1,
        month: json['month'] ?? -1,
        day: json['day'] ?? -1,
        place: json['place'] ?? "",
        description: json['description'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'topic': topic,
        'targetAreas': targetAreas,
        'year': year,
        'month': month,
        'day': day,
        'place': place,
        'description': description,
      };

  void createEvent() {
    final doc = FirebaseFirestore.instance.collection('events').doc();
    id = doc.id;
    doc.set(toJson());
  }
}
