exports.context = {
  init: function(settings) {
    var state =
      { username: ''
      }
    if (settings.env === 'dev') {}
    return state
  },
  ports: ports
}

function ports(settings, app, state) {
  var handler = prod;
  if (settings.env === 'dev') {
    handler = dev;
  }
  app.ports.auth_LogIn.subscribe(handler.handle_LogIn(app))
}

var dev = {
  handle_LogIn: function(app) {
    var error = null;
    var result = '';
    //error = incorrectUsernamdOrPassword;
    //error = passwordLengthOrContext;
    //error = invalidEmail;
    //error = notImplemented;

    return function (data) {
      if (error !== null) {
        app.ports.auth_LogInError.send(error);
        return;
      }
      app.ports.auth_LogInSuccess.send({ result: result });
    }
  }
}

var prod = {
  handle_LogIn: function(app) {
    return auth(app).logIn;
  }
}
