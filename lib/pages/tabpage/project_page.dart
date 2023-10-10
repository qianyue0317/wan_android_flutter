
import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/base/base_page.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<StatefulWidget> createState() => _ProjectPageState();
}


class _ProjectPageState extends State<ProjectPage> with BasePage<ProjectPage>, AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Center(
      child: Text("project"),
    );
  }

  @override
  bool get wantKeepAlive => true;

}