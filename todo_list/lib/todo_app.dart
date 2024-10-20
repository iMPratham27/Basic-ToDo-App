import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/todo_model.dart';

class ToDoApp extends StatefulWidget{

  const ToDoApp({super.key});

  @override   
  State createState() => _ToDoAppState();
}

class _ToDoAppState extends State{

  ///Task list
  List<TodoModel> taskList = [];

  /// Colors list
  List<Color> cardColors = const[
    Color.fromRGBO(250, 232, 232, 1),
    Color.fromRGBO(232, 237, 250, 1),
    Color.fromRGBO(250, 249, 232, 1),
    Color.fromRGBO(250, 232, 250, 1),
    
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  /// clear controllers for new values
  void clearControllers(){
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  ///SUBMIT DATA
  void submitData(bool doEdit,[TodoModel? obj]){
    
    if(titleController.text.trim().isNotEmpty && descriptionController.text.trim().isNotEmpty && dateController.text.trim().isNotEmpty){

      if(doEdit){
        obj?.title = titleController.text;
        obj?.description = descriptionController.text;
        obj?.date = dateController.text;
        
      }else{
        taskList.add(TodoModel(title: titleController.text, description: descriptionController.text, date: dateController.text));
      }
      clearControllers();
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  ///bottomsheet - to add new task
  void showBottomSheet(bool isEdit,[TodoModel? bobj]){
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder:(context){
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8,),
          
              Text(
                "Create To-Do",
                style: GoogleFonts.quicksand(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
          
              const SizedBox(height: 12,),
          
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Title: ",
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(0, 139, 148, 1),
                    ),
                  ),
                  
                  const SizedBox(height: 5,),
                  
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 7,),

                  Text(
                    "Description: ",
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(0, 139, 148, 1),
                    ),
                  ),
                  
                  const SizedBox(height: 5,),
                  
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 7,),

                  Text(
                    "Date: ",
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(0, 139, 148, 1),
                    ), 
                  ),
                  
                  const SizedBox(height: 5,),
                  
                  TextField(
                    controller: dateController,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_month_outlined),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 139, 148, 1),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20,),
              
              ///SUBMIT BUTTON
              GestureDetector(
                onTap: () {
                  if(isEdit){
                    submitData(true,bobj);
                  }else{
                    submitData(false);
                  }
                },

                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromRGBO(0, 139, 148, 1),
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20,),

            ],
          ),
        );
      } 
    );
  }

  @override  
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "To-Do List",
          style: GoogleFonts.quicksand(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
      ),

      body: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: cardColors[index%cardColors.length],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Image.asset(
                            "./assets/Group42.png",
                          ),
                        ),
                        
                        const SizedBox(width: 10,),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              ///TITLE
                              Text(
                                taskList[index].title,
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              
                              const SizedBox(height: 5,),
                              
                              ///DESCRIPTION
                              Text(
                                taskList[index].description,
                                style: GoogleFonts.quicksand(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(84, 84, 84, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10,),

                    Row(
                      children: [
                        
                        ///DATE
                        Text(
                          taskList[index].date,
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(132, 132, 132, 1),
                          ),
                        ),
                        
                        const Spacer(),
                        
                        Row(
                          children: [
                            
                            ///EDIT
                            GestureDetector(
                              onTap: () {
                                titleController.text = taskList[index].title;
                                descriptionController.text = taskList[index].description;
                                dateController.text = taskList[index].date;
                                showBottomSheet(true,taskList[index]);
                              },

                              child: const Icon(
                                Icons.edit,
                                size: 22,
                                color: Color.fromRGBO(0, 139, 148, 1),
                              ),
                            ),
                            
                            const SizedBox(width: 5,),
                            
                            ///DELETE
                            GestureDetector(
                              onTap: () {
                                taskList.removeAt(index);
                                setState(() {});
                              },

                              child: const Icon(
                                Icons.delete_outline_outlined,
                                size: 22,
                                color: Color.fromRGBO(0, 139, 148, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      

      ///Add Task button
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showBottomSheet(false);
        },
        backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}