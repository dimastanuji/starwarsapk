class Local{
  int _id;
	String _nama;
	String _url;
  String _date;
  int _priority;

  Local(this._nama, this._date, this._url, this._priority);

	Local.withId(this._id, this._nama, this._date, this._url,this._priority);

	int get id => _id;

	String get nama => _nama;

  String get date => _date;

	String get url => _url;

  int get priority => _priority;

	set nama(String newNama) {
		if (newNama.length <= 255) {
			this._nama = newNama;
		}
	}

	set url(String newUrl) {
		if (newUrl.length <= 255) {
			this._url = newUrl;
		}
	}

  set priority(int newPriority) {
		if (newPriority >= 1 && newPriority <= 2) {
			this._priority = newPriority;
		}
	}

  set date(String newDate) {
		this._date = newDate;
	}

	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['nama'] = _nama;
		map['url'] = _url;
    map['priority'] = _priority;
    map['date'] = _date;
		return map;
	}

	// Extract a Note object from a Map object
	Local.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._nama = map['nama'];
		this._url = map['url'];
    this._priority = map['priority'];
    this._date = map['date'];
	}
}