import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPassword extends StatelessWidget {
  // SharedPreferences pass;
  int? _pass;
  // NewPassword({Key? key, required this.pass}) : super(key: key);
  void _savePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('password', _pass!);
  }

  @override
  Widget build(BuildContext context) {
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
                    _pass = int.parse(value);
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Enter your password' : null,
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.all(10),
                    labelText: 'Enter Your New Password',
                    filled: true,
                    fillColor: const Color.fromARGB(50, 235, 167, 247),
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
                    _savePassword();
                    Navigator.of(context).pushReplacementNamed('private');
                  },
                  child: const Text(
                    'Enter',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
