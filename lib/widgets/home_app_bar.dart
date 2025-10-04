import 'package:flutter/material.dart';
import 'package:weather/model/location_service_model.dart';
import 'package:weather/services/location_service.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  late Future<LocationModel> _futureLocation;

  @override
  void initState() {
    super.initState();
    _futureLocation = LocationService().getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const CircleAvatar(
                backgroundColor: Color(0xff05092E),
                child: Icon(Icons.menu, color: Colors.blue),
              ),
            ),
          ),
        ),
      ),
      actions: [
        FutureBuilder<LocationModel>(
          future: _futureLocation,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.location_searching,
                    color: Colors.white70, size: 20),
              );
            }
            if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.location_off,
                    color: Colors.redAccent, size: 20),
              );
            }
            if (snapshot.hasData) {
              final locmodel = snapshot.data!;
              return Row(
                children: [
                  const Icon(Icons.place, color: Color(0xff46AAE5)),
                  Text(
                    "${locmodel.vallage},${locmodel.city}",
                    style: const TextStyle(color: Color(0xffD9DEF1)),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down,
                      color: Color(0xffD5DAF7)),
                  const SizedBox(width: 8),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
