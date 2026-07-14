import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 350,
            height: 420,
            child: Card(
              elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.green.shade100,
                      child: Icon(Icons.check),
                    ),
                    const SizedBox(height: 25),
                    Text('Order Placed Successfully'),
                    SizedBox(height: 20,),
                    Text('Thank you for your shopping!'),
                    SizedBox(height: 20,),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white
                      ),
                        onPressed: (){
                      Navigator.popUntil(context, (predicate) => predicate.isFirst);
                    }, child: Text('Continue Shopping'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
