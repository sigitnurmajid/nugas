import 'package:flutter/material.dart';
import 'package:nugas/db/tasksdatabase.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nugas/onboarding.dart';
import 'package:table_calendar/table_calendar.dart';
import 'models/tasks.dart';
import 'newnotepage.dart';
import 'newtaskpage.dart';
import 'checklistpage.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePages(),
    );
  }
}

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List<Task> tasks;
  String filterType = 'today';
  CalendarController ctrlr = new CalendarController();
  DateTime today = new DateTime.now();
  var monthNames = ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEPT','OKT','NOV','DEC'];
  String taskPop = 'close';
  bool isLoading = false;


  @override
  void initState (){

    super.initState();
    refreshTasks();
  }

  @override

  void dispose(){
    TasksDatabase.instance.close();

    super.dispose();
  }

  Future refreshTasks() async{
    setState(() { isLoading = true; });
    this.tasks = await TasksDatabase.instance.readTasks();
    setState(() { isLoading = false; });
  }

  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                centerTitle: true,
                backgroundColor: Colors.red[400],
                elevation: 0,
                title: Text('Tasks List', style: TextStyle(
                  fontSize: 23
                ),),
                actions: [
                  IconButton(
                    icon: Icon(Icons.short_text,
                    color: Colors.white,
                    size: 30,
                    ),
                    onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=> OnBoarding()));},
                  )
                ],
              ),
              Container(
                height: 70,
                color: Colors.red[400],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){changeFilter('today');},
                          child: Text('Today', style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 4,
                          width: 120,
                          color: (filterType == 'today') ? Colors.white : Colors.transparent,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){changeFilter('monthly');},
                          child: Text('Monthly', style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 4,
                          width: 120,
                          color: (filterType == 'monthly') ? Colors.white : Colors.transparent,
                        )
                      ],
                    )
                  ],
                ),
              ),
              (filterType == 'monthly')? TableCalendar(
                calendarController: ctrlr,
                startingDayOfWeek: StartingDayOfWeek.monday,
                initialCalendarFormat: CalendarFormat.week,
              ) : Container(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Today ${monthNames[today.month-1]}, ${today.day}/${today.year}', style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey
                            ),)
                          ],
                        ),
                      ),
                      for (var i in tasks ) taskWidget(Colors.red[400] , i.title, i.date.toString().substring(0,11), i.id)
                      
                    ],
                  ),
                )
              ),
              Container(
                height: 110,
                child: Stack(
                  children: [
                    // Positioned(
                    //   bottom: 0,
                    //   child: Container(
                    //     height: 90,
                    //     width: MediaQuery.of(context).size.width,
                    //     color: Colors.blueGrey[900],
                    //     padding: EdgeInsets.all(15),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         Container(
                    //           child: Column(
                    //             children: [
                    //               Icon(
                    //                 Icons.check_circle,
                    //                 color: Colors.white,
                    //               ),
                    //               SizedBox(height: 5,),
                    //               Text('My Task', style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 15
                    //               ),),
                    //             ],
                    //           ),
                    //         ),
                    //         Container(
                    //           child: Column(
                    //             children: [
                    //               Icon(
                    //                 Icons.menu,
                    //                 color: Colors.white,
                    //               ),
                    //               SizedBox(height: 5,),
                    //               Text('Menu', style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 15
                    //               ),),
                    //             ],
                    //           ),
                    //         ),
                    //         Container(width: 80),
                    //         Container(
                    //           child: Column(
                    //             children: [
                    //               Icon(
                    //                 Icons.content_paste,
                    //                 color: Colors.white,
                    //               ),
                    //               SizedBox(height: 5,),
                    //               Text('Quick', style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 15
                    //               ),),
                    //             ],
                    //           ),
                    //         ),
                    //         Container(
                    //           child: Column(
                    //             children: [
                    //               Icon(
                    //                 Icons.account_circle,
                    //                 color: Colors.white,
                    //               ),
                    //               SizedBox(height: 5,),
                    //               Text('Profile', style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 15
                    //               ),),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      bottom: 25,
                      left: 0,
                      right: 0,
                      child: InkWell(
                        onTap: openTaskPop,
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.red[300], Colors.red[400]]
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: 
                              Text('+', style: TextStyle(
                                fontSize: 40,
                                color: Colors.white
                              ),),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            child: ( taskPop =='open' ) ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: InkWell(
                  onTap: closeTaskPop,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white
                    ),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(height: 1,),
                        InkWell(
                          onTap: openNewTask,
                          child: Text('Add Task', style: TextStyle(
                            fontSize: 18
                          ),),
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.black.withOpacity(0.2),
                        ),
                        InkWell(
                          onTap: openNewNote,
                          child: Text('Add Quick Note', style: TextStyle(
                            fontSize: 18
                          ),),
                        ),
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          color: Colors.black.withOpacity(0.2),
                        ),
                        InkWell(
                          onTap: openNewChecklist,
                          child: Text('Add Checklist', style: TextStyle(
                            fontSize: 18
                          ),),
                        ),
                        SizedBox(height: 1,)
                      ],
                    ),
                  ),
                ),
              ),
            ) : Container(),
          )
        ],
      ),
    );
  }

  openTaskPop(){
    taskPop = 'open';
    setState(() {
          
    });
  }

  closeTaskPop(){
    taskPop = 'close';
    setState(() {
          
    });
  }

  changeFilter(String filter){
    filterType = filter;
    setState(() {
          
    });
  }

  openNewTask(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> NewTask()));
  }

  openNewNote(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> NewNote()));
  }

  openNewChecklist(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> CheckList()));
  }

  Container taskWidget(Color color, String title, String time, int id){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Slidable(
        
        child: Container(
          height: 100,
          // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.05),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color,
                  width: 4
                  )
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                  ),),
                  Text(time, style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),)
                ],
              ),
            ],
          ),
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) => {print(context.owner.toString())},
              backgroundColor: Colors.blue,
              icon: Icons.edit,
              label: 'Edit',
            ),
            SlidableAction(
              onPressed: (BuildContext context) async => { 
                await TasksDatabase.instance.delete(id),
                await refreshTasks(),
              } ,
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
      ),
    );
  }
}
