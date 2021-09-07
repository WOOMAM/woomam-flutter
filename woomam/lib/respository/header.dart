generateHeader({String? token}) => {
      if (token != null) ...{"Authorization": 'Bearer ' + token},
      "Content-Type": "application/json; charset=utf-8"
    };
