import 'package:flutter/material.dart';
import 'package:payattubook/core/themes/app_theme.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height - kToolbarHeight,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppTheme.lightInputBackgroundColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search payattu',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.lightSecondaryColor,
                          ),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Icon(Icons.published_with_changes_sharp)
                  ],
                ),
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: 40,
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 5),
                        color: Colors.black12,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: ListTile(
                    onTap: () {},
                    leading: CircleAvatar(),
                    title: Text(
                      'Alex',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '12/02/2022',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    trailing: Icon(Icons.add),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
