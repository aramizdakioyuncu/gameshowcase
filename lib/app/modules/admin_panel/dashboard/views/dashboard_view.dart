
import 'package:flutter/material.dart';
import 'package:gameshowcase/app/modules/admin_panel/admin_events/views/events_view.dart';
import 'package:gameshowcase/app/modules/admin_panel/admin_update_notes/views/updates_view.dart';
import 'package:get/get.dart';
import '../../admin_news/views/news_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Widget _selectedView = const Center(
    child: Text(
      'ADMİN PANELE HOŞ GELDİNİZ',
      style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
    ),
  );

  void _changeView(Widget newView) {
    setState(() {
      _selectedView = newView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 300,
            height: Get.height,
            color: Colors.cyan,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'ADMİN PANEL',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Dashboard"),
                  onTap:
                      () => _changeView(
                        const Center(
                          child: Text(
                            'ADMİN PANELE HOŞ GELDİNİZ',
                            style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                ),
                ListTile(
                  leading: const Icon(Icons.newspaper),
                  title: const Text('Haberler'),
                  onTap: () => _changeView(const AdminNewsView()),
                ),
                ListTile(
                  leading: const Icon(Icons.event),
                  title: const Text('Etkinlikler'),
                  onTap: () => _changeView(const AdminEventsView()),
                ),
                ListTile(
                  leading: const Icon(Icons.update),
                  title: const Text('Güncellemeler'),
                  onTap: () => _changeView(const AdminUpdatesView()),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: Get.height,
              color: Colors.amberAccent,
              child: _selectedView,
            ),
          ),
        ],
      ),
    );
  }
}
