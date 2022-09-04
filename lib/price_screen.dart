import 'package:flutter/material.dart';
import 'package:untitled3/network_helper.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  void getCurrencies() async {
    var currenciesDate = await NetworkHelper().getData();
    var rate = currenciesDate['rate'];
    entries.add(rate);
    setState(() {});
    print(entries);
  }

  final List<String> typeCurrency = <String>[];
  final List<double> entries = <double>[];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                if (index == 0 || index == entries.length + 1) {
                  return Container();
                }
                return Container(
                  height: 50,
                  color: Colors.amber[200 + index % 4 * 100],
                  child: Center(child: Text('Entry ${entries[index - 1]}')),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                    height: .05,
                  ),
              itemCount: entries.length + 2),
        ),
        TextButton(onPressed: () => getCurrencies(), child: const Text('Add')),
      ],
    );
  }
}
