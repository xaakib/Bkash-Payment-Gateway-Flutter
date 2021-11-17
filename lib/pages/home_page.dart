import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'bkash_payment.dart';

enum Intent { sale, authorization }

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key,  this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _amountController = TextEditingController();

  Intent _intent = Intent.sale;
   FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(80, 40, 80, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Amount :'),
            TextField(
              focusNode: focusNode,
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                hintText: "15000",
              ),
            ),
            const SizedBox(height: 100.0),
            ListTile(
              title: const Text('Immediate'),
              leading: Radio(
                value: Intent.sale,
                groupValue: _intent,
                onChanged: (value) {
                  // setState(() => _intent = value);
                },
              ),
              dense: true,
            ),
            ListTile(
              title: const Text('Auth and Capture'),
              leading: Radio(
                value: Intent.authorization,
                groupValue: _intent,
                onChanged: (value) {
                  // setState(() => _intent = value);
                },
              ),
              dense: true,
            ),
            const SizedBox(height: 6.0),
            FlatButton(
              height: 30.0,
              minWidth: double.infinity,
              color: Colors.pinkAccent,
              textColor: Colors.white,
              child: Text("Checkout"),
              onPressed: () {
                String amount = _amountController.text.trim();
                String intent =
                    _intent == Intent.sale ? "sale" : "authorization";

                if (amount.isEmpty) {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text(
                          "Amount is empty. You can't pay through bkash. Try again")));
                  return;
                }
                // remove focus from TextField to hide keyboard
                focusNode.unfocus();
                // Goto BkashPayment page & pass the params
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        BkashPayment(amount: amount, intent: intent)));
              },
            )
          ],
        ),
      ),
    );
  }
}
