import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/gui/home_page/todo_home_page_view_model.dart';
import 'package:todo/gui/new_todo_item/new_todo_item_page.dart';
import 'package:todo/gui/new_todo_item/new_todo_item_view_model.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/theme/custom_theme.dart';

class TodoHomePage extends StatefulWidget {
  @override
  State createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  TodoBottomNavigationTab _selectedBottomNavigationTab = TodoBottomNavigationTab.all;

  @override
  void initState() {
    super.initState();
    context.read<TodoHomePageViewModel>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedBottomNavigationTab.index,
        onTap: (index) {
          setState(() {
            _selectedBottomNavigationTab = TodoBottomNavigationTab.values[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _bottomNavigationIcon('assets/images/home.png'),
            label: AppLocalizations.of(context)!.allItems,
          ),
          BottomNavigationBarItem(
            icon: _bottomNavigationIcon('assets/images/task.png'),
            label: AppLocalizations.of(context)!.inCompleteItems,
          ),
          BottomNavigationBarItem(
            icon: _bottomNavigationIcon('assets/images/task-completed.png'),
            label: AppLocalizations.of(context)!.completeItems,
          ),
        ],
      ),
      body: _todoItemsContent(),
      floatingActionButton: _selectedBottomNavigationTab == TodoBottomNavigationTab.complete
          ? null
          : FloatingActionButton(
              onPressed: _navigateToNewTodoPage,
              child: const Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            ),
    );
  }

  Widget _bottomNavigationIcon(String imageAsset) {
    return Image.asset(
      imageAsset,
      width: 24,
      height: 24,
    );
  }

  Widget _todoItemsContent() {
    return Consumer<TodoHomePageViewModel>(
      builder: (_, viewModel, __) {
        late List<TodoItem> items;
        switch(_selectedBottomNavigationTab) {
          case TodoBottomNavigationTab.all:
            items = viewModel.todoItems;
            break;
          case TodoBottomNavigationTab.incomplete:
            items = viewModel.incompleteTodoItems;
            break;
          case TodoBottomNavigationTab.complete:
            items = viewModel.completeTodoItems;
            break;
        }
        if (items.isEmpty) {
          return _noTodoItemsContent();
        } else {
          return _todoListView(items);
        }
      },
    );
  }

  Widget _noTodoItemsContent() {
    final noContentText = _selectedBottomNavigationTab == TodoBottomNavigationTab.complete
        ? AppLocalizations.of(context)!.noCompletedTodoItems
        : AppLocalizations.of(context)!.noTodoItems;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        noContentText,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  ListView _todoListView(List<TodoItem> items) {
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
  }

  Future _navigateToNewTodoPage() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => MultiProvider(
        providers: [
          ChangeNotifierProvider<NewTodoItemViewModel>(
            create: (_) => NewTodoItemViewModel(),
          ),
          ChangeNotifierProxyProvider<NewTodoItemViewModel, ChangeNotifier>(
            lazy: false,
            create: (_) {
              return ChangeNotifier();
            },
            update: (_, newTodoViewModel, changeNotifier) {
              if (newTodoViewModel.todoItem != null) {
                Future.microtask(
                  () => context.read<TodoHomePageViewModel>().insertTodoItem(newTodoViewModel.todoItem!),
                );
              }
              return changeNotifier!;
            },
          ),
        ],
        child: NewToDoItemPage(),
      ),
    ));
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

enum TodoBottomNavigationTab {
  all,
  incomplete,
  complete
}
