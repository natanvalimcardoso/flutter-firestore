import 'package:flutter/material.dart';

class CardFirebaseWidget extends StatelessWidget {
  final String name;
  final String email;
  final int age;
  final Function()? deletePeopleOnTap;
  final Function()? editPeopleOnTap;
  const CardFirebaseWidget({
    Key? key,
    required this.name,
    required this.email,
    required this.age,
    required this.deletePeopleOnTap,
    required this.editPeopleOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: editPeopleOnTap,
      child: Card(
        child: SizedBox(
          height: 80,
          child: Column(
            children: [
              Container(
                height: 25,
                color: Color.fromARGB(255, 39, 39, 39),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Nome',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 105),
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 70),
                      child: Text(
                        'Idade',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    width: 85,
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 160,
                    alignment: Alignment.center,
                    child: Text(
                      email,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    width: 30,
                    alignment: Alignment.center,
                    child: Text(
                      age.toString(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: IconButton(
                      onPressed: deletePeopleOnTap,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
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
