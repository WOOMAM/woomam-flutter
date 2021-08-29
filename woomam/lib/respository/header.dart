generateHeader({String? token}) => {
      "Content-Type": "application/json; charset=utf-8",
      if (token != null) ...{"Authorization": 'Bearer ' + token}
    };
