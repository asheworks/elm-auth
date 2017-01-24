"use strict"


var AWS = require('aws-sdk')

// console.log('grab the cognito stuff: ', AWS.VERSION)

// var AWSCognito = new AWS.CognitoIdentity()
var AmazonCognitoIdentity = require('amazon-cognito-identity-js')

// console.log('grabbed the cognito stuff: ', AWSCognito)

// var cognito = require('./cognito')
var providerFunc = require('elm-cognito')

var creds = require('./credentials')

var noop = () => {}

var mockHandler =
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

function getMockHandler(impl) {
  return Object.assign({}, mockHandler, impl)
}

// test('does stuff', () => {
//   const service = cognito
//     ( getMockHandler(
//       { logIn :
//         { success : (res) => { console.log('* login success: ', res) }
//         , error : (err) => { console.log('* login error: ', err) }
//         }
//       }
//     )
//     , { region: 'us-west-2'
//       , userPoolId: 'us-west-2_wUnhKNf1i'
//       , clientId: 'dnpjkp19h2snr4ek0voht8j2n'
//       }
//     )
//   service.logIn
//     ( { username : 'test0001'
//       , password : 'P@ssw0rd'
//       }
//     )
// })

test('does stuff', () => {
  const config =
      { creds: creds
      , aws: AWS
      , cognito: new AWS.CognitoIdentity()
      , identity: AmazonCognitoIdentity
      }
  // console.log('cognito: ', cognito)
  // const provider = cognito( config )
  const provider = providerFunc( config )
  // console.log('provider: ', provider)
  const service = provider(
    getMockHandler(
      { logIn :
        { success:
          (res) => {
            console.log('* login success: ', res)
          }
        , error:
          (err) => {
            console.log('* login error: ', err)
          }
        }
      }
    )
  )
  console.log('do log in')
    
  service.logIn
    ( { username : 'test0001'
      , password : '@Password1'
      }
    )
})

// test('fail auth due to REQUIRE_PASSWORD_RESET', () => {
//   const service = cognito
//     ( getMockHandler(
//       { logIn :
//         { success : (res) => { console.log('* login success: ', res) }
//         , error : (err) => { console.log('* login error: ', err) }
//         }
//       }
//     )
//     , creds
//     )
//   service.logIn
//     ( { username : 'test0002'
//       , password : 'P@ssw0rd'
//       }
//     )
// })

// test('fail auth due to USER DOES NOT EXIST', () => {
//   const service = cognito
//     ( getMockHandler(
//       { logIn :
//         { success : (res) => { console.log('* login success: ', res) }
//         , error : (err) => { console.log('* login error: ', err) }
//         }
//       }
//     )
//     , creds
//     )
//   service.logIn
//     ( { username : 'test0003'
//       , password : 'P@ssw0rd'
//       }
//     )
// })