import 'package:didar_app/services/database/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:logger/logger.dart';

var logger = Logger(); //REMOVE later

class AddNewSocialLinksBottomSheet extends StatefulWidget {
  final List socialList;

  const AddNewSocialLinksBottomSheet({Key? key, required this.socialList}) : super(key: key);

  @override
  _AddNewSocialLinksBottomSheetState createState() => _AddNewSocialLinksBottomSheetState(socialList);
}

class _AddNewSocialLinksBottomSheetState extends State<AddNewSocialLinksBottomSheet> {
  final List socialList;
  List<String> _socialDropDownAvailableValue = ['instagram', 'facebook', 'tweeter', 'LinkedIn'];
  String _dropDownIconValue = 'instagram';
  TextEditingController linkController = TextEditingController();

  _AddNewSocialLinksBottomSheetState(this.socialList);
  @override
  Widget build(BuildContext context) {
    
    

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      height: 200,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: DropdownButton<String>(
                    value: _dropDownIconValue,
                    icon: Icon(LineIcons.angleDown),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropDownIconValue = newValue!;
                      });
                    },
                    items:_socialDropDownAvailableValue.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          setState(() {
                            _dropDownIconValue = value;
                          });
                        },
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              Expanded(
                child: TextField(
                  controller: linkController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.yellow, style: BorderStyle.solid, width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                FirestoreServiceDB().addNewSocialLink(_dropDownIconValue, linkController.text, socialList);
                Get.back();
              },
              child: Text('اضافه کن'))
        ],
      ),
    );
  }
}
