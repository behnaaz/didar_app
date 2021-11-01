
import 'package:didar_app/services/database/fb_all_session_service.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:didar_app/widgets/multiSelect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



// =============================================================================
// Session Type Future from DB --::--::--::--::--::--::--::--::--::--::--::--::-
// =============================================================================
class SessionSubject extends StatelessWidget {
  final List<String> _options = [];
  final List sessionsTopicSelected;

  SessionSubject({Key? key, required this.sessionsTopicSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FBAllSessionTypeService().allSessionsType,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Sessions not Available");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> _o = data['type'];
            _o.forEach((e) {
              _options.add(e.toString());
            });

            return _DropDownSession(_options, sessionsTopicSelected);
          }
          // this is empty Dropdown before data fetch from Firestore
          return Stack(
            children: [
              DropDownMultiSelect(
                onChanged: (List<String> list) {},
                options: _options,
                selectedValues: [],
                whenEmpty: 'موضوع جلسات',
              ),
              Positioned(
                  top: 38,
                  right: 110,
                  child: Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )))
            ],
          );
        });
  }
}


class _DropDownSession extends StatefulWidget {
  final List<String> options;
  final List<dynamic> selected;
  _DropDownSession(this.options, this.selected);

  @override
  _DropDownSessionState createState() => _DropDownSessionState(this.options, this.selected);
}

class _DropDownSessionState extends State<_DropDownSession> {
  final List<String> _options;
  final List<dynamic> selected;
  List<String> selectedString = [];
  _DropDownSessionState(this._options, this.selected);
  List<String> listToString() {
    List<String> stringList = [];
    selected.forEach((element) {
      stringList.add(element.toString());
    });

    return stringList;
  }

  @override
  void initState() {
    print(selected);
    selectedString = listToString();
    print(selectedString);
    super.initState();
  }

  late FirestoreServiceDB _firestoreService;
  @override
  Widget build(BuildContext context) {
    _firestoreService = Provider.of<FirestoreServiceDB>(context);
    return DropDownMultiSelect(
      onChanged: (List<String> list) {
        setState(() {
          selectedString = list;
          _firestoreService.updateSessionTopic(list);
        });
      },
      options: _options,
      selectedValues: selectedString,
      whenEmpty: 'موضوع جلسات',
    );
  }
}
