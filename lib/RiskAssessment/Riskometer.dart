import 'package:flutter/material.dart';
class Riskometer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Risk Profile',
      theme: ThemeData.dark(), // Using a dark theme
      home: RiskProfileWidget(), // Your Risk Profile widget
    );
  }
}
class RiskProfileWidget extends StatefulWidget {
  @override
  _RiskProfileWidgetState createState() => _RiskProfileWidgetState();
}

class _RiskProfileWidgetState extends State<RiskProfileWidget> {
  // Current risk level
  String riskLevel = "Moderate";

  // Function to handle Retake button press
  void _retake() {
    setState(() {
      riskLevel = "Conservative"; // Example reset to default
    });
  }

  // Function to handle Close button press
  void _close() {
    // Add your close functionality here
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Match dark theme
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900], // Card background
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blueAccent),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                "Your Risk Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 70),

              // Gauge/Dial
              Stack(
                alignment: Alignment.center,
                children: [
                  // Circular sectors
                  CustomPaint(
                    size: Size(200, 100),
                    painter: GaugePainter(),
                  ),
                  // Needle
                  Transform.rotate(
                    angle: 0.0, // Adjust this value to point to different sections
                    child: Container(
                      width: 4,
                      height: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Current Risk Level
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  riskLevel,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Description
              Text(
                "Balancing growth and stability with up to 40% equity, this portfolio provides controlled risk and moderate returns. Suited for medium-term investors.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _retake,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Retake",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _close,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.white),
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

class GaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;

    final double gap = 0.03; // Small gap between each section
    final double arcLength = 3.14 / 5 - gap; // Reduced arc length to accommodate gaps

    // Draw each section with a gap
    paint.color = Colors.green; // Conservative
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      3.14,
      arcLength,
      false,
      paint,
    );

    paint.color = Colors.yellow; // Moderate
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      3.14 + (arcLength + gap),
      arcLength,
      false,
      paint,
    );

    paint.color = Colors.orange; // Moderately Aggressive
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      3.14 + 2 * (arcLength + gap),
      arcLength,
      false,
      paint,
    );

    paint.color = Colors.red; // Aggressive
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      3.14 + 3 * (arcLength + gap),
      arcLength,
      false,
      paint,
    );

    paint.color = Colors.purple; // Very Aggressive
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      3.14 + 4 * (arcLength + gap),
      arcLength,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

