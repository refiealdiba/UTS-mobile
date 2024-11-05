import 'package:flutter/material.dart';
import 'produk.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Produk> produks = [
    Produk(judul: "Laptop", harga: 25000000, jumlah: 0),
    Produk(judul: "Mouse", harga: 1250000, jumlah: 0),
    Produk(judul: "Keyboard", harga: 1500000, jumlah: 0),
    Produk(judul: "Monitor", harga: 5000000, jumlah: 0),
    Produk(judul: "Printer", harga: 2200000, jumlah: 0),
  ];

  List<TextEditingController> jumlah = [];
  List<int> totals = [];
  int grandTotal = 0;

  @override
  void initState() {
    super.initState();

    jumlah = List.generate(produks.length, (index) {
      return TextEditingController(text: produks[index].jumlah.toString());
    });
    totals = List.generate(produks.length, (_) => 0);
  }

  void hitungTotalSemuaProduk() {
    setState(() {
      grandTotal = 0;
      for (int i = 0; i < produks.length; i++) {
        totals[i] = produks[i].harga * produks[i].jumlah;
        grandTotal += totals[i];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Toko Komputer"),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: produks.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                          title: Text(produks[index].judul),
                          subtitle: Text("Harga: Rp ${produks[index].harga}"),
                          trailing: SizedBox(
                            width: 80,
                            child: TextField(
                              controller: jumlah[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Jumlah",
                              ),
                              onChanged: (value) {
                                produks[index].jumlah =
                                    int.tryParse(value) ?? 0;
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          for (int i = 0; i < produks.length; i++) {
                            produks[i].jumlah = 0;
                            jumlah[i].text = "0";
                            totals[i] = 0;
                          }
                          grandTotal = 0;
                        });
                      },
                      child: Text("Reset"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        hitungTotalSemuaProduk();
                      },
                      child: Text("Cetak Struk"),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: produks.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                          title: Text(produks[index].judul),
                          subtitle: Text(
                              "Rp ${produks[index].harga} x ${produks[index].jumlah}"),
                          trailing: Text("Total: Rp ${totals[index]}"),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Jumlah Total Keseluruhan: Rp $grandTotal",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    for (var j in jumlah) {
      j.dispose();
    }
    super.dispose();
  }
}
