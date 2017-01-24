'use strict';
 var AWS = require('aws-sdk');


// AWS.config.region = 'ap-northeast-1'; // Region
// AWS.config.credentials = new AWS.CognitoIdentityCredentials({
//     IdentityPoolId: 'ap-northeast-1:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' // your identity pool id here
// });

// // Need to provide placeholder keys unless unauthorised user access is enabled for user pool
// //AWSCognito.config.update({accessKeyId: 'anything', secretAccessKey: 'anything'})

// var poolData = {
//     UserPoolId : 'us-east-1_xxxxxxxxx',
//     ClientId : 'xxxxxxxxxxxxxxxxxxxxxxxxx'
// };
// var userPool = new AWS.CognitoIdentityServiceProvider.CognitoUserPool(poolData);


// var AWS = require('aws-sdk')

// var AWS = window.AWS

console.log('AWS: ')
console.log(AWS)

var creds = require('./credentials')
console.log('creds: ', creds)

AWS.Config.region = creds.region
AWS.Config.credentials = new AWS.CognitoIdentityCredentials({
  IdentityPoolId: ''
})

// var SDK = require('aws-cognito-sdk')
// console.log(SDK)
// // console.log('AmazonCognitoIdentity: ', AmazonCognitoIdentity)
// console.log('CognitoIdentity')
// console.log(new AWS.CognitoIdentity())


var AmazonCognitoIdentity = require('amazon-cognito-identity-js')
console.log('AmazonCognitoIdentity')
console.log(AmazonCognitoIdentity)
//var AmazonCognitoIdentity = new AWS.CognitoIdentity()
// var AmazonCognitoIdentity = new AWS.CognitoIdentityServiceProvider()

// console.log('AWSCognito')
// console.log(AWSCognito)

// console.log('ServiceProvider')
// console.log(AWSCognito.CognitoIdentityServiceProvider.CognitoUserPool)

console.log('auth Example Bootstrap: ')


var CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool
var CognitoUserAttribute = AmazonCognitoIdentity.CognitoUserAttribute

console.log('CognitoUserPool: ', CognitoUserPool)
console.log('CognitoUserAttribute: ', CognitoUserAttribute)

// console.log('AWSCognito: ', AWSCognito)


var providerFunc = require('elm-cognito')



var poolData =
  { UserPoolId: creds.userPoolId
  , ClientId: creds.clientId
  }



console.log('Make UserPool')
var userPool = new CognitoUserPool(poolData)
// var userPool = new AWSCognito.CognitoIdentityServiceProvider.CognitoUserPool(poolData)

console.log('UserPool: ', userPool)

//var AWSCognito = new AWS.CognitoIdentity()
// var AmazonCognitoIdentity = require('amazon-cognito-identity-js')

// console.log('got aws... ')
// var providerFunc = require('elm-cognito')
// var auth = require('../../src/bootstrap')

var auth = require('elm-auth')

// console.log('provider: ', providerFunc)
// console.log('auth: ', auth)

exports.context = {
  init: function(settings) {
    var state = null;
    console.log('Example bootstrap init')
    var cognito = null
    try {
      cognito = new AWS.CognitoIdentity()
    } catch (ex) {
      console.log('Error making cognito: ', ex)
      console.log('AWS.VERSION: ', AWS.VERSION)
    }
    console.log('AWS Cognito Made')
    const config =
      { creds: creds
      , aws: AWS
      , cognito: cognito
      , identity: AmazonCognitoIdentity
      }
    
    var provider = providerFunc( config )

    console.log('provider: ', provider)
    var service = provider(handler)
    console.log('service: ', service)
    // var _auth = auth( provider )
    // // provider( auth )
    // settings.auth = _auth
    settings.auth =
      { provider: provider
      }
    // const provider = providerFunc( config )

    // settings.auth.provider = providerFunc( config )
    auth.context.init(settings) // Initialize the auth bootstrap
    
    
    //auth.context.init(settings)
    console.log('making service')
    var service = settings.auth.provider(handler)
    console.log('made service')

    // settings.auth = auth(
    //   { provider: provider
    //   , config: 
    //   }
    // )
    if (settings.env === 'dev') {
    }
    return state
  },
  ports: function(settings, app, state) {
    console.log('Example bootstrap ports')
    auth.context.ports(settings, app, state)
  }
}

var noop = () => {}

var handler =
  { changePassword :
    { success : noop
    , failure : noop
    , error : noop
    }
  , confirmRegistration :
    { success : noop
    , error : noop
    }
  , deleteUser :
    { success : noop
    , error : noop
    }
  , forgotPassword :
    { success : noop
    , error : noop
    }
  , logIn :
    { success : noop
    , failure : noop
    , error : noop
    , mfaRequired : noop
    , newPasswordRequired : noop
    }
  , logOut : 
    { success : noop
    , error : noop
    }
  , resendConfirmationCode :
    { success : noop
    , error : noop
    }
  , resetPassword :
    { success : noop
    , error : noop
    }
  , signOut :
    { complete : noop
    }
  , signUp :
    { success : noop
    , error : noop
    }
  }