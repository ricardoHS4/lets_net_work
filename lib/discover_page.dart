import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_net_work/model/event_data.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget tile(EventData event) {
      List<Widget> chips = [];
      for (int x = 0; x < event.targetAreas.length; x++) {
        chips.add(Chip(label: Text(event.targetAreas[x])));
      }

      final currentWidth = MediaQuery.of(context).size.width;
      if (currentWidth > 600) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 26),
              color: Color.fromARGB(70, 0, 179, 255),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Date:"),
                  Text(
                    "${event.month}/${event.day}/${event.year}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          title: Text(event.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.description),
              Text("Topic: ${event.topic}"),
              Text("Location: ______________"),
            ],
          ),
          trailing: Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Wrap(
              children: chips,
            ),
          ),
          isThreeLine: true,
        );
      }

      return ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Color.fromARGB(70, 0, 179, 255),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Date:"),
                Text(
                  "${event.month}/${event.day}/${event.year}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        title: Text(event.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.description),
            Text("Topic: ${event.topic}"),
            Text("Location: ______________"),
            SizedBox(height: 10),
            Wrap(children: chips),
          ],
        ),
        isThreeLine: true,
      );
    }

    List<Widget> eventsToTiles(List<EventData> events) {
      List<Widget> tiles = [];
      for (int x = 0; x < events.length; x++) {
        var event = events[x];
        tiles.add(tile(event));
      }
      return tiles;
    }

    Future<Widget> eventsColumn() async {
      final queryShot =
          await FirebaseFirestore.instance.collection('events').get();

      List<EventData> events =
          queryShot.docs.map((doc) => EventData.fromJson(doc.data())).toList();

      List<Widget> tiles = [];
      tiles.add(const Text(
        "UPCOMING EVENTS",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ));
      tiles.add(SizedBox(height: 16));

      tiles = tiles + eventsToTiles(events);
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: tiles,
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: FutureBuilder(
        future: eventsColumn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 100.0,
                height: 100.0,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }
}
