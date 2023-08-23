import 'package:flutter/material.dart';
import 'userInfo.dart';
import 'userCard.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';
import 'sqldb.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  
  final SqlDb sqlDb = SqlDb(); 
  List<UserInfo> users = [];


  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    List<UserInfo> userList = await sqlDb.getUsers();
    setState(() {
      users = userList;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void removeFromList(String id) {
    setState(() {
      users.removeWhere((user) => user.id == id);
    });
  }

  void _showValidationError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    
    String generateRandomId() {
      var uuid = Uuid();
      return uuid.v4().substring(0, 10);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Peronsal Informations',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, int index) {
                var user = users[index];
                String randomId = generateRandomId();
                return UserCard(
                  userInfo: user,
                  onDelete: () => removeFromList(user.id), 
                );
              },
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(labelText: 'First Name'),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(labelText: 'Last Name'),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            // onPressed: () => _selectDate(context),
                            onPressed: ()async{
                              await  _selectDate(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: Text('Select Date of Birth'),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () async{
                              if (_firstNameController.text.length < 2) {
                                _showValidationError(
                                    'First name must be at least 2 characters long.');
                                return;
                              }

                              if (_lastNameController.text.length < 2) {
                                _showValidationError(
                                    'Last name must be at least 2 characters long.');
                                return;
                              }

                              if (_selectedDate == null) {
                                _showValidationError('Please select a date of birth.');
                                return;
                              }
                              UserInfo newUser = UserInfo(
                                generateRandomId(),
                                _firstNameController.text,
                                _lastNameController.text,
                                _selectedDate,
                              );
                              await sqlDb.insertUser(newUser); //insert in database
                              setState(() {
                                users.add(newUser);
                              });
                              Navigator.of(context).pop();
                            },
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
