import 'package:flutter/material.dart';

class EnterPassword extends StatelessWidget {
  final int pass;
  const EnterPassword({Key? key, required this.pass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? enteredPass;
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Container(
          padding: const EdgeInsets.all(20),
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                obscureText: true,
                onChanged: (value) {
                  enteredPass = value == '' ? 0 : int.parse(value);
                },
                validator: (value) =>
                    value!.isEmpty ? 'Enter your password' : null,
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.all(10),
                  labelText: 'Enter Your Password',

                  filled: true,
                  fillColor: const Color.fromARGB(40, 235, 167, 247),
                  labelStyle:
                      TextStyle(color: Theme.of(context).primaryColorDark),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColorDark),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColorDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // _savePassword();
                  if (pass == enteredPass) {
                    Navigator.of(context).pushReplacementNamed('private');
                  } else {
                    showDialog(
                        //* we can not click anywhere outside the dialog
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Wrong Password'),
                            content: const Text('are you sure, TRY AGAIN?'),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red[900],
                                ),
                              ),
                            ],
                          );
                        });
                  }
                },
                child: const Text(
                  'Enter',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
