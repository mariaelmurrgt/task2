import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'userInfo.dart';
import 'package:intl/intl.dart';
import 'sqldb.dart';
import 'page1.dart';


class UserCard extends StatefulWidget {
  final UserInfo userInfo;
  final VoidCallback onDelete;

  UserCard({required this.userInfo,required this.onDelete});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final SqlDb sqlDb = SqlDb();
  

  @override
  Widget build(BuildContext context) {
    
    String formattedDate = DateFormat('yyyy/MM/dd').format(widget.userInfo.dateOfBirth);
    return Card(
      child: Container(
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  widget.userInfo.fname[0].toUpperCase()+widget.userInfo.lname[0].toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ), 
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${widget.userInfo.fname} ${widget.userInfo.lname}'),
                  Text('Date of Birth: ${formattedDate}'),
                ],
              ),
              SizedBox(width:16),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(12),
                    child: IconButton(
                      onPressed: () async{
                        await sqlDb.deleteUser(widget.userInfo.id);
                        widget.onDelete();
                      }, 
                      icon: Icon(
                        Icons.delete,
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
