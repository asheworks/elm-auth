'use strict';

var auth = require('elm-auth')
var providerFunc = require('elm-cognito')

var creds = require('./credentials')

exports.context = {
  init: function(settings) {
    var state = null;
    
    // Auth - Initialize the provider
    settings.auth =
      { provider: providerFunc( { creds: creds } )
      }
    auth.context.init(settings)
    
    if (settings.env === 'dev') {}

    return state
  },
  ports: function(settings, app, state) {

    // Auth - Bind ports
    auth.context.ports(settings, app, state)

  }
}

// var AWS = require('aws-sdk')
// var AmazonCognitoIdentity = require('amazon-cognito-identity-js')
// var CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool
//// var CognitoUserAttribute = AmazonCognitoIdentity.CognitoUserAttribute


/*
Initialize the ambient AWS service config
*/
// AWS.Config.region = creds.region
// AWS.Config.credentials = new AWS.CognitoIdentityCredentials({
//   IdentityPoolId: creds.identityPoolId
// })

// var poolData =
//   { UserPoolId: creds.userPoolId
//   , ClientId: creds.clientId
//   }
// var userPool = new CognitoUserPool(poolData)

// var cognito = null
// try {
//   cognito = new AWS.CognitoIdentity()
// } catch (ex) {
//   console.log('Error making cognito: ', ex)
// }

// try {
//   var authenticationData = {
//         Username : 'test0001',
//         Password : '@Password1',
//     };
//     var authenticationDetails = new AmazonCognitoIdentity.AuthenticationDetails(authenticationData);
//     // var authenticationDetails = new AWSCognito.CognitoIdentityServiceProvider.AuthenticationDetails(authenticationData);

//     var userData = {
//         Username : 'test0001',
//         Pool : userPool
//     };
//     // var cognitoUser = new AWSCognito.CognitoIdentityServiceProvider.CognitoUser(userData);
//     var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);

//     cognitoUser.authenticateUser(authenticationDetails, {
//         onSuccess: function (result) {
//             console.log('access token + ' + result.getAccessToken().getJwtToken());
//         },
//         onFailure: function(err) {
//             console.log('Cognito error: ', err);
//         }
//     });
// } catch(ex) {
//   console.log('Error calling cognito: ', ex)
// }


// var noop = () => {}

// var handler =
//   { changePassword :
//     { success : noop
//     , failure : noop
//     , error : noop
//     }
//   , confirmRegistration :
//     { success : noop
//     , error : noop
//     }
//   , deleteUser :
//     { success : noop
//     , error : noop
//     }
//   , forgotPassword :
//     { success : noop
//     , error : noop
//     }
//   , logIn :
//     { success : noop
//     , failure : noop
//     , error : noop
//     , mfaRequired : noop
//     , newPasswordRequired : noop
//     }
//   , logOut : 
//     { success : noop
//     , error : noop
//     }
//   , resendConfirmationCode :
//     { success : noop
//     , error : noop
//     }
//   , resetPassword :
//     { success : noop
//     , error : noop
//     }
//   , signOut :
//     { complete : noop
//     }
//   , signUp :
//     { success : noop
//     , error : noop
//     }
//   }