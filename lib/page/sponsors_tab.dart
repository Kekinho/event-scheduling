import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wticifesapp/model/event_schedule.dart';
import 'package:wticifesapp/page/common/app_name_widget.dart';
import 'package:wticifesapp/page/component/item_schedule_sponsors.dart';
import 'package:wticifesapp/services/sponsors_service.dart';
import 'dart:io';

class SponsorsTab extends StatefulWidget {
  const SponsorsTab({Key? key}) : super(key: key);

  @override
  State<SponsorsTab> createState() => _SponsorsTabState();
}

class _SponsorsTabState extends State<SponsorsTab> {
  _SponsorsTabState() {
    _selectedVal = "0";
  }
  final _level = ["0", "1", "2"];
  final _lvlDescription = ["Diamante", "Ouro", "Prata"];
  String _selectedVal = "0";

  Widget _showDropdownAndroid(){
    return DropdownButtonFormField(
      value: _selectedVal,
      items: _level
          .map((e) => DropdownMenuItem(
        value: e,
        child:  Text(_lvlDescription[int.parse(e)]),
      ))
          .toList(),
      onChanged: (val) {
        setState(() {
          _selectedVal = val.toString();
/*                            _data = _data
                                .where((element) => element.day == _selectedVal)
                                .toList();*/
        });
      },
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        color: Colors.white,
      ),
      style: const TextStyle(color: Colors.white),
      dropdownColor: const Color.fromRGBO(76, 11, 28, 0.9),
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        labelText: "Tipo de patrocinador",
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(
          Icons.settings_system_daydream,
          color: Colors.white,
        ),
        filled: true,
        fillColor: const Color.fromRGBO(
            76, 11, 28, 0.9), //Color.fromRGBO(213, 180, 126, 1),
      ),
    );
  }

  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height * 0.4,
          child: CupertinoPicker(
            backgroundColor: const Color.fromRGBO(
                76, 11, 28, 0.9),
            itemExtent: 30,
            scrollController: FixedExtentScrollController(initialItem: int.parse(_selectedVal)),
            children: const [
              Text('Diamante', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text('Ouro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text('Prata', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
            onSelectedItemChanged: (value) {
              setState(() {
                _selectedVal = value.toString();
              });
            },
          ),
        ));
  }

  Widget _showPickerIOS(BuildContext ctx) {
    String _sponsorLvl(){
      return _lvlDescription[int.parse(_selectedVal)];
    }
    return CupertinoButton.filled(
      child: Row(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.money_dollar_circle_fill),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${_sponsorLvl()}', style: TextStyle(color: Colors.white, fontSize: 13), ),
          ),
        ],
      ),
      onPressed: () => _showPicker(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    //var _data = DUMMY_EVENT_DATA;
/*    _data = _data.where((element) => element.day == _selectedVal).toList();
    _data.sort((a, b) => a.id.compareTo(b.id));*/
    return Scaffold(
      backgroundColor: Color.fromRGBO(213, 180, 126, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(213, 180, 126, 1),
        elevation: 0,
        centerTitle: true,
        title: AppNameWidget(),
      ),
      body: Container(
        color: Color.fromRGBO(76, 11, 28, 1),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
              child: Platform.isIOS ?  _showPickerIOS(context) : _showDropdownAndroid(),
            ),
            StreamBuilder<List<Speaker>>(
                stream: SponsorsService().sponsorsStreamSearch(_lvlDescription[int.parse(_selectedVal)]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao carregar dados'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Container(padding: EdgeInsets.all(120) , child: Text('Sem dados', style: TextStyle(color: Colors.white),)));
                  } else {
                    var _data = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        reverse: false,
                        itemCount: _data.length,
                        itemBuilder: (ctx, i) => ScheduleItemSponsors(
                          key: ValueKey(_data[i].id),
                          event: _data[i],
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
