import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// copied package because it became outdated on 3.22.2 # language_picker: ^0.4.3
///Provides a customizable [Dialog] which displays all languages
/// with optional search feature

class LanguagePickerDialog extends StatefulWidget {
  /// Callback that is called with selected Language
  final ValueChanged<Language>? onValuePicked;

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget? title;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided. Otherwise, this padding
  /// is used.
  ///
  /// This property defaults to providing 12 pixels on the top,
  /// 16 pixels on bottom of the title. If the [content] is not null, then no bottom padding is
  /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
  /// pixels of bottom padding is added to separate the [title] from the
  /// [actions].
  final EdgeInsetsGeometry? titlePadding;

  /// Padding around the content.

  final EdgeInsetsGeometry contentPadding;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  ///
  /// If this label is not provided, a semantic label will be inferred from the
  /// [title] if it is not null.  If there is no title, the label will be taken
  /// from [MaterialLocalizations.alertDialogLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.isRouteName], for a description of how this
  ///    value is used.
  final String? semanticLabel;

  ///Callback that is called with selected item of type Language which returns a
  ///Widget to build list view item inside dialog
  final ItemBuilder? itemBuilder;

  /// The (optional) horizontal separator used between title, content and
  /// actions.
  ///
  /// If this divider is not provided a [Divider] is used with [height]
  /// property is set to 0.0
  final Widget divider;

  /// The [divider] is not displayed if set to false. Default is set to true.
  final bool isDividerEnabled;

  /// Determines if search [TextField] is shown or not
  /// Defaults to false
  final bool isSearchable;

  /// The optional [decoration] of search [TextField]
  final InputDecoration? searchInputDecoration;

  ///The optional [cursorColor] of search [TextField]
  final Color? searchCursorColor;

  ///The search empty view is displayed if nothing returns from search result
  final Widget? searchEmptyView;

  /// List of languages available in this picker.
  final List<Language>? languages;

  const LanguagePickerDialog({
    super.key,
    this.onValuePicked,
    this.title,
    this.titlePadding,
    this.contentPadding = const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
    this.semanticLabel,
    this.itemBuilder,
    this.isDividerEnabled = false,
    this.divider = const Divider(
      height: 0.0,
    ),
    this.isSearchable = false,
    this.searchInputDecoration,
    this.searchCursorColor,
    this.searchEmptyView,
    this.languages,
  });

  @override
  SingleChoiceDialogState createState() {
    return SingleChoiceDialogState();
  }
}

class SingleChoiceDialogState extends State<LanguagePickerDialog> {
  late List<Language> _allLanguages;
  late List<Language> _filteredLanguages;

  @override
  void initState() {
    _allLanguages = widget.languages ?? Languages.defaultLanguages;
    _filteredLanguages = _allLanguages;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyAlertDialog(
      title: _buildHeader(),
      contentPadding: widget.contentPadding,
      semanticLabel: widget.semanticLabel,
      content: _buildContent(context),
      isDividerEnabled: widget.isDividerEnabled,
      divider: widget.divider,
    );
  }

  _buildContent(BuildContext context) {
    return _filteredLanguages.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            children: _filteredLanguages
                .map(
                  (item) => SimpleDialogOption(
                    child: widget.itemBuilder != null
                        ? widget.itemBuilder!(item)
                        : Text(item.name),
                    onPressed: () {
                      widget.onValuePicked!(item);
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
          )
        : widget.searchEmptyView ??
            const Center(
              child: Text('No language found.'),
            );
  }

  _buildHeader() {
    return widget.isSearchable
        ? Column(
            children: <Widget>[
              _buildTitle(),
              _buildSearchField(),
            ],
          )
        : _buildTitle();
  }

  _buildTitle() {
    return widget.titlePadding != null
        ? Padding(
            padding: widget.titlePadding!,
            child: widget.title,
          )
        : widget.title;
  }

  _buildSearchField() {
    return TextField(
      cursorColor: widget.searchCursorColor,
      decoration: widget.searchInputDecoration ??
          const InputDecoration(hintText: 'Search'),
      onChanged: (String value) {
        setState(() {
          _filteredLanguages = _allLanguages
              .where(
                (Language language) =>
                    language.name
                        .toLowerCase()
                        .startsWith(value.toLowerCase()) ||
                    language.isoCode
                        .toLowerCase()
                        .startsWith(value.toLowerCase()),
              )
              .toList();
        });
      },
    );
  }
}

class Language {
  Language(this.isoCode, this.name);

  final String name;
  final String isoCode;

  Language.fromMap(Map<String, String> map)
      : name = map['name']!,
        isoCode = map['isoCode']!;

  /// Returns the Language matching the given ISO code from the standard list.
  factory Language.fromIsoCode(String isoCode) =>
      Languages.defaultLanguages.firstWhere((l) => l.isoCode == isoCode);

  @override
  bool operator ==(other) =>
      other is Language && name == other.name && isoCode == other.isoCode;

  @override
  int get hashCode => isoCode.hashCode;
}

class Languages {
  static Language get abkhazian => Language('ab', 'Abkhazian');
  static Language get afar => Language('aa', 'Afar');
  static Language get afrikaans => Language('af', 'Afrikaans');
  static Language get akan => Language('ak', 'Akan');
  static Language get albanian => Language('sq', 'Albanian');
  static Language get amharic => Language('am', 'Amharic');
  static Language get arabic => Language('ar', 'Arabic');
  static Language get aragonese => Language('an', 'Aragonese');
  static Language get armenian => Language('hy', 'Armenian');
  static Language get assamese => Language('as', 'Assamese');
  static Language get avaric => Language('av', 'Avaric');
  static Language get avestan => Language('ae', 'Avestan');
  static Language get aymara => Language('ay', 'Aymara');
  static Language get azerbaijani => Language('az', 'Azerbaijani');
  static Language get bambara => Language('bm', 'Bambara');
  static Language get bashkir => Language('ba', 'Bashkir');
  static Language get basque => Language('eu', 'Basque');
  static Language get belarusian => Language('be', 'Belarusian');
  static Language get bengali => Language('bn', 'Bengali');
  static Language get bihariLanguages => Language('bh', 'Bihari Languages');
  static Language get bislama => Language('bi', 'Bislama');
  static Language get bosnian => Language('bs', 'Bosnian');
  static Language get breton => Language('br', 'Breton');
  static Language get bulgarian => Language('bg', 'Bulgarian');
  static Language get burmese => Language('my', 'Burmese');
  static Language get catalan => Language('ca', 'Catalan');
  static Language get centralKhmer => Language('km', 'Central Khmer');
  static Language get chamorro => Language('ch', 'Chamorro');
  static Language get chechen => Language('ce', 'Chechen');
  static Language get chewaNyanja => Language('ny', 'Chewa (Nyanja)');
  static Language get chineseSimplified =>
      Language('zh_Hans', 'Chinese (Simplified)');
  static Language get chineseTraditional =>
      Language('zh_Hant', 'Chinese (Traditional)');
  static Language get churchSlavonic => Language('cu', 'Church Slavonic');
  static Language get chuvash => Language('cv', 'Chuvash');
  static Language get cornish => Language('kw', 'Cornish');
  static Language get corsican => Language('co', 'Corsican');
  static Language get cree => Language('cr', 'Cree');
  static Language get croatian => Language('hr', 'Croatian');
  static Language get czech => Language('cs', 'Czech');
  static Language get danish => Language('da', 'Danish');
  static Language get dhivehi => Language('dv', 'Dhivehi');
  static Language get dutch => Language('nl', 'Dutch');
  static Language get dzongkha => Language('dz', 'Dzongkha');
  static Language get english => Language('en', 'English');
  static Language get esperanto => Language('eo', 'Esperanto');
  static Language get estonian => Language('et', 'Estonian');
  static Language get ewe => Language('ee', 'Ewe');
  static Language get faroese => Language('fo', 'Faroese');
  static Language get fijian => Language('fj', 'Fijian');
  static Language get finnish => Language('fi', 'Finnish');
  static Language get french => Language('fr', 'French');
  static Language get fulah => Language('ff', 'Fulah');
  static Language get gaelic => Language('gd', 'Gaelic');
  static Language get galician => Language('gl', 'Galician');
  static Language get ganda => Language('lg', 'Ganda');
  static Language get georgian => Language('ka', 'Georgian');
  static Language get german => Language('de', 'German');
  static Language get greek => Language('el', 'Greek');
  static Language get guarani => Language('gn', 'Guarani');
  static Language get gujarati => Language('gu', 'Gujarati');
  static Language get haitian => Language('ht', 'Haitian');
  static Language get hausa => Language('ha', 'Hausa');
  static Language get hebrew => Language('he', 'Hebrew');
  static Language get herero => Language('hz', 'Herero');
  static Language get hindi => Language('hi', 'Hindi');
  static Language get hiriMotu => Language('ho', 'Hiri Motu');
  static Language get hungarian => Language('hu', 'Hungarian');
  static Language get icelandic => Language('is', 'Icelandic');
  static Language get ido => Language('io', 'Ido');
  static Language get igbo => Language('ig', 'Igbo');
  static Language get indonesian => Language('id', 'Indonesian');
  static Language get interlingua => Language('ia', 'Interlingua');
  static Language get interlingue => Language('ie', 'Interlingue');
  static Language get inuktitut => Language('iu', 'Inuktitut');
  static Language get inupiaq => Language('ik', 'Inupiaq');
  static Language get irish => Language('ga', 'Irish');
  static Language get italian => Language('it', 'Italian');
  static Language get japanese => Language('ja', 'Japanese');
  static Language get javanese => Language('jv', 'Javanese');
  static Language get kalaallisut => Language('kl', 'Kalaallisut');
  static Language get kannada => Language('kn', 'Kannada');
  static Language get kanuri => Language('kr', 'Kanuri');
  static Language get kashmiri => Language('ks', 'Kashmiri');
  static Language get kazakh => Language('kk', 'Kazakh');
  static Language get kikuyu => Language('ki', 'Kikuyu');
  static Language get kinyarwanda => Language('rw', 'Kinyarwanda');
  static Language get kirghiz => Language('ky', 'Kirghiz');
  static Language get komi => Language('kv', 'Komi');
  static Language get kongo => Language('kg', 'Kongo');
  static Language get korean => Language('ko', 'Korean');
  static Language get kuanyama => Language('kj', 'Kuanyama');
  static Language get kurdish => Language('ku', 'Kurdish');
  static Language get lao => Language('lo', 'Lao');
  static Language get latin => Language('la', 'Latin');
  static Language get latvian => Language('lv', 'Latvian');
  static Language get limburgan => Language('li', 'Limburgan');
  static Language get lingala => Language('ln', 'Lingala');
  static Language get lithuanian => Language('lt', 'Lithuanian');
  static Language get lubaKatanga => Language('lu', 'Luba-Katanga');
  static Language get luxembourgish => Language('lb', 'Luxembourgish');
  static Language get macedonian => Language('mk', 'Macedonian');
  static Language get malagasy => Language('mg', 'Malagasy');
  static Language get malay => Language('ms', 'Malay');
  static Language get malayalam => Language('ml', 'Malayalam');
  static Language get maltese => Language('mt', 'Maltese');
  static Language get manx => Language('gv', 'Manx');
  static Language get maori => Language('mi', 'Maori');
  static Language get marathi => Language('mr', 'Marathi');
  static Language get marshallese => Language('mh', 'Marshallese');
  static Language get mongolian => Language('mn', 'Mongolian');
  static Language get nauru => Language('na', 'Nauru');
  static Language get navajo => Language('nv', 'Navajo');
  static Language get ndebeleNorth => Language('nd', 'Ndebele, North');
  static Language get ndebeleSouth => Language('nr', 'Ndebele, South');
  static Language get ndonga => Language('ng', 'Ndonga');
  static Language get nepali => Language('ne', 'Nepali');
  static Language get northernSami => Language('se', 'Northern Sami');
  static Language get norwegian => Language('no', 'Norwegian');
  static Language get norwegianNynorsk => Language('nn', 'Norwegian Nynorsk');
  static Language get occitan => Language('oc', 'Occitan');
  static Language get ojibwa => Language('oj', 'Ojibwa');
  static Language get oriya => Language('or', 'Oriya');
  static Language get oromo => Language('om', 'Oromo');
  static Language get ossetian => Language('os', 'Ossetian');
  static Language get pali => Language('pi', 'Pali');
  static Language get panjabi => Language('pa', 'Panjabi');
  static Language get persian => Language('fa', 'Persian');
  static Language get polish => Language('pl', 'Polish');
  static Language get portuguese => Language('pt', 'Portuguese');
  static Language get pushto => Language('ps', 'Pushto');
  static Language get quechua => Language('qu', 'Quechua');
  static Language get romanian => Language('ro', 'Romanian');
  static Language get romansh => Language('rm', 'Romansh');
  static Language get rundi => Language('rn', 'Rundi');
  static Language get russian => Language('ru', 'Russian');
  static Language get samoan => Language('sm', 'Samoan');
  static Language get sango => Language('sg', 'Sango');
  static Language get sanskrit => Language('sa', 'Sanskrit');
  static Language get sardinian => Language('sc', 'Sardinian');
  static Language get serbian => Language('sr', 'Serbian');
  static Language get shona => Language('sn', 'Shona');
  static Language get sichuanYi => Language('ii', 'Sichuan Yi');
  static Language get sindhi => Language('sd', 'Sindhi');
  static Language get sinhala => Language('si', 'Sinhala');
  static Language get slovak => Language('sk', 'Slovak');
  static Language get slovenian => Language('sl', 'Slovenian');
  static Language get somali => Language('so', 'Somali');
  static Language get sothoSouthern => Language('st', 'Sotho, Southern');
  static Language get spanish => Language('es', 'Spanish');
  static Language get sundanese => Language('su', 'Sundanese');
  static Language get swahili => Language('sw', 'Swahili');
  static Language get swati => Language('ss', 'Swati');
  static Language get swedish => Language('sv', 'Swedish');
  static Language get tagalog => Language('tl', 'Tagalog');
  static Language get tahitian => Language('ty', 'Tahitian');
  static Language get tajik => Language('tg', 'Tajik');
  static Language get tamil => Language('ta', 'Tamil');
  static Language get tatar => Language('tt', 'Tatar');
  static Language get telugu => Language('te', 'Telugu');
  static Language get thai => Language('th', 'Thai');
  static Language get tibetan => Language('bo', 'Tibetan');
  static Language get tigrinya => Language('ti', 'Tigrinya');
  static Language get tongaTongaIslands =>
      Language('to', 'Tonga (Tonga Islands)');
  static Language get tsonga => Language('ts', 'Tsonga');
  static Language get tswana => Language('tn', 'Tswana');
  static Language get turkish => Language('tr', 'Turkish');
  static Language get turkmen => Language('tk', 'Turkmen');
  static Language get twi => Language('tw', 'Twi');
  static Language get uighur => Language('ug', 'Uighur');
  static Language get ukrainian => Language('uk', 'Ukrainian');
  static Language get urdu => Language('ur', 'Urdu');
  static Language get uzbek => Language('uz', 'Uzbek');
  static Language get venda => Language('ve', 'Venda');
  static Language get vietnamese => Language('vi', 'Vietnamese');
  static Language get volapuk => Language('vo', 'Volapük');
  static Language get walloon => Language('wa', 'Walloon');
  static Language get welsh => Language('cy', 'Welsh');
  static Language get westernFrisian => Language('fy', 'Western Frisian');
  static Language get wolof => Language('wo', 'Wolof');
  static Language get xhosa => Language('xh', 'Xhosa');
  static Language get yiddish => Language('yi', 'Yiddish');
  static Language get yoruba => Language('yo', 'Yoruba');
  static Language get zhuang => Language('za', 'Zhuang');
  static Language get zulu => Language('zu', 'Zulu');

  static List<Language> defaultLanguages = [
    Languages.abkhazian,
    Languages.afar,
    Languages.afrikaans,
    Languages.akan,
    Languages.albanian,
    Languages.amharic,
    Languages.arabic,
    Languages.aragonese,
    Languages.armenian,
    Languages.assamese,
    Languages.avaric,
    Languages.avestan,
    Languages.aymara,
    Languages.azerbaijani,
    Languages.bambara,
    Languages.bashkir,
    Languages.basque,
    Languages.belarusian,
    Languages.bengali,
    Languages.bihariLanguages,
    Languages.bislama,
    Languages.bosnian,
    Languages.breton,
    Languages.bulgarian,
    Languages.burmese,
    Languages.catalan,
    Languages.centralKhmer,
    Languages.chamorro,
    Languages.chechen,
    Languages.chewaNyanja,
    Languages.chineseSimplified,
    Languages.chineseTraditional,
    Languages.churchSlavonic,
    Languages.chuvash,
    Languages.cornish,
    Languages.corsican,
    Languages.cree,
    Languages.croatian,
    Languages.czech,
    Languages.danish,
    Languages.dhivehi,
    Languages.dutch,
    Languages.dzongkha,
    Languages.english,
    Languages.esperanto,
    Languages.estonian,
    Languages.ewe,
    Languages.faroese,
    Languages.fijian,
    Languages.finnish,
    Languages.french,
    Languages.fulah,
    Languages.gaelic,
    Languages.galician,
    Languages.ganda,
    Languages.georgian,
    Languages.german,
    Languages.greek,
    Languages.guarani,
    Languages.gujarati,
    Languages.haitian,
    Languages.hausa,
    Languages.hebrew,
    Languages.herero,
    Languages.hindi,
    Languages.hiriMotu,
    Languages.hungarian,
    Languages.icelandic,
    Languages.ido,
    Languages.igbo,
    Languages.indonesian,
    Languages.interlingua,
    Languages.interlingue,
    Languages.inuktitut,
    Languages.inupiaq,
    Languages.irish,
    Languages.italian,
    Languages.japanese,
    Languages.javanese,
    Languages.kalaallisut,
    Languages.kannada,
    Languages.kanuri,
    Languages.kashmiri,
    Languages.kazakh,
    Languages.kikuyu,
    Languages.kinyarwanda,
    Languages.kirghiz,
    Languages.komi,
    Languages.kongo,
    Languages.korean,
    Languages.kuanyama,
    Languages.kurdish,
    Languages.lao,
    Languages.latin,
    Languages.latvian,
    Languages.limburgan,
    Languages.lingala,
    Languages.lithuanian,
    Languages.lubaKatanga,
    Languages.luxembourgish,
    Languages.macedonian,
    Languages.malagasy,
    Languages.malay,
    Languages.malayalam,
    Languages.maltese,
    Languages.manx,
    Languages.maori,
    Languages.marathi,
    Languages.marshallese,
    Languages.mongolian,
    Languages.nauru,
    Languages.navajo,
    Languages.ndebeleNorth,
    Languages.ndebeleSouth,
    Languages.ndonga,
    Languages.nepali,
    Languages.northernSami,
    Languages.norwegian,
    Languages.norwegianNynorsk,
    Languages.occitan,
    Languages.ojibwa,
    Languages.oriya,
    Languages.oromo,
    Languages.ossetian,
    Languages.pali,
    Languages.panjabi,
    Languages.persian,
    Languages.polish,
    Languages.portuguese,
    Languages.pushto,
    Languages.quechua,
    Languages.romanian,
    Languages.romansh,
    Languages.rundi,
    Languages.russian,
    Languages.samoan,
    Languages.sango,
    Languages.sanskrit,
    Languages.sardinian,
    Languages.serbian,
    Languages.shona,
    Languages.sichuanYi,
    Languages.sindhi,
    Languages.sinhala,
    Languages.slovak,
    Languages.slovenian,
    Languages.somali,
    Languages.sothoSouthern,
    Languages.spanish,
    Languages.sundanese,
    Languages.swahili,
    Languages.swati,
    Languages.swedish,
    Languages.tagalog,
    Languages.tahitian,
    Languages.tajik,
    Languages.tamil,
    Languages.tatar,
    Languages.telugu,
    Languages.thai,
    Languages.tibetan,
    Languages.tigrinya,
    Languages.tongaTongaIslands,
    Languages.tsonga,
    Languages.tswana,
    Languages.turkish,
    Languages.turkmen,
    Languages.twi,
    Languages.uighur,
    Languages.ukrainian,
    Languages.urdu,
    Languages.uzbek,
    Languages.venda,
    Languages.vietnamese,
    Languages.volapuk,
    Languages.walloon,
    Languages.welsh,
    Languages.westernFrisian,
    Languages.wolof,
    Languages.xhosa,
    Languages.yiddish,
    Languages.yoruba,
    Languages.zhuang,
    Languages.zulu,
  ];
}

class MyAlertDialog<T> extends StatelessWidget {
  /// Creates an alert dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  ///
  /// The [contentPadding] must not be null. The [titlePadding] defaults to
  /// null, which implies a default that depends on the values of the other
  /// properties. See the documentation of [titlePadding] for details.
  const MyAlertDialog({
    super.key,
    this.title,
    this.titlePadding,
    this.content,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    this.actions,
    this.semanticLabel,
    this.divider = const Divider(
      height: 0.0,
    ),
    this.isDividerEnabled = true,
  });

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget? title;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided. Otherwise, this padding
  /// is used.
  ///
  /// This property defaults to providing 24 pixels on the top, left, and right
  /// of the title. If the [content] is not null, then no bottom padding is
  /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
  /// pixels of bottom padding is added to separate the [title] from the
  /// [actions].
  final EdgeInsetsGeometry? titlePadding;

  /// The (optional) content of the dialog is displayed in the center of the
  /// dialog in a lighter font.
  ///
  /// Typically, this is a [ListView] containing the contents of the dialog.
  /// Using a [ListView] ensures that the contents can scroll if they are too
  /// big to fit on the display.
  final Widget? content;

  /// Padding around the content.
  ///
  /// If there is no content, no padding will be provided. Otherwise, padding of
  /// 20 pixels is provided above the content to separate the content from the
  /// title, and padding of 24 pixels is provided on the left, right, and bottom
  /// to separate the content from the other edges of the dialog.
  final EdgeInsetsGeometry contentPadding;

  /// The (optional) set of actions that are displayed at the bottom of the
  /// dialog.
  ///
  /// Typically this is a list of [TextButton] widgets.
  ///
  /// These widgets will be wrapped in a [ButtonBar], which introduces 8 pixels
  /// of padding on each side.
  ///
  /// If the [title] is not null but the [content] _is_ null, then an extra 20
  /// pixels of padding is added above the [ButtonBar] to separate the [title]
  /// from the [actions].
  final List<Widget>? actions;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  ///
  /// If this label is not provided, a semantic label will be infered from the
  /// [title] if it is not null.  If there is no title, the label will be taken
  /// from [MaterialLocalizations.alertDialogLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.isRouteName], for a description of how this
  ///    value is used.
  final String? semanticLabel;

  /// The (optional) horizontal separator used between title, content and
  /// actions.
  ///
  /// If this divider is not provided a [Divider] is used with [height]
  /// property is set to 0.0
  final Widget divider;

  ///[divider] is not displayed if set to false. Default is set to true.
  final bool isDividerEnabled;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    String? label = semanticLabel;

    if (title != null) {
      children.add(Padding(
        padding: titlePadding ??
            EdgeInsets.fromLTRB(
                24.0, 24.0, 24.0, isDividerEnabled ? 20.0 : 0.0,),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.titleLarge!,
          child: Semantics(namesRoute: true, child: title),
        ),
      ),);
      if (isDividerEnabled) children.add(divider);
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          label = semanticLabel;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.windows:
        case TargetPlatform.linux:
          label = semanticLabel ??
              MaterialLocalizations.of(context).alertDialogLabel;
          break;
      }
    }

    if (content != null) {
      children.add(Flexible(
        child: Padding(
          padding: contentPadding,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleMedium!,
            child: content!,
          ),
        ),
      ),);
    }

    if (actions != null) {
      if (isDividerEnabled) children.add(divider);
      children.add(
        ButtonBar(
          children: actions!,
        ),
      );
    }

    Widget dialogChild = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );

    if (label != null) {
      dialogChild =
          Semantics(namesRoute: true, label: label, child: dialogChild);
    }

    return Dialog(child: dialogChild);
  }
}

typedef ItemBuilder = Widget Function(Language language);
