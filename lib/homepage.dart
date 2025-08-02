import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CivicTrack',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground)),
      ),
      body: Column(
        children: [
          _FilterBar(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 600;
                return isMobile ? _buildListView() : _buildGridView();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: NeumorphicContainer(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_rounded,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Report Issue',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
      itemCount: mockIssues.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: IssueCard(issue: mockIssues[index]),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 80),
      itemCount: mockIssues.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 380,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return IssueCard(issue: mockIssues[index]);
      },
    );
  }
}

class _FilterBar extends StatefulWidget {
  @override
  State<_FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<_FilterBar> {
  String? _selectedCategory;
  String? _selectedStatus;
  String? _selectedDistance;

  final List<String> _categories = [
    'Road',
    'Electricity',
    'Waste',
    'Water',
    'Parks'
  ];
  final List<String> _statuses = ['Reported', 'In Progress', 'Completed'];
  final List<String> _distances = ['< 1 km', '< 5 km', '< 10 km'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildNeumorphicTextField(context),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildNeumorphicDropdown(
                  context,
                  'Category',
                  _categories,
                  _selectedCategory,
                  (val) => setState(() => _selectedCategory = val)),
              const SizedBox(width: 12),
              _buildNeumorphicDropdown(
                  context,
                  'Status',
                  _statuses,
                  _selectedStatus,
                  (val) => setState(() => _selectedStatus = val)),
              const SizedBox(width: 12),
              _buildNeumorphicDropdown(
                  context,
                  'Distance',
                  _distances,
                  _selectedDistance,
                  (val) => setState(() => _selectedDistance = val)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNeumorphicDropdown(BuildContext context, String hint,
      List<String> items, String? value, ValueChanged<String?> onChanged) {
    final neumorphicTheme = Theme.of(context).extension<NeumorphicTheme>()!;
    return Expanded(
      child: NeumorphicContainer(
        pressed: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(hint,
                  style: TextStyle(
                      fontSize: 13.5,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withAlpha(178))),
              value: value,
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: Theme.of(context).colorScheme.primary),
              dropdownColor: neumorphicTheme.lightShadow,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 13.5)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNeumorphicTextField(BuildContext context) {
    return NeumorphicContainer(
      pressed: true,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Issues...',
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(178)),
          prefixIcon: Icon(Icons.search_rounded,
              color: Theme.of(context).colorScheme.primary),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class IssueCard extends StatelessWidget {
  final Issue issue;
  const IssueCard({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    return Tilt(
      borderRadius: BorderRadius.circular(24),
      tiltConfig: const TiltConfig(
        angle: 30,
      ),
      child: NeumorphicContainer(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 5,
                  child: Image.network(issue.imageUrl,
                      fit: BoxFit.cover, width: double.infinity)),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildStatusChip(
                                  context,
                                  issue.status,
                                  issue.status == 'In Progress'
                                      ? Colors.blueAccent
                                      : (issue.status == 'Reported'
                                          ? Colors.pinkAccent
                                          : Colors.greenAccent)),
                              Text(issue.date,
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(issue.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              size: 14,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 4),
                          Expanded(
                              child: Text(issue.location,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  overflow: TextOverflow.ellipsis)),
                          const SizedBox(width: 8),
                          Text('${issue.distance} km',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
          color: color.withAlpha(38), borderRadius: BorderRadius.circular(8.0)),
      child: Text(label.toUpperCase(),
          style: TextStyle(
              fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }
}

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final bool pressed;
  const NeumorphicContainer(
      {super.key, required this.child, this.pressed = false});

  @override
  Widget build(BuildContext context) {
    final neumorphicTheme = Theme.of(context).extension<NeumorphicTheme>()!;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: pressed
            ? [
                BoxShadow(
                    color: neumorphicTheme.darkShadow,
                    offset: const Offset(2, 2),
                    blurRadius: 5,
                    spreadRadius: 1),
                BoxShadow(
                    color: neumorphicTheme.lightShadow,
                    offset: const Offset(-2, -2),
                    blurRadius: 5,
                    spreadRadius: 1),
              ]
            : [
                BoxShadow(
                    color: neumorphicTheme.darkShadow,
                    offset: const Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1),
                BoxShadow(
                    color: neumorphicTheme.lightShadow,
                    offset: const Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 1),
              ],
      ),
      child: child,
    );
  }
}

class Issue {
  final String id;
  final String title;
  final String imageUrl;
  final String location;
  final String category;
  final String status;
  final String date;
  final double distance;

  Issue({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.location,
    required this.category,
    required this.status,
    required this.date,
    required this.distance,
  });
}

final List<Issue> mockIssues = [
  Issue(
      id: '1',
      title: 'Large Pothole on Main Road causing traffic issues',
      imageUrl: 'https://placehold.co/600x400/1E293B/3B82F6?text=Pothole',
      location: 'C.G. Road, Ahmedabad',
      category: 'Road',
      status: 'Reported',
      date: 'Jun 02',
      distance: 1.1),
  Issue(
      id: '2',
      title: 'Streetlight not working for the past 2 days',
      imageUrl: 'https://placehold.co/600x400/1E293B/3B82F6?text=Streetlight',
      location: 'Gota Bridge, Ahmedabad',
      category: 'Electricity',
      status: 'In Progress',
      date: 'Aug 14',
      distance: 2.8),
  Issue(
      id: '3',
      title: 'Garbage not collected since last week, creating a mess',
      imageUrl: 'https://placehold.co/600x400/1E293B/3B82F6?text=Garbage',
      location: 'IT Society, Ahmedabad',
      category: 'Waste',
      status: 'Reported',
      date: 'Jun 25',
      distance: 1.1),
  Issue(
      id: '4',
      title: 'Broken public water tap leading to wastage',
      imageUrl: 'https://placehold.co/600x400/1E293B/3B82F6?text=Water+Tap',
      location: 'Vastrapur Lake, Ahmedabad',
      category: 'Water',
      status: 'In Progress',
      date: 'Aug 10',
      distance: 4.5),
  Issue(
      id: '5',
      title: 'Fallen tree blocking the sidewalk after storm',
      imageUrl: 'https://placehold.co/600x400/1E293B/3B82F6?text=Fallen+Tree',
      location: 'Judges Bungalow Road',
      category: 'Public Safety',
      status: 'Reported',
      date: 'Aug 15',
      distance: 3.2),
  Issue(
      id: '6',
      title: 'Damaged playground equipment in park',
      imageUrl: 'https://placehold.co/600x400/1E293B/3B82F6?text=Playground',
      location: 'Parimal Garden, Ahmedabad',
      category: 'Parks',
      status: 'Completed',
      date: 'Jul 28',
      distance: 2.1),
];
