import 'package:flutter/material.dart';

import '../../styles/app_size.dart';
import '../../utils/get_util.dart';


class UnknownScreen extends StatefulWidget {
  const UnknownScreen({super.key});

  @override
  UnknownScreenState createState() => UnknownScreenState();
}

class UnknownScreenState extends State<UnknownScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/images/image_404.png')
          ),
          Positioned(
            right: 0,
            child: SafeArea(
              minimum: EdgeInsets.all(
                AppSize.size_4,
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                    size: AppSize.size_24,
                  ),
                  onPressed: () {
                    GetUtil.back();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
