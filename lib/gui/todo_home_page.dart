import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/gui/todo_home_page_view_model.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/theme/custom_theme.dart';

class TodoHomePage extends StatefulWidget {
  @override
  State createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<TodoHomePageViewModel>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo application'),
      ),
      body: _todoListView(),
    );
  }

  Widget _todoListView() {
    return Consumer<TodoHomePageViewModel>(
      builder: (_, viewModel, __) {
        final items = viewModel.todoItems;
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, index) {
            return Container(
              height: 0.5,
              color: AppColors.veryLightGrey,
              margin: EdgeInsets.symmetric(horizontal: 16),
            );
          },
          itemBuilder: (_, index) => Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TodoItemWidget(items[index]),
          ),
        );
      },
    );
  }
}

class TodoItemWidget extends StatelessWidget {
  final TodoItem todoItem;

  TodoItemWidget(this.todoItem);

  @override
  Widget build(BuildContext context) {
    final todoTextTheme = Theme.of(context).textTheme.subtitle1!;
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              context.read<TodoHomePageViewModel>().updateState(todoItem);
            },
            icon: todoItem.isCompleted ? Icon(Icons.task_alt) : Icon(Icons.radio_button_unchecked),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              todoItem.name,
              style: !todoItem.isCompleted
                  ? todoTextTheme
                  : todoTextTheme.copyWith(decoration: TextDecoration.lineThrough),
            ),
          ),
        ],
      ),
    );
  }
}
