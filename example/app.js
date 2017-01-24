(function() {

'use strict';

// console.log('pull in cognito: ')
// var provider = require('elm-cognito')
// console.log('pulled in cognito')

require( './Stylesheets' );

// var creds = require('./credentials')

var page = [ 'Example' ];

var settings =
  { env: 'dev'
  // { env: 'prod'
  // , cognito:
  //   { creds: creds
  //   }
  };

// console.log('example app settings: ', settings)

var path = page.join('/');
var bootstrap = require( './src/' + path + '/_Bootstrap');
var ctrl = require('./src/' + path + '/Stub');
var i = 0;
var l = page.length;
while(i < l) {
  ctrl = ctrl[page[i]]; // Step down the relative path to the component
  i++
}
var ctx = bootstrap.context;
if (typeof ctx === 'undefined' || ctx === null) {
  ctx = {}
}
var state = null;
if (typeof ctx.init !== 'undefined' || ctx.init === null) {
  state = ctx.init(settings);
}

var app = ctrl.Stub.fullscreen(state);
if (typeof ctx.ports !== 'undefined' || ctx.init === null) {
  ctx.ports(settings, app, state);
}

})();

// ,
//     "aws-sdk": "2.7.27"