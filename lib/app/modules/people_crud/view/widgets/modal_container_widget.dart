import 'package:flutter/material.dart';

class ModalContainerWidget extends StatelessWidget {
  final Function() onTap;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController ageController;
  const ModalContainerWidget({
    Key? key,
    required this.onTap,
    required this.nameController,
    required this.emailController,
    required this.ageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: 'Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: ageController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: 'Age',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: SizedBox(
            width: 200,
            child: ElevatedButton(onPressed: onTap, child: const Text('Enviar')),
          ),
        )
      ],
    );
  }
}
