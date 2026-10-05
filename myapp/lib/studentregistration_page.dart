  import 'package:flutter/material.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';

  class StudentRegistrationPage extends StatefulWidget {
    const StudentRegistrationPage({super.key});

    @override
    State<StudentRegistrationPage> createState() => _StudentRegistrationPageState();
  }

    class _StudentRegistrationPageState extends State<StudentRegistrationPage>{
    final TextEditingController nameController = TextEditingController();
    final TextEditingController courseController = TextEditingController();
    final TextEditingController sectionController = TextEditingController();
    final TextEditingController yearlevelController = TextEditingController();
    final TextEditingController subject1Controller = TextEditingController();
    final TextEditingController schedule1Controller = TextEditingController();
    final TextEditingController subject2Controller = TextEditingController();
    final TextEditingController schedule2Controller = TextEditingController();
    final TextEditingController subject3Controller = TextEditingController();
    final TextEditingController schedule3Controller = TextEditingController();
    
    int step = 0;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<void> saveData() async{
      if(nameController.text.trim().isEmpty || courseController.text.trim().isEmpty || sectionController.text.trim().isEmpty ||
      yearlevelController.text.trim().isEmpty || subject1Controller.text.trim().isEmpty ||
      schedule1Controller.text.trim().isEmpty || subject2Controller.text.trim().isEmpty || schedule2Controller.text.trim().isEmpty ||
      subject3Controller.text.trim().isEmpty || schedule3Controller.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Fill in all fields'))
        );
        return;
      }
    
    await firestore.collection('Students').add({
      'name': nameController.text.trim(),
      'course': courseController.text.trim(),
      'section': sectionController.text.trim(),
      'yearlevel': yearlevelController.text.trim(),
      'subject1': subject1Controller.text.trim(),
      'schedule1': schedule1Controller.text.trim(),
      'subject2': subject2Controller.text.trim(),
      'schedule2': schedule2Controller.text.trim(),
      'subject3': subject3Controller.text.trim(),
      'schedule3': schedule3Controller.text.trim(),
    });

  ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data Save Successfully')));

    nameController.clear();
    courseController.clear();
    sectionController.clear();
    yearlevelController.clear();
    subject1Controller.clear();
    schedule1Controller.clear();
    subject2Controller.clear();
    schedule2Controller.clear();
    subject3Controller.clear();
    schedule3Controller.clear();
    }

    @override
    void dispose() {
    nameController.dispose();
    courseController.dispose();
    sectionController.dispose();
    yearlevelController.dispose();
    subject1Controller.dispose();
    schedule1Controller.dispose();
    subject2Controller.dispose();
    schedule2Controller.dispose();
    subject3Controller.dispose();
    schedule3Controller.dispose();
    super.dispose();
    }

    Widget field(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(step == 0 ? 'Student Form (1/2)' : 'Student Schedule (2/2)'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (step == 0) ...[
              field(nameController, 'Name'),
              field(courseController, 'Course'),
              field(sectionController, 'Section'),
              field(yearlevelController, 'Year Level'),
              ElevatedButton(
                onPressed: () => setState(() => step = 1),
                child: const Text('Next'),
              ),
            ] else ...[
              field(subject1Controller, 'Subject'),
              field(schedule1Controller, 'Schedule'),
              field(subject2Controller, 'Subject'),
              field(schedule2Controller, 'Schedule'),
              field(subject3Controller, 'Subject'),
              field(schedule3Controller, 'Schedule'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () => setState(() => step = 0),
                    child: const Text('Back'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(onPressed: saveData,
                  child: const Text('Save to Firebase')
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
  }