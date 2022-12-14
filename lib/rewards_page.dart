import 'package:flutter/material.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "PROFILE",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  "https://i0.wp.com/enbreves.com/wp-content/uploads/2020/07/Nikola-Tesla-Un-viaje-hacia-la-vida-del-inventor-de-la-electricidad.jpg"),
            ),
            ListTile(
              title: Text("Nikola Tesla"),
              subtitle: Text("Points: 84"),
            ),
          ],
        ));
  }
}
