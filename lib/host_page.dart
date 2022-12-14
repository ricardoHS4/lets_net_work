import 'package:flutter/material.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
//import  'package:flutter_google_places_web/flutter_google_places_web.dart';
import 'package:lets_net_work/model/event_data.dart';

//import 'package:google_maps_webservice/places.dart';
//import 'package:geocode/geocode.dart';

class HostPage extends StatefulWidget {
  const HostPage({Key? key}) : super(key: key);

  @override
  _HostPageState createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  final formKey = GlobalKey<FormState>();
  DateTime tempDate = DateTime.now();
  String seletedTopic = "-";
  List<bool> areasStatus = List.filled(25, false, growable: true);
  bool allStatus = false;
  final kGoogleApiKey = "AIzaSyDpiTZTNcLggMHTQm0Q45nD_RiW9W6sPFY";
  EventData eventData = EventData();



  @override
  Widget build(BuildContext context) {
    
    //GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

    List<String> topics = [
      "New hire",
      "Challenges discussion",
      "Brainstorming",
      "Cross-area understanding",
      "Make new friends"
    ];

    List<String> areas = [
      "IT",
      "HR",
      "Marketing",
      "Sales",
      "Finance",
      "Ops",
      "Customer Care",
    ];

    Widget titleField() {
      return TextFormField(
        decoration: const InputDecoration(
          labelText: "Title",
        ),
        validator: (value) {
          if (value == "") {
            return "Please enter a title for your event";
          }
          return null;
        },
        onSaved: (newValue) {
          eventData.title = newValue!;
        },
      );
    }

    Widget descrptionField() {
      return TextFormField(
        decoration: const InputDecoration(
          labelText: "Description",
        ),
        validator: (value) {
          if (value == "") {
            return "Please enter a description for your event";
          }
          return null;
        },
        onSaved: (newValue) {
          eventData.description = newValue!;
        },
      );
    }

    Widget dateField() {
      final now = DateTime.now();

      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 150,
            child: InputDatePickerFormField(
              firstDate: now,
              lastDate: DateTime(now.year + 2, now.month, now.day),
              initialDate: tempDate,
              fieldLabelText: "",
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 160,
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Select Date  "),
                  Icon(Icons.calendar_month_outlined)
                ],
              ),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: tempDate,
                    firstDate: now,
                    lastDate: DateTime(now.year + 2, now.month, now.day));
                if (newDate == null) return;

                setState(() {
                  tempDate = newDate;
                });
              },
            ),
          )
        ],
      );
    }

    

    

    Widget topicField() {
      List<DropdownMenuItem> items = [];
      items.add(const DropdownMenuItem(
        value: "-",
        child: Text("Select Topic"),
      ));

      for (int x = 0; x < topics.length; x++) {
        items.add(DropdownMenuItem(
          value: topics[x],
          child: Text(topics[x]),
        ));
      }

      return DropdownButton(
        items: items,
        value: seletedTopic,
        hint: const Text("Topic"),
        onChanged: (value) {
          setState(() {
            seletedTopic = value;
            eventData.topic = value;
            print(eventData.topic);
          });
        },
      );
    }

    Widget targetAreas() {
      List<Widget> items = [];
      items.add(const Text("TARGET AREAS", textAlign: TextAlign.left, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),));
      items.add(const SizedBox(height: 10,));

      items.add(CheckboxListTile(
        value: allStatus,
        title: const Text("All areas"),
        onChanged: (value) {
          setState(() {
            allStatus = value!;
            for (int x = 0; x < areasStatus.length; x++) {
              areasStatus[x] = value;
            }
          });
        },
      ));

      for (int x = 0; x < areas.length; x++) {
        items.add(CheckboxListTile(
          value: areasStatus[x],
          title: Text(areas[x]),
          onChanged: (value) {
            setState(() {
              areasStatus[x] = value!;
            });
          },
        ));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      );
    }

    infoMessage(String message) async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Congrats!"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }


    bool firstClick = true;

    Widget createButton = MaterialButton(
      onPressed: () async {
        final isValid = formKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        if (isValid) {
          formKey.currentState!.save();
          eventData.targetAreas = [];
          for(int x=0;x<areas.length;x++){
            if(areasStatus[x]==true){
              eventData.targetAreas.add(areas[x]);
            }
          }
          eventData.year = tempDate.year;
          eventData.month = tempDate.month;
          eventData.day = tempDate.day;
          print(eventData.topic);
          eventData.createEvent();

          infoMessage("Your event was created successfully");



          
        }
      },
      color: Colors.blue,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text("\tCreate event\t",
            style: TextStyle(color: Colors.white)),
      ),
    );

    Widget formFieldColumn() {
      return Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleField(),
              descrptionField(),
              dateField(),
              const SizedBox(height: 10),
              topicField(),
              const SizedBox(height: 16),
              targetAreas(),
              const SizedBox(height: 10),
              //locationField(),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              formFieldColumn(),
              createButton,
            ],
          ),
        ),
      ),
    );
  }
}
