# mynote

## Bài thu hoạch :  Xây dựng ứng dụng Note
#### Họ tên : Phạm Tài Sang
#### MSV    : 1621050274
### Mô tả quá trình xây dựng các chức năng của ứng dụng Note

1. Hiển thị giao diện Note View Model.
1. Tạo chức năng thêm ghi chú.
1. Tạo chức năng sửa ghi chú.
1. Tạo chức năng xóa ghi chú.
1. Hiển thị chi tiết ghi chú.

### Mã nguồn **login_view.dart** : hiển thị form đăng nhập
```
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

```
### Mã nguồn **login_viewmodel.dart** : chức năng đăng nhập

```
import 'package:mynote/ui/views/login/login_view.dart';
import 'package:mynote/ui/views/note/note_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'login_model.dart';

/// Trạng thái của view

class LoginViewModel extends BaseViewModel {
  var username = TextEditingController();
  var password = TextEditingController();
  // Người đăng nhập hiện tại
  static Login userCurrent;

  void handleLogin(context) {
    if (username.text == "admin" && password.text == "password") {
      userCurrent = Login("id", username.text, password.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoteView()),
      );
    }
  }
  static void handleLogout(context) {
    userCurrent = null;
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
  }
}

```
- Kết quả:

![Alt text](image/kq1.png?raw=true "ket qua")

### Mã nguồn **note_view.dart** : hiển thị và thêm ghi chú

```
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynote/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:mynote/ui/views/note/widgets/note_view_item.dart';
import 'package:mynote/ui/views/note/widgets/note_view_item_edit.dart';
import 'note_model.dart';
import 'note_viewmodel.dart';

class NoteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NoteViewModel>.reactive(
      onModelReady: (model) => model.init(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(model.title),
          actions: [
            IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () => {
                LoginViewModel.handleLogout(context)
              },
            )
          ],
        ),
        body: Stack(
          children: [
            model.state == NoteViewState.listView
                ? ListView.builder(
                    itemCount: model.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      Note item = model.items[index];
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.desc),
                        onTap: () {
                          model.editingItem = item;
                          model.state = NoteViewState.itemView;
                        },
                      );
                    },
                  )
                : model.state == NoteViewState.itemView
                    ? NoteViewItem()
                    : model.state == NoteViewState.updateView
                        ? NoteViewItemEdit()
                        : SizedBox(),
          ],
        ),
        floatingActionButton: model.state == NoteViewState.listView
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  model.addItem();
                },
              )
            : null,
      ),
      viewModelBuilder: () => NoteViewModel(),
    );
  }
}

```

### Mã nguồn **note_viewmodel.dart**

```
import 'package:flutter/material.dart';

class Note {
  /// id tự sinh ra ngẫu nhiên
  String id = UniqueKey()
      .hashCode
      .toUnsigned(20)
      .toRadixString(16)
      .padLeft(5, '0');

  String title;
  String desc;
  bool isDeleted = false;

  Note(this.title, this.desc);
  

  /// Tên của bảng CSDL, nó nên được gán sẵn và có thể lấy ra từ data
  /// model mà không cần khởi tạo nên nó là static để dễ sử dung.
  static String get tableName => 'Notes';

  /// Chuỗi lệnh SQL để tạo bảng CSDL, nó nên được thiết lập để tạo bảng
  /// trong CSDL mà không cần khởi tạo nên nó là static để dễ sử dụng.
  static String get createTable =>
      'CREATE TABLE $tableName(`id` TEXT PRIMARY KEY,'
      ' `title` TEXT,'
      ' `desc` TEXT,'
      ' `isDeleted` INTEGER DEFAULT 0)';

  /// Phương thức này được thiết lập để tạo nên danh sách các ghi chú
  /// được lấy về từ CSDL, nó được tạo dưới dạng danh sách các ghi chú
  /// theo cấu trúc Map mà không cần khởi tạo đối tượng nên nó là static.
  static List<Note> fromList(List<Map<String, dynamic>> query) {
    List<Note> items = List<Note>();
    print("items" + items.toString());
    for (Map map in query) {
      items.add(Note.fromMap(map));
    }
    return items;
  }

  /// Hàm tạo có tên, đây là một hàm tạo từ đối số là dữ liệu đưa vào
  /// dưới dạng Map
  Note.fromMap(Map data)
      : id = data['id'],
        title = data['title'],
        desc = data['desc'],
        isDeleted = data['isDeleted'] == 1 ? true : false;

  /// Phương thức của đối tượng, nó cho phép tạo ra dữ liệu dạng Map từ
  /// dữ liệu của một đối tượng ghi chú.
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'desc': desc,
        'isDeleted': isDeleted ? 1 : 0,
      };
}

```

- Kết quả:

![Alt text](image/kq2.png?raw=true "ket qua 2")

### Mã nguồn **note_view_item_edit.dart:** : Chức năng chỉnh sửa ghi chú

```
import 'package:flutter/material.dart';
import 'package:mynote/ui/views/note/note_model.dart';
import 'package:mynote/ui/views/note/note_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NoteViewItemEdit extends ViewModelWidget<NoteViewModel> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, model) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật ${model.editingItem.id}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => model.state = NoteViewState.listView,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => model.saveItem(),
          )
        ],
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ID:" +model.editingItem.id),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nhập tiêu đề',
                  ),
                  controller: model.editingControllerTitle),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Nhập mô tả',
                ),
                controller: model.editingControllerDesc,
              )
            ],
          )),
    );
  }
}


```

- Kết quả:

![Alt text](image/kq3.png?raw=true "ket qua 3")

### Mã nguồn **note_view_item.dart:** : Hiển thị chi tiết ghi chú

```
import 'package:flutter/material.dart';
import 'package:mynote/ui/views/note/note_model.dart';
import 'package:mynote/ui/views/note/note_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NoteViewItem extends ViewModelWidget<NoteViewModel> {
  @override
  Widget build(BuildContext context, model) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết ${model.editingItem.id}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => model.state = NoteViewState.listView,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => model.updateItem()),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => model.deleteItem())
        ],
      ),
      body: Center(
        child: ListTile(
          title: Text(model.editingItem.title),
          subtitle: Text(model.editingItem.desc),
        ),
      ),
    );
  }
}

```

- Kết quả:

![Alt text](image/kq4.png?raw=true "ket qua 4")

