class ProfileData {
  Map<String, Map<String, dynamic>> pdata = {
    "mohammed@gmail.com": {
      "email": "mohammed@gmail.com",
      "Name": "Mohammed Yezid",
      "password": "123456789",
      "Education": "Addis Ababa Science and Technology University - AASTU",
      "Skills": "Mobile development , web Development",
      "Experience": "Junior Flutter Developer",
      "Address": "Addis Ababa, Bole",
      "Github": "https://github.com/ibnuyezid"
    }
  };

  Map<String, Map> get getPdata => pdata;
  setPdata(String email, Map<String, dynamic> data) {
    if (!pdata.containsKey(email)) {
      pdata[email] = data;
    }
  }
}
