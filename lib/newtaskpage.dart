import 'package:flutter/material.dart';
import 'package:nugas/db/tasksdatabase.dart';
import 'package:nugas/models/tasks.dart';
import 'homepage.dart';

class NewTask extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewTasks(),
    );
  }
}

class NewTasks extends StatefulWidget {

  @override
  _NewTasksState createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  String title;
  String color = 'red';
  String type = 'task';
  String date = '';

  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){return Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));} ,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red[400],
          elevation: 0,
          title: Text('New Task', style: TextStyle(
            fontSize: 23
          ),),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));},
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: 30,
                color: Colors.red[400],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Colors.white
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.85,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('For', style: TextStyle(
                            fontSize: 18
                          ),),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey.withOpacity(0.2)
                            ),
                            child: Text('Asignee', style: TextStyle(
                              fontSize: 18
                            ),),
                          ),
                          SizedBox(width: 10),
                          Text('In', style: TextStyle(
                            fontSize: 18
                          ),),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.grey.withOpacity(0.2)
                            ),
                            child: Text('Course', style: TextStyle(
                              fontSize: 18
                            ),),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.grey.withOpacity(0.2),
                        child: TextField(
                          onChanged: (title) => setState(()=>this.title = title),
                          decoration: InputDecoration(
                            hintText: 'Title',
                            border: InputBorder.none
                          ),
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description', style: TextStyle(
                              fontSize: 18
                            ),),
                            SizedBox(height: 10,),
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15)
                                ),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)
                                )
                              ),
                              child: TextField(
                                maxLines: 6,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add description here'
                                ),
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: IconButton(
                                      icon: Icon(Icons.attach_file, color: Colors.grey,),
                                      onPressed: (){},
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey.withOpacity(0.2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () => _selectDate(context),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.red[400])
                                    ),
                                    child: Text(
                                      'Select date',
                                      style:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  ),
                                  Text(
                                    "${selectedDate.toLocal()}".split(' ')[0],
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              )
                            ),
                            SizedBox(height: 20,),
                            Text('Add member',style: TextStyle(
                              fontSize: 18
                            ),),
                            SizedBox(height: 20,),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey.withOpacity(0.2)
                              ),
                              child: Text('Anyone', style: TextStyle(
                                fontSize: 18
                              ),),
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              width: double.infinity,
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.red[400]
                              ),
                              child: InkWell(
                                onTap: addTask,
                                child: Center(
                                  child: Text('Add Task',style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18
                                  ),),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
  _selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
    });
  }

  Future addTask() async {
    final task = Task(
      title: this.title,
      date: selectedDate,
      color: color,
      type: type,
    );

    try {
      TasksDatabase.instance.create(task);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
    } catch (e) {
      print(e);
    }
  }
}