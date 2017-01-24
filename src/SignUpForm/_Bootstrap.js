exports.context = {
  init: function(settings) {
    var state = {}
    if (settings.env === 'dev') {}
    return state
  },
  ports: function(settings, app, state) {
    if (settings.env === 'dev') {}
  }
}