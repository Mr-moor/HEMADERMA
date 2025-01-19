import 'package:flutter/material.dart';
import 'package:hemaderma/hematocrit_page.dart';
import 'package:hemaderma/dermatology_page.dart';

class NewHealthBlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Blogs'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HematocritPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/hemotocrit.png', // Update with your image path
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(width: 15), // Add consistent spacing
                        Text(
                          'Hematocrit (Blood)',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Divider(thickness: 1), // Add a divider for better separation
            SizedBox(height: 20), // Add spacing between sections
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DermatologyPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/dermatology.jpg', // Update with your image path
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(width: 15), // Add consistent spacing
                        Text(
                          'Dermatology (Skin)',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}
