import 'package:flutter/material.dart';
import 'package:shared_prefenreces/data/local_date.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  List<String> list = [];

  @override
  void initState() {
    setList();
    super.initState();
  }

  void setList() async {
    list = await LocalDate.getListString();
    setState(() {});
  }

  void mostrarSnackBar() {
    final snackBar = SnackBar(
      content: const Text(
        'Digite alguma nota!',
        style: TextStyle(fontSize: 16),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 100,
      action: SnackBarAction(
          textColor: Colors.white,
          label: 'Ok',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }),
      backgroundColor: const Color(0xFF4493D4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          style: const TextStyle(color: Colors.white),
          widget.title,
        ),
      ),
      body: Stack(
        children: [
          //listview
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              itemCount: list.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    style: ListTileStyle.drawer,
                    title: Text(
                      list[index],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Center(
                        child: Text(
                          list[index][0].toUpperCase(),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        size: 30,
                        Icons.delete,
                        color: Colors.blue[700],
                      ),
                      onPressed: () async {
                        list.removeAt(index);
                        await LocalDate.setListaString(list);
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          //inputText
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Digite uma nota',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_nameController.text.isEmpty) {
                        return mostrarSnackBar();
                      } else {
                        LocalDate.setListaString(
                            [...list, _nameController.text]);
                        _nameController.clear();
                        setList();
                        setState(() {});
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blue[700],
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
