import 'package:flutter/material.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/settings_controller.dart';
import 'package:look/base/models/language_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:look/base/Helper/dimension.dart';

import '../../../generated/l10n.dart';

class EditLanguage extends StatefulWidget {
  EditLanguage({Key? key}) : super(key: key);

  @override
  _EditLanguageState createState() => _EditLanguageState();
}

class _EditLanguageState extends StateMVC<EditLanguage> {
  late SettingController _con;
  _EditLanguageState() : super(SettingController()) {
    _con = controller as SettingController;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.03),
        padding: EdgeInsets.symmetric(
            horizontal: getHorizontal(context) * 0.04, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                S.of(context).select_language,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: getHorizontal(context) * 0.04,
                ),
              ),
              SizedBox(height: 15),
              ListView.builder(
                  itemCount: languages.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var lang = languages[index];
                    return GestureDetector(
                      onTap: () {
                        setting.value.mobileLanguage.value =
                            Locale(lang.code ?? "en");
                        // setting.value.mobileLanguage.notifyListeners();
                        setting.notifyListeners();
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 9),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(lang.image ?? noImage),
                                opacity: lang.code ==
                                        setting.value.mobileLanguage.value
                                            .languageCode
                                    ? .5
                                    : 1,
                              ),
                            ),
                            child: lang.code ==
                                    setting
                                        .value.mobileLanguage.value.languageCode
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: getHorizontal(context) * 0.085,
                                  )
                                : SizedBox(),
                          ),
                          SizedBox(width: getHorizontal(context) * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang.name ?? "",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: getHorizontal(context) * 0.035,
                                ),
                              ),
                              Text(
                                lang.localName ?? "",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                  fontSize: getHorizontal(context) * 0.03,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
