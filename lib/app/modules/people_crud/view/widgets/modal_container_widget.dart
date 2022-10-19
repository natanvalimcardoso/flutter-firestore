import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class ModalContainerWidget extends StatelessWidget {
  final Function() onTap;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController ageController;
  final GlobalKey<FormState> formKey;
  final String title;
  ModalContainerWidget({
    Key? key,
    required this.onTap,
    required this.nameController,
    required this.emailController,
    required this.ageController,
    required this.title,
    required this.formKey,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: Validatorless.multiple([
                Validatorless.required('Name is required'),
                Validatorless.min(3, 'Name must be at least 3 characters'),
                Validatorless.max(20, 'Name must be at most 20 characters'),
              ]),
              // textInputAction: TextInputAction.next,
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
              validator: Validatorless.multiple([
                Validatorless.required('Email is required'),
                Validatorless.email('Invalid email'),
              ]),
              // textInputAction: TextInputAction.next,
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
              keyboardType: TextInputType.number,
              validator: Validatorless.multiple([
                Validatorless.required('Age is required'),
              ]),
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
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: onTap,
                child: const Text('Enviar'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
