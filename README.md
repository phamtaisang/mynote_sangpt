# mynote
Xây dựng ứng dụng Note
(Đây là phần thực hành của nội dung chương 4 trong học phần *Phát triển ứng dụng đa nền tảng* đang được giảng dạy tại Khoa Công nghệ thông tin của Trường Đại học Mỏ - Địa chất)

## Bắt đầu
### bài thu hoạch
    msv     : 1621050274
    họ tên : Phạm Tài Sang
    lớp       : CNPM-D-K61

### Tạo một kho lưu trữ
Bài viết này sử dụng kho lưu trữ mẫu (template) GitHub để giúp bạn dễ dàng bắt đầu. Mẫu có một ứng dụng web tĩnh rất đơn giản để chúng ta có thể sử dụng như một điểm khởi đầu.

> 1. Đảm bảo rằng bạn đã đăng nhập vào GitHub và điều hướng đến vị trí sau để tạo một kho lưu trữ mới:
https://github.com/chuyentt/mynote/generate - nếu liên kết không hoạt động, vui lòng đăng nhập vào GitHub và thử lại.
> 2. Đặt tên cho Repository name (kho lưu trữ mã nguồn) của bạn là:
`mynote`

Chọn **`Create repository from template`**.

### Sao chép kho lưu trữ
Với kho lưu trữ được tạo trong tài khoản GitHub của bạn, hãy sao chép dự án vào máy cục bộ của bạn bằng lệnh sau với công cụ giao tiếp dòng lệnh `Command Prompt` trên Windows hoặc `terminal` trên macOS.
`git clone https://github.com/<YOUR_ACCOUNT_NAME>/mynote.git`

Hoặc sao chép nó về bằng công cụ `Visual Studio Code` bằng cách đi đến menu *`View > Command Palette...`* rồi nhập `Git: Clone` sau đó cung cấp URL của kho lưu trữ hoặc chọn nguồn kho lưu trữ `https://github.com/<YOUR_ACCOUNT_NAME>/mynote.git`.

### Code Mẫu phần Note

## note_model

```dart
class Note {
  final String title;
  final String desc;

  Note(this.title, this.desc);

}
```

## note_viewmodel
```dart
import 'package:stacked/stacked.dart';

class NoteViewModel extends BaseViewModel {
  final title = "Note View Model";
}
```

## note_view
```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab42/ui/views/note/note_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NoteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoteViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(model.title),
        ),
        body: Center(
          child: Text("Hello My"),
        ),
      ),
      viewModelBuilder: () => NoteViewModel(),
    );
  }
}
```

## main
```dart
import 'package:flutter/material.dart';
import 'package:lab42/ui/views/note/note_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteView(),
    );
  }
}

```

### kết quả

#### 1.màn hình login

![Alt text](image/kq1.png?raw=true "ket qua 1")

#### 2.danh sách ghi chú

![Alt text](image/kq2.png?raw=true "ket qua 2")

### 3.chi tiết ghi chú

![Alt text](image/kq3.png?raw=true "ket qua 3")
