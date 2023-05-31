import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../../common/network/ApiServices.dart';
import '../../../config/controller/user_state_controller.dart';

class YktContentTree extends StatefulWidget {
  final Function(String index) onIndex;
  final Function(String value) onValue;
  const YktContentTree({super.key, required this.onIndex, required this.onValue, });

  @override
  State<YktContentTree> createState() => _YktContentTreeState();
}

class _YktContentTreeState extends State<YktContentTree> {
  ExpanderType expanderType = ExpanderType.caret;
  ExpanderPosition expanderPosition = ExpanderPosition.start;
  ExpanderModifier expanderModifier = ExpanderModifier.none;
  bool allowParentSelect = false;
  bool supportParentDoubleTap = false;
  bool docsOpen = true;
  String selectedNode = "";
  List<Node> nodes = [];
  TreeViewController? _treeViewController;
  expandNode(String key, bool expanded) {
    String msg = '${expanded ? "Expanded" : "Collapsed"}: $key';
    debugPrint(msg);
    Node? node = _treeViewController!.getNode(key);
    if (node != null) {
      List<Node> updated;
      if (key == 'docs') {
        updated = _treeViewController!.updateNode(
            key,
            node.copyWith(
              selectedIconColor: Colors.white,
              expanded: expanded,
              icon: expanded ? Icons.folder_open : Icons.folder,
            ));
      } else {
        updated = _treeViewController!
            .updateNode(key, node.copyWith(expanded: expanded));
      }
      setState(() {
        if (key == 'docs') docsOpen = expanded;
        _treeViewController = _treeViewController!.copyWith(children: updated);
      });
    }
  }

  List<Node> createNodeList(List<Map<String, dynamic>> data, int parentId) {
    List<Node> nodeList = [];
    for (final item in data) {
      if (item['ParentID'] == parentId) {
        List<Node> children = createNodeList(data, item['id']);
        nodeList.add(
          Node(
            key: item['id'].toString(),
            label: item['NodeName'],
            children: children,
            parent: children.isNotEmpty,
            //icon: children.isEmpty ? Icons.star : Icons.account_balance_sharp,
          ),
        );
      }
    }
    return nodeList;
  }

  loadNodes(STATIONS) {
    return createNodeList(STATIONS, 0);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  List<Map<String, dynamic>> jsonList = [];
  init() async {
    var data = {
      "username": UserStateController.current.user.username,
      "pwd": UserStateController.current.user.pwd
    };

    var reponse = await ApiService.getContentTree(data);
    var jsondata = json.decode(reponse.data);
    if (jsondata["code"] == 1) {
      
      jsonList = List<Map<String, dynamic>>.from(jsondata["data"]);
      widget.onIndex(jsonList[0]["id"].toString());
      var nodes = loadNodes(jsonList);
      _treeViewController = TreeViewController(
        children: nodes,
        selectedKey: selectedNode,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorscheme = const ColorScheme.light(
      primary: Colors.transparent,
      onBackground: Colors.white,
      onPrimary: Color(0xffFFC34D),
    );

    TreeViewTheme treeViewTheme = TreeViewTheme(
      expanderTheme: ExpanderThemeData(
          type: expanderType,

          // modifier: _expanderModifier,
          // position: _expanderPosition,
          // color: Colors.grey.shade800,
          size: 22,
          color: Colors.white),
      labelStyle: const TextStyle(
          fontSize: 20, letterSpacing: 0.3, color: Colors.white),
      parentLabelStyle: const TextStyle(
        overflow: TextOverflow.fade,
        fontSize: 20,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        size: 18,
        color: Colors.grey.shade800,
      ),
      colorScheme: colorscheme,
    );
    return jsonList.isEmpty
        ? Container()
        : TreeView(
            primary: false,
            controller: _treeViewController!,
            allowParentSelect: allowParentSelect,
            supportParentDoubleTap: supportParentDoubleTap,
            onExpansionChanged: (key, expanded) {
              expandNode(key, expanded);
              widget.onIndex(key);
              widget.onValue(_treeViewController!.getParent(key)!.label.toString());
            },
            onNodeTap: (key) { 
              debugPrint('Selected: $key');

              setState(() {
                selectedNode = key;
                _treeViewController =
                    _treeViewController!.copyWith(selectedKey: key);
                widget.onValue(_treeViewController!.getNode(key)!.label.toString());
                widget.onIndex(key);
              });
            },
            theme: treeViewTheme,
          );
  }
}
