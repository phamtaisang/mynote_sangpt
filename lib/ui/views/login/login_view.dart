import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynote/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return ViewModelBuilder<LoginViewModel>.reactive(
      // onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(title: Text("")),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Đăng nhập hệ thống ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Tên đăng nhập',
                      ),
                      controller: model.username),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Mật khẩu',
                    ),
                    controller: model.password,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  FlatButton(
                    onPressed: () {
                      model.handleLogin(context);
                    },
                    color: Colors.orange,
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Đăng nhập",
                    ),
                  )
                ],
              )
            ],
          )),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

// class LoginView extends ViewModelWidget<LoginViewModel> {
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context, model) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Truy cập hệ thống'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Đăng nhập hệ thống "),
//             // TextFormField(
//             //     decoration: InputDecoration(
//             //       hintText: 'Tên đăng nhập',
//             //     ),
//             //     controller: model.username),
//             // SizedBox(height: 20),
//             // TextFormField(
//             //   decoration: InputDecoration(
//             //     hintText: 'Mật khẩu',
//             //   ),
//             //   controller: model.password,
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }
