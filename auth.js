"use strict"

var noop = function() {}

var cognito = null

exports.context = {
  init: function(settings) {
    var state = null;
    if (settings.env === 'dev') {
    }
    return state
  },
  ports: function(settings, app, state) {
    try {
      settings.auth.provider(app.ports)
    } catch(ex) {
      console.log('Provider error: ', ex)
    }
  }
}
