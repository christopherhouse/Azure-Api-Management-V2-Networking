@secure()
param users_1_lastName string
param service_apim_apimv2_afd_name string = 'apim-apimv2-afd'
param virtualNetworks_vn_apimv2_afd_externalid string = '/subscriptions/c5d4a6e8-69bf-4148-be25-cb362f83c370/resourceGroups/RG-APIMV2-AFD/providers/Microsoft.Network/virtualNetworks/vn-apimv2-afd'

resource service_apim_apimv2_afd_name_resource 'Microsoft.ApiManagement/service@2024-06-01-preview' = {
  name: service_apim_apimv2_afd_name
  location: 'East US 2'
  sku: {
    name: 'StandardV2'
    capacity: 1
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    publisherEmail: 'apis@contoso.net'
    publisherName: 'Contoso'
    notificationSenderEmail: 'apimgmt-noreply@mail.windowsazure.com'
    hostnameConfigurations: [
      {
        type: 'Proxy'
        hostName: '${service_apim_apimv2_afd_name}.azure-api.net'
        negotiateClientCertificate: false
        defaultSslBinding: true
        certificateSource: 'BuiltIn'
      }
    ]
    virtualNetworkConfiguration: {
      subnetResourceId: '${virtualNetworks_vn_apimv2_afd_externalid}/subnets/apim-out'
    }
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Protocols.Server.Http2': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Ssl30': 'False'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Ciphers.TripleDes168': 'False'
    }
    virtualNetworkType: 'External'
    natGatewayState: 'Enabled'
    apiVersionConstraint: {}
    publicNetworkAccess: 'Disabled'
    privateEndpointConnections: [
      {
        id: service_apim_apimv2_afd_name_service_apim_apimv2_afd_name_pe.id
        name: '${service_apim_apimv2_afd_name}-pe'
        type: 'Microsoft.ApiManagement/service/privateEndpointConnections'
        properties: {
          privateEndpoint: {}
          privateLinkServiceConnectionState: {
            status: 'Approved'
          }
        }
      }
      {
        id: service_apim_apimv2_afd_name_edbc57da_c84c_47c5_b8d8_09ff37c801f8.id
        name: 'edbc57da-c84c-47c5-b8d8-09ff37c801f8'
        type: 'Microsoft.ApiManagement/service/privateEndpointConnections'
        properties: {
          privateEndpoint: {}
          privateLinkServiceConnectionState: {
            status: 'Pending'
            description: 'Approve me'
          }
        }
      }
    ]
    legacyPortalStatus: 'Disabled'
    developerPortalStatus: 'Disabled'
    releaseChannel: 'Default'
  }
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0 'Microsoft.ApiManagement/service/apis@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/swagger-petstore-openapi-3-0'
  properties: {
    displayName: 'Swagger Petstore - OpenAPI 3.0'
    apiRevision: '1'
    description: 'This is a sample Pet Store Server based on the OpenAPI 3.0 specification.  You can find out more about\nSwagger at [https://swagger.io](https://swagger.io). In the third iteration of the pet store, we\'ve switched to the design first approach!\nYou can now help us improve the API whether it\'s by making changes to the definition itself or to the code.\nThat way, with time, we can improve the API in general, and expose some of the new features in OAS3.\n\nSome useful links:\n- [The Pet Store repository](https://github.com/swagger-api/swagger-petstore)\n- [The source API definition for the Pet Store](https://github.com/swagger-api/swagger-petstore/blob/master/src/main/resources/openapi.yaml)'
    subscriptionRequired: true
    serviceUrl: 'https://petstore3.swagger.io/api/v3'
    path: 'api/pets'
    protocols: [
      'https'
    ]
    authenticationSettings: {
      oAuth2AuthenticationSettings: []
      openidAuthenticationSettings: []
    }
    subscriptionKeyParameterNames: {
      header: 'Ocp-Apim-Subscription-Key'
      query: 'subscription-key'
    }
    termsOfServiceUrl: 'https://swagger.io/terms/'
    contact: {
      email: 'apiteam@swagger.io'
    }
    license: {
      name: 'Apache 2.0'
      url: 'https://www.apache.org/licenses/LICENSE-2.0.html'
    }
    isCurrent: true
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_administrators 'Microsoft.ApiManagement/service/groups@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/administrators'
  properties: {
    displayName: 'Administrators'
    description: 'Administrators is a built-in group containing the admin email account provided at the time of service creation. Its membership is managed by the system.'
    type: 'system'
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_developers 'Microsoft.ApiManagement/service/groups@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/developers'
  properties: {
    displayName: 'Developers'
    description: 'Developers is a built-in group. Its membership is managed by the system. Signed-in users fall into this group.'
    type: 'system'
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_guests 'Microsoft.ApiManagement/service/groups@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/guests'
  properties: {
    displayName: 'Guests'
    description: 'Guests is a built-in group. Its membership is managed by the system. Unauthenticated users visiting the developer portal fall into this group.'
    type: 'system'
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_azuremonitor 'Microsoft.ApiManagement/service/loggers@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/azuremonitor'
  properties: {
    loggerType: 'azureMonitor'
    isBuffered: true
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_AccountClosedPublisher 'Microsoft.ApiManagement/service/notifications@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/AccountClosedPublisher'
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_BCC 'Microsoft.ApiManagement/service/notifications@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/BCC'
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_NewApplicationNotificationMessage 'Microsoft.ApiManagement/service/notifications@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/NewApplicationNotificationMessage'
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_NewIssuePublisherNotificationMessage 'Microsoft.ApiManagement/service/notifications@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/NewIssuePublisherNotificationMessage'
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_PurchasePublisherNotificationMessage 'Microsoft.ApiManagement/service/notifications@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/PurchasePublisherNotificationMessage'
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_QuotaLimitApproachingPublisherNotificationMessage 'Microsoft.ApiManagement/service/notifications@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/QuotaLimitApproachingPublisherNotificationMessage'
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_RequestPublisherNotificationMessage 'Microsoft.ApiManagement/service/notifications@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/RequestPublisherNotificationMessage'
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_policy 'Microsoft.ApiManagement/service/policies@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/policy'
  properties: {
    value: '<!--\r\n    IMPORTANT:\r\n    - Policy elements can appear only within the <inbound>, <outbound>, <backend> section elements.\r\n    - Only the <forward-request> policy element can appear within the <backend> section element.\r\n    - To apply a policy to the incoming request (before it is forwarded to the backend service), place a corresponding policy element within the <inbound> section element.\r\n    - To apply a policy to the outgoing response (before it is sent back to the caller), place a corresponding policy element within the <outbound> section element.\r\n    - To add a policy position the cursor at the desired insertion point and click on the round button associated with the policy.\r\n    - To remove a policy, delete the corresponding policy statement from the policy document.\r\n    - Policies are applied in the order of their appearance, from the top down.\r\n-->\r\n<policies>\r\n  <inbound></inbound>\r\n  <backend>\r\n    <forward-request />\r\n  </backend>\r\n  <outbound></outbound>\r\n</policies>'
    format: 'xml'
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_default 'Microsoft.ApiManagement/service/portalconfigs@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/default'
  properties: {
    enableBasicAuth: true
    signin: {
      require: false
    }
    signup: {
      termsOfService: {
        requireConsent: false
      }
    }
    delegation: {
      delegateRegistration: false
      delegateSubscription: false
    }
    cors: {
      allowedOrigins: []
    }
    csp: {
      mode: 'disabled'
      reportUri: []
      allowedSources: []
    }
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_20250507152852 'Microsoft.ApiManagement/service/portalRevisions@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/20250507152852'
  properties: {
    isCurrent: true
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_service_apim_apimv2_afd_name_pe 'Microsoft.ApiManagement/service/privateEndpointConnections@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/${service_apim_apimv2_afd_name}-pe'
  properties: {
    privateLinkServiceConnectionState: {
      status: 'Approved'
    }
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_edbc57da_c84c_47c5_b8d8_09ff37c801f8 'Microsoft.ApiManagement/service/privateEndpointConnections@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/edbc57da-c84c-47c5-b8d8-09ff37c801f8'
  properties: {
    privateLinkServiceConnectionState: {
      status: 'Pending'
      description: 'Approve me'
    }
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_master 'Microsoft.ApiManagement/service/subscriptions@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/master'
  properties: {
    scope: '${service_apim_apimv2_afd_name_resource.id}/'
    displayName: 'Built-in all-access subscription'
    state: 'active'
    allowTracing: false
  }
}

resource service_apim_apimv2_afd_name_pet 'Microsoft.ApiManagement/service/tags@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/pet'
  properties: {
    displayName: 'pet'
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_store 'Microsoft.ApiManagement/service/tags@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/store'
  properties: {
    displayName: 'store'
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_user 'Microsoft.ApiManagement/service/tags@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/user'
  properties: {
    displayName: 'user'
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_AccountClosedDeveloper 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/AccountClosedDeveloper'
  properties: {
    subject: 'Thank you for using the $OrganizationName API!'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          On behalf of $OrganizationName and our customers we thank you for giving us a try. Your $OrganizationName API account is now closed.\r\n        </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Thank you,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Your $OrganizationName Team</p>\r\n    <a href="$DevPortalUrl">$DevPortalUrl</a>\r\n    <p />\r\n  </body>\r\n</html>'
    title: 'Developer farewell letter'
    description: 'Developers receive this farewell email after they close their account.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_ApplicationApprovedNotificationMessage 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/ApplicationApprovedNotificationMessage'
  properties: {
    subject: 'Your application $AppName is published in the application gallery'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          We are happy to let you know that your request to publish the $AppName application in the application gallery has been approved. Your application has been published and can be viewed <a href="http://$DevPortalUrl/Applications/Details/$AppId">here</a>.\r\n        </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Best,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">The $OrganizationName API Team</p>\r\n  </body>\r\n</html>'
    title: 'Application gallery submission approved (deprecated)'
    description: 'Developers who submitted their application for publication in the application gallery on the developer portal receive this email after their submission is approved.'
    parameters: [
      {
        name: 'AppId'
        title: 'Application id'
      }
      {
        name: 'AppName'
        title: 'Application name'
      }
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_ConfirmSignUpIdentityDefault 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/ConfirmSignUpIdentityDefault'
  properties: {
    subject: 'Please confirm your new $OrganizationName API account'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head>\r\n    <meta charset="UTF-8" />\r\n    <title>Letter</title>\r\n  </head>\r\n  <body>\r\n    <table width="100%">\r\n      <tr>\r\n        <td>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'"></p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Thank you for joining the $OrganizationName API program! We host a growing number of cool APIs and strive to provide an awesome experience for API developers.</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">First order of business is to activate your account and get you going. To that end, please click on the following link:</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n            <a id="confirmUrl" href="$ConfirmUrl" style="text-decoration:none">\r\n              <strong>$ConfirmUrl</strong>\r\n            </a>\r\n          </p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">If clicking the link does not work, please copy-and-paste or re-type it into your browser\'s address bar and hit "Enter".</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Thank you,</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">$OrganizationName API Team</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n            <a href="$DevPortalUrl">$DevPortalUrl</a>\r\n          </p>\r\n        </td>\r\n      </tr>\r\n    </table>\r\n  </body>\r\n</html>'
    title: 'New developer account confirmation'
    description: 'Developers receive this email to confirm their e-mail address after they sign up for a new account.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
      {
        name: 'ConfirmUrl'
        title: 'Developer activation URL'
      }
      {
        name: 'DevPortalHost'
        title: 'Developer portal hostname'
      }
      {
        name: 'ConfirmQuery'
        title: 'Query string part of the activation URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_EmailChangeIdentityDefault 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/EmailChangeIdentityDefault'
  properties: {
    subject: 'Please confirm the new email associated with your $OrganizationName API account'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head>\r\n    <meta charset="UTF-8" />\r\n    <title>Letter</title>\r\n  </head>\r\n  <body>\r\n    <table width="100%">\r\n      <tr>\r\n        <td>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'"></p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">You are receiving this email because you made a change to the email address on your $OrganizationName API account.</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Please click on the following link to confirm the change:</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n            <a id="confirmUrl" href="$ConfirmUrl" style="text-decoration:none">\r\n              <strong>$ConfirmUrl</strong>\r\n            </a>\r\n          </p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">If clicking the link does not work, please copy-and-paste or re-type it into your browser\'s address bar and hit "Enter".</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Thank you,</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">$OrganizationName API Team</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n            <a href="$DevPortalUrl">$DevPortalUrl</a>\r\n          </p>\r\n        </td>\r\n      </tr>\r\n    </table>\r\n  </body>\r\n</html>'
    title: 'Email change confirmation'
    description: 'Developers receive this email to confirm a new e-mail address after they change their existing one associated with their account.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
      {
        name: 'ConfirmUrl'
        title: 'Developer confirmation URL'
      }
      {
        name: 'DevPortalHost'
        title: 'Developer portal hostname'
      }
      {
        name: 'ConfirmQuery'
        title: 'Query string part of the confirmation URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_InviteUserNotificationMessage 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/InviteUserNotificationMessage'
  properties: {
    subject: 'You are invited to join the $OrganizationName developer network'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          Your account has been created. Please follow the link below to visit the $OrganizationName developer portal and claim it:\r\n        </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n      <a href="$ConfirmUrl">$ConfirmUrl</a>\r\n    </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Best,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">The $OrganizationName API Team</p>\r\n  </body>\r\n</html>'
    title: 'Invite user'
    description: 'An e-mail invitation to create an account, sent on request by API publishers.'
    parameters: [
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'ConfirmUrl'
        title: 'Confirmation link'
      }
      {
        name: 'DevPortalHost'
        title: 'Developer portal hostname'
      }
      {
        name: 'ConfirmQuery'
        title: 'Query string part of the confirmation link'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_NewCommentNotificationMessage 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/NewCommentNotificationMessage'
  properties: {
    subject: '$IssueName issue has a new comment'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">This is a brief note to let you know that $CommenterFirstName $CommenterLastName made the following comment on the issue $IssueName you created:</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">$CommentText</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          To view the issue on the developer portal click <a href="http://$DevPortalUrl/issues/$IssueId">here</a>.\r\n        </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Best,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">The $OrganizationName API Team</p>\r\n  </body>\r\n</html>'
    title: 'New comment added to an issue (deprecated)'
    description: 'Developers receive this email when someone comments on the issue they created on the Issues page of the developer portal.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'CommenterFirstName'
        title: 'Commenter first name'
      }
      {
        name: 'CommenterLastName'
        title: 'Commenter last name'
      }
      {
        name: 'IssueId'
        title: 'Issue id'
      }
      {
        name: 'IssueName'
        title: 'Issue name'
      }
      {
        name: 'CommentText'
        title: 'Comment text'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_NewDeveloperNotificationMessage 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/NewDeveloperNotificationMessage'
  properties: {
    subject: 'Welcome to the $OrganizationName API!'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head>\r\n    <meta charset="UTF-8" />\r\n    <title>Letter</title>\r\n  </head>\r\n  <body>\r\n    <h1 style="color:#000505;font-size:18pt;font-family:\'Segoe UI\'">\r\n          Welcome to <span style="color:#003363">$OrganizationName API!</span></h1>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Your $OrganizationName API program registration is completed and we are thrilled to have you as a customer. Here are a few important bits of information for your reference:</p>\r\n    <table width="100%" style="margin:20px 0">\r\n      <tr>\r\n            #if ($IdentityProvider == "Basic")\r\n            <td width="50%" style="height:40px;vertical-align:top;font-family:\'Segoe UI\';font-size:12pt">\r\n              Please use the following <strong>username</strong> when signing into any of the \${OrganizationName}-hosted developer portals:\r\n            </td><td style="vertical-align:top;font-family:\'Segoe UI\';font-size:12pt"><strong>$DevUsername</strong></td>\r\n            #else\r\n            <td width="50%" style="height:40px;vertical-align:top;font-family:\'Segoe UI\';font-size:12pt">\r\n              Please use the following <strong>$IdentityProvider account</strong> when signing into any of the \${OrganizationName}-hosted developer portals:\r\n            </td><td style="vertical-align:top;font-family:\'Segoe UI\';font-size:12pt"><strong>$DevUsername</strong></td>            \r\n            #end\r\n          </tr>\r\n      <tr>\r\n        <td style="height:40px;vertical-align:top;font-family:\'Segoe UI\';font-size:12pt">\r\n              We will direct all communications to the following <strong>email address</strong>:\r\n            </td>\r\n        <td style="vertical-align:top;font-family:\'Segoe UI\';font-size:12pt">\r\n          <a href="mailto:$DevEmail" style="text-decoration:none">\r\n            <strong>$DevEmail</strong>\r\n          </a>\r\n        </td>\r\n      </tr>\r\n    </table>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Best of luck in your API pursuits!</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">$OrganizationName API Team</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n      <a href="http://$DevPortalUrl">$DevPortalUrl</a>\r\n    </p>\r\n  </body>\r\n</html>'
    title: 'Developer welcome letter'
    description: 'Developers receive this “welcome” email after they confirm their new account.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'DevUsername'
        title: 'Developer user name'
      }
      {
        name: 'DevEmail'
        title: 'Developer email'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
      {
        name: 'IdentityProvider'
        title: 'Identity Provider selected by Organization'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_NewIssueNotificationMessage 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/NewIssueNotificationMessage'
  properties: {
    subject: 'Your request $IssueName was received'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Thank you for contacting us. Our API team will review your issue and get back to you soon.</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          Click this <a href="http://$DevPortalUrl/issues/$IssueId">link</a> to view or edit your request.\r\n        </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Best,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">The $OrganizationName API Team</p>\r\n  </body>\r\n</html>'
    title: 'New issue received (deprecated)'
    description: 'This email is sent to developers after they create a new topic on the Issues page of the developer portal.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'IssueId'
        title: 'Issue id'
      }
      {
        name: 'IssueName'
        title: 'Issue name'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_PasswordResetByAdminNotificationMessage 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/PasswordResetByAdminNotificationMessage'
  properties: {
    subject: 'Your password was reset'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <table width="100%">\r\n      <tr>\r\n        <td>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'"></p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">The password of your $OrganizationName API account has been reset, per your request.</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n                Your new password is: <strong>$DevPassword</strong></p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Please make sure to change it next time you sign in.</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Thank you,</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">$OrganizationName API Team</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n            <a href="$DevPortalUrl">$DevPortalUrl</a>\r\n          </p>\r\n        </td>\r\n      </tr>\r\n    </table>\r\n  </body>\r\n</html>'
    title: 'Password reset by publisher notification (Password reset by admin)'
    description: 'Developers receive this email when the publisher resets their password.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'DevPassword'
        title: 'New Developer password'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_PasswordResetIdentityDefault 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/PasswordResetIdentityDefault'
  properties: {
    subject: 'Your password change request'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head>\r\n    <meta charset="UTF-8" />\r\n    <title>Letter</title>\r\n  </head>\r\n  <body>\r\n    <table width="100%">\r\n      <tr>\r\n        <td>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'"></p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">You are receiving this email because you requested to change the password on your $OrganizationName API account.</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Please click on the link below and follow instructions to create your new password:</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n            <a id="resetUrl" href="$ConfirmUrl" style="text-decoration:none">\r\n              <strong>$ConfirmUrl</strong>\r\n            </a>\r\n          </p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">If clicking the link does not work, please copy-and-paste or re-type it into your browser\'s address bar and hit "Enter".</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">Thank you,</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">$OrganizationName API Team</p>\r\n          <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n            <a href="$DevPortalUrl">$DevPortalUrl</a>\r\n          </p>\r\n        </td>\r\n      </tr>\r\n    </table>\r\n  </body>\r\n</html>'
    title: 'Password change confirmation'
    description: 'Developers receive this email when they request a password change of their account. The purpose of the email is to verify that the account owner made the request and to provide a one-time perishable URL for changing the password.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
      {
        name: 'ConfirmUrl'
        title: 'Developer new password instruction URL'
      }
      {
        name: 'DevPortalHost'
        title: 'Developer portal hostname'
      }
      {
        name: 'ConfirmQuery'
        title: 'Query string part of the instruction URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_PurchaseDeveloperNotificationMessage 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/PurchaseDeveloperNotificationMessage'
  properties: {
    subject: 'Your subscription to the $ProdName'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Greetings $DevFirstName $DevLastName!</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          Thank you for subscribing to the <a href="http://$DevPortalUrl/products/$ProdId"><strong>$ProdName</strong></a> and welcome to the $OrganizationName developer community. We are delighted to have you as part of the team and are looking forward to the amazing applications you will build using our API!\r\n        </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Below are a few subscription details for your reference:</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n      <ul>\r\n            #if ($SubStartDate != "")\r\n            <li style="font-size:12pt;font-family:\'Segoe UI\'">Start date: $SubStartDate</li>\r\n            #end\r\n            \r\n            #if ($SubTerm != "")\r\n            <li style="font-size:12pt;font-family:\'Segoe UI\'">Subscription term: $SubTerm</li>\r\n            #end\r\n          </ul>\r\n    </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n            Visit the developer <a href="http://$DevPortalUrl/developer">profile area</a> to manage your subscription and subscription keys\r\n        </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">A couple of pointers to help get you started:</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n      <strong>\r\n        <a href="http://$DevPortalUrl/docs/services?product=$ProdId">Learn about the API</a>\r\n      </strong>\r\n    </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">The API documentation provides all information necessary to make a request and to process a response. Code samples are provided per API operation in a variety of languages. Moreover, an interactive console allows making API calls directly from the developer portal without writing any code.</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n      <strong>\r\n        <a href="http://$DevPortalUrl/applications">Feature your app in the app gallery</a>\r\n      </strong>\r\n    </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">You can publish your application on our gallery for increased visibility to potential new users.</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n      <strong>\r\n        <a href="http://$DevPortalUrl/issues">Stay in touch</a>\r\n      </strong>\r\n    </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          If you have an issue, a question, a suggestion, a request, or if you just want to tell us something, go to the <a href="http://$DevPortalUrl/issues">Issues</a> page on the developer portal and create a new topic.\r\n        </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Happy hacking,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">The $OrganizationName API Team</p>\r\n    <a style="font-size:12pt;font-family:\'Segoe UI\'" href="http://$DevPortalUrl">$DevPortalUrl</a>\r\n  </body>\r\n</html>'
    title: 'New subscription activated'
    description: 'Developers receive this acknowledgement email after subscribing to a product.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'ProdId'
        title: 'Product ID'
      }
      {
        name: 'ProdName'
        title: 'Product name'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'SubStartDate'
        title: 'Subscription start date'
      }
      {
        name: 'SubTerm'
        title: 'Subscription term'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_QuotaLimitApproachingDeveloperNotificationMessage 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/QuotaLimitApproachingDeveloperNotificationMessage'
  properties: {
    subject: 'You are approaching an API quota limit'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head>\r\n    <style>\r\n          body {font-size:12pt; font-family:"Segoe UI","Segoe WP","Tahoma","Arial","sans-serif";}\r\n          .alert { color: red; }\r\n          .child1 { padding-left: 20px; }\r\n          .child2 { padding-left: 40px; }\r\n          .number { text-align: right; }\r\n          .text { text-align: left; }\r\n          th, td { padding: 4px 10px; min-width: 100px; }\r\n          th { background-color: #DDDDDD;}\r\n        </style>\r\n  </head>\r\n  <body>\r\n    <p>Greetings $DevFirstName $DevLastName!</p>\r\n    <p>\r\n          You are approaching the quota limit on you subscription to the <strong>$ProdName</strong> product (primary key $SubPrimaryKey).\r\n          #if ($QuotaResetDate != "")\r\n          This quota will be renewed on $QuotaResetDate.\r\n          #else\r\n          This quota will not be renewed.\r\n          #end\r\n        </p>\r\n    <p>Below are details on quota usage for the subscription:</p>\r\n    <p>\r\n      <table>\r\n        <thead>\r\n          <th class="text">Quota Scope</th>\r\n          <th class="number">Calls</th>\r\n          <th class="number">Call Quota</th>\r\n          <th class="number">Bandwidth</th>\r\n          <th class="number">Bandwidth Quota</th>\r\n        </thead>\r\n        <tbody>\r\n          <tr>\r\n            <td class="text">Subscription</td>\r\n            <td class="number">\r\n                  #if ($CallsAlert == true)\r\n                  <span class="alert">$Calls</span>\r\n                  #else\r\n                  $Calls\r\n                  #end\r\n                </td>\r\n            <td class="number">$CallQuota</td>\r\n            <td class="number">\r\n                  #if ($BandwidthAlert == true)\r\n                  <span class="alert">$Bandwidth</span>\r\n                  #else\r\n                  $Bandwidth\r\n                  #end\r\n                </td>\r\n            <td class="number">$BandwidthQuota</td>\r\n          </tr>\r\n              #foreach ($api in $Apis)\r\n              <tr><td class="child1 text">API: $api.Name</td><td class="number">\r\n                  #if ($api.CallsAlert == true)\r\n                  <span class="alert">$api.Calls</span>\r\n                  #else\r\n                  $api.Calls\r\n                  #end\r\n                </td><td class="number">$api.CallQuota</td><td class="number">\r\n                  #if ($api.BandwidthAlert == true)\r\n                  <span class="alert">$api.Bandwidth</span>\r\n                  #else\r\n                  $api.Bandwidth\r\n                  #end\r\n                </td><td class="number">$api.BandwidthQuota</td></tr>\r\n              #foreach ($operation in $api.Operations)\r\n              <tr><td class="child2 text">Operation: $operation.Name</td><td class="number">\r\n                  #if ($operation.CallsAlert == true)\r\n                  <span class="alert">$operation.Calls</span>\r\n                  #else\r\n                  $operation.Calls\r\n                  #end\r\n                </td><td class="number">$operation.CallQuota</td><td class="number">\r\n                  #if ($operation.BandwidthAlert == true)\r\n                  <span class="alert">$operation.Bandwidth</span>\r\n                  #else\r\n                  $operation.Bandwidth\r\n                  #end\r\n                </td><td class="number">$operation.BandwidthQuota</td></tr>\r\n              #end\r\n              #end\r\n            </tbody>\r\n      </table>\r\n    </p>\r\n    <p>Thank you,</p>\r\n    <p>$OrganizationName API Team</p>\r\n    <a href="$DevPortalUrl">$DevPortalUrl</a>\r\n    <p />\r\n  </body>\r\n</html>'
    title: 'Developer quota limit approaching notification'
    description: 'Developers receive this email to alert them when they are approaching a quota limit.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'ProdName'
        title: 'Product name'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'SubPrimaryKey'
        title: 'Primary Subscription key'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
      {
        name: 'QuotaResetDate'
        title: 'Quota reset date'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_RejectDeveloperNotificationMessage 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/RejectDeveloperNotificationMessage'
  properties: {
    subject: 'Your subscription request for the $ProdName'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          We would like to inform you that we reviewed your subscription request for the <strong>$ProdName</strong>.\r\n        </p>\r\n        #if ($SubDeclineReason == "")\r\n        <p style="font-size:12pt;font-family:\'Segoe UI\'">Regretfully, we were unable to approve it, as subscriptions are temporarily suspended at this time.</p>\r\n        #else\r\n        <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          Regretfully, we were unable to approve it at this time for the following reason:\r\n          <div style="margin-left: 1.5em;"> $SubDeclineReason </div></p>\r\n        #end\r\n        <p style="font-size:12pt;font-family:\'Segoe UI\'"> We truly appreciate your interest. </p><p style="font-size:12pt;font-family:\'Segoe UI\'">All the best,</p><p style="font-size:12pt;font-family:\'Segoe UI\'">The $OrganizationName API Team</p><a style="font-size:12pt;font-family:\'Segoe UI\'" href="http://$DevPortalUrl">$DevPortalUrl</a></body>\r\n</html>'
    title: 'Subscription request declined'
    description: 'This email is sent to developers when their subscription requests for products requiring publisher approval is declined.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'SubDeclineReason'
        title: 'Reason for declining subscription'
      }
      {
        name: 'ProdName'
        title: 'Product name'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_RequestDeveloperNotificationMessage 'Microsoft.ApiManagement/service/templates@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/RequestDeveloperNotificationMessage'
  properties: {
    subject: 'Your subscription request for the $ProdName'
    body: '<!DOCTYPE html >\r\n<html>\r\n  <head />\r\n  <body>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Dear $DevFirstName $DevLastName,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          Thank you for your interest in our <strong>$ProdName</strong> API product!\r\n        </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">\r\n          We were delighted to receive your subscription request. We will promptly review it and get back to you at <strong>$DevEmail</strong>.\r\n        </p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">Thank you,</p>\r\n    <p style="font-size:12pt;font-family:\'Segoe UI\'">The $OrganizationName API Team</p>\r\n    <a style="font-size:12pt;font-family:\'Segoe UI\'" href="http://$DevPortalUrl">$DevPortalUrl</a>\r\n  </body>\r\n</html>'
    title: 'Subscription request received'
    description: 'This email is sent to developers to acknowledge receipt of their subscription requests for products requiring publisher approval.'
    parameters: [
      {
        name: 'DevFirstName'
        title: 'Developer first name'
      }
      {
        name: 'DevLastName'
        title: 'Developer last name'
      }
      {
        name: 'DevEmail'
        title: 'Developer email'
      }
      {
        name: 'ProdName'
        title: 'Product name'
      }
      {
        name: 'OrganizationName'
        title: 'Organization name'
      }
      {
        name: 'DevPortalUrl'
        title: 'Developer portal URL'
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_1 'Microsoft.ApiManagement/service/users@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/1'
  properties: {
    firstName: 'Administrator'
    email: 'apis@contoso.net'
    state: 'active'
    identities: [
      {
        provider: 'Azure'
        id: 'apis@contoso.net'
      }
    ]
    lastName: users_1_lastName
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_addPet 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'addPet'
  properties: {
    displayName: 'Add a new pet to the store.'
    method: 'POST'
    urlTemplate: '/pet'
    templateParameters: []
    description: 'Add a new pet to the store.'
    request: {
      description: 'Create a new pet in the store'
      queryParameters: []
      headers: []
      representations: [
        {
          contentType: 'application/json'
          examples: {
            default: {
              value: {
                id: 10
                name: 'doggie'
                category: {
                  id: 1
                  name: 'Dogs'
                }
                photoUrls: [
                  'string'
                ]
                tags: [
                  {
                    id: 0
                    name: 'string'
                  }
                ]
                status: 'available'
              }
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Pet'
        }
        {
          contentType: 'application/xml'
          examples: {
            default: {
              value: '<pet>\r\n  <id>10</id>\r\n  <name>doggie</name>\r\n  <category>\r\n    <id>1</id>\r\n    <name>Dogs</name>\r\n  </category>\r\n  <photoUrls>\r\n    <photoUrl>string</photoUrl>\r\n  </photoUrls>\r\n  <tags>\r\n    <tag>\r\n      <id>0</id>\r\n      <name>string</name>\r\n    </tag>\r\n  </tags>\r\n  <status>available</status>\r\n</pet>'
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Pet'
        }
        {
          contentType: 'application/x-www-form-urlencoded'
          formParameters: [
            {
              name: 'id'
              type: 'integer'
              values: []
            }
            {
              name: 'name'
              type: 'string'
              values: []
            }
            {
              name: 'category'
              type: 'object'
              values: []
              schemaId: 'Category'
            }
            {
              name: 'photoUrls'
              type: 'array'
              values: []
            }
            {
              name: 'tags'
              type: 'array'
              values: []
            }
            {
              name: 'status'
              type: 'string'
              values: [
                'available'
                'pending'
                'sold'
              ]
            }
          ]
        }
      ]
    }
    responses: [
      {
        statusCode: 200
        description: 'Successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {
                  id: 10
                  name: 'doggie'
                  category: {
                    id: 1
                    name: 'Dogs'
                  }
                  photoUrls: [
                    'string'
                  ]
                  tags: [
                    {
                      id: 0
                      name: 'string'
                    }
                  ]
                  status: 'available'
                }
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Pet'
          }
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<pet>\r\n  <id>10</id>\r\n  <name>doggie</name>\r\n  <category>\r\n    <id>1</id>\r\n    <name>Dogs</name>\r\n  </category>\r\n  <photoUrls>\r\n    <photoUrl>string</photoUrl>\r\n  </photoUrls>\r\n  <tags>\r\n    <tag>\r\n      <id>0</id>\r\n      <name>string</name>\r\n    </tag>\r\n  </tags>\r\n  <status>available</status>\r\n</pet>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Pet'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid input'
        representations: []
        headers: []
      }
      {
        statusCode: 422
        description: 'Validation exception'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_createUser 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'createUser'
  properties: {
    displayName: 'Create user.'
    method: 'POST'
    urlTemplate: '/user'
    templateParameters: []
    description: 'This can only be done by the logged in user.'
    request: {
      description: 'Created user object'
      queryParameters: []
      headers: []
      representations: [
        {
          contentType: 'application/json'
          examples: {
            default: {
              value: {
                id: 10
                username: 'theUser'
                firstName: 'John'
                lastName: 'James'
                email: 'john@email.com'
                password: '12345'
                phone: '12345'
                userStatus: 1
              }
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'User'
        }
        {
          contentType: 'application/xml'
          examples: {
            default: {
              value: '<user>\r\n  <id>10</id>\r\n  <username>theUser</username>\r\n  <firstName>John</firstName>\r\n  <lastName>James</lastName>\r\n  <email>john@email.com</email>\r\n  <password>12345</password>\r\n  <phone>12345</phone>\r\n  <userStatus>1</userStatus>\r\n</user>'
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'User'
        }
        {
          contentType: 'application/x-www-form-urlencoded'
          formParameters: [
            {
              name: 'id'
              type: 'integer'
              values: []
            }
            {
              name: 'username'
              type: 'string'
              values: []
            }
            {
              name: 'firstName'
              type: 'string'
              values: []
            }
            {
              name: 'lastName'
              type: 'string'
              values: []
            }
            {
              name: 'email'
              type: 'string'
              values: []
            }
            {
              name: 'password'
              type: 'string'
              values: []
            }
            {
              name: 'phone'
              type: 'string'
              values: []
            }
            {
              name: 'userStatus'
              type: 'integer'
              values: []
            }
          ]
        }
      ]
    }
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {
                  id: 10
                  username: 'theUser'
                  firstName: 'John'
                  lastName: 'James'
                  email: 'john@email.com'
                  password: '12345'
                  phone: '12345'
                  userStatus: 1
                }
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'User'
          }
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<user>\r\n  <id>10</id>\r\n  <username>theUser</username>\r\n  <firstName>John</firstName>\r\n  <lastName>James</lastName>\r\n  <email>john@email.com</email>\r\n  <password>12345</password>\r\n  <phone>12345</phone>\r\n  <userStatus>1</userStatus>\r\n</user>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'User'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Unexpected error'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_createUsersWithListInput 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'createUsersWithListInput'
  properties: {
    displayName: 'Creates list of users with given input array.'
    method: 'POST'
    urlTemplate: '/user/createWithList'
    templateParameters: []
    description: 'Creates list of users with given input array.'
    request: {
      queryParameters: []
      headers: []
      representations: [
        {
          contentType: 'application/json'
          examples: {
            default: {
              value: [
                {
                  id: 10
                  username: 'theUser'
                  firstName: 'John'
                  lastName: 'James'
                  email: 'john@email.com'
                  password: '12345'
                  phone: '12345'
                  userStatus: 1
                }
              ]
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'UserCreateWithListPostRequest'
        }
      ]
    }
    responses: [
      {
        statusCode: 200
        description: 'Successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {
                  id: 10
                  username: 'theUser'
                  firstName: 'John'
                  lastName: 'James'
                  email: 'john@email.com'
                  password: '12345'
                  phone: '12345'
                  userStatus: 1
                }
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'User'
          }
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<user>\r\n  <id>10</id>\r\n  <username>theUser</username>\r\n  <firstName>John</firstName>\r\n  <lastName>James</lastName>\r\n  <email>john@email.com</email>\r\n  <password>12345</password>\r\n  <phone>12345</phone>\r\n  <userStatus>1</userStatus>\r\n</user>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'User'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Unexpected error'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deleteOrder 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'deleteOrder'
  properties: {
    displayName: 'Delete purchase order by identifier.'
    method: 'DELETE'
    urlTemplate: '/store/order/{orderId}'
    templateParameters: [
      {
        name: 'orderId'
        description: 'Format - int64. ID of the order that needs to be deleted'
        type: 'integer'
        required: true
        values: []
        schemaId: '681bc40410b10e0ce475cb2d'
        typeName: 'StoreOrder-orderId-DeleteRequest'
      }
    ]
    description: 'For valid response try integer IDs with value < 1000. Anything above 1000 or non-integers will generate API errors.'
    responses: [
      {
        statusCode: 200
        description: 'order deleted'
        representations: []
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid ID supplied'
        representations: []
        headers: []
      }
      {
        statusCode: 404
        description: 'Order not found'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deletePet 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'deletePet'
  properties: {
    displayName: 'Deletes a pet.'
    method: 'DELETE'
    urlTemplate: '/pet/{petId}'
    templateParameters: [
      {
        name: 'petId'
        description: 'Format - int64. Pet id to delete'
        type: 'integer'
        required: true
        values: []
        schemaId: '681bc40410b10e0ce475cb2d'
        typeName: 'Pet-petId-DeleteRequest-1'
      }
    ]
    description: 'Delete a pet.'
    request: {
      queryParameters: []
      headers: [
        {
          name: 'api_key'
          type: 'string'
          values: []
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Pet-petId-DeleteRequest'
        }
      ]
      representations: []
    }
    responses: [
      {
        statusCode: 200
        description: 'Pet deleted'
        representations: []
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid pet value'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deleteUser 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'deleteUser'
  properties: {
    displayName: 'Delete user resource.'
    method: 'DELETE'
    urlTemplate: '/user/{username}'
    templateParameters: [
      {
        name: 'username'
        description: 'The name that needs to be deleted'
        type: 'string'
        required: true
        values: []
        schemaId: '681bc40410b10e0ce475cb2d'
        typeName: 'User-username-DeleteRequest'
      }
    ]
    description: 'This can only be done by the logged in user.'
    responses: [
      {
        statusCode: 200
        description: 'User deleted'
        representations: []
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid username supplied'
        representations: []
        headers: []
      }
      {
        statusCode: 404
        description: 'User not found'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_findPetsByStatus 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'findPetsByStatus'
  properties: {
    displayName: 'Finds Pets by status.'
    method: 'GET'
    urlTemplate: '/pet/findByStatus'
    templateParameters: []
    description: 'Multiple status values can be provided with comma separated strings.'
    request: {
      queryParameters: [
        {
          name: 'status'
          description: 'Status values that need to be considered for filter'
          type: 'string'
          defaultValue: 'available'
          values: [
            'available'
            'pending'
            'sold'
          ]
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'PetFindByStatusGetRequest'
        }
      ]
      headers: []
      representations: []
    }
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: [
                  {
                    id: 10
                    name: 'doggie'
                    category: {
                      id: 1
                      name: 'Dogs'
                    }
                    photoUrls: [
                      'string'
                    ]
                    tags: [
                      {
                        id: 0
                        name: 'string'
                      }
                    ]
                    status: 'available'
                  }
                ]
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'PetFindByStatusGet200ApplicationJsonResponse'
          }
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<pet>\r\n  <id>10</id>\r\n  <name>doggie</name>\r\n  <category>\r\n    <id>1</id>\r\n    <name>Dogs</name>\r\n  </category>\r\n  <photoUrls>\r\n    <photoUrl>string</photoUrl>\r\n  </photoUrls>\r\n  <tags>\r\n    <tag>\r\n      <id>0</id>\r\n      <name>string</name>\r\n    </tag>\r\n  </tags>\r\n  <status>available</status>\r\n</pet>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'PetFindByStatusGet200ApplicationXmlResponse'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid status value'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_findPetsByTags 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'findPetsByTags'
  properties: {
    displayName: 'Finds Pets by tags.'
    method: 'GET'
    urlTemplate: '/pet/findByTags'
    templateParameters: []
    description: 'Multiple tags can be provided with comma separated strings. Use tag1, tag2, tag3 for testing.'
    request: {
      queryParameters: [
        {
          name: 'tags'
          description: 'Tags to filter by'
          type: 'array'
          values: []
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'PetFindByTagsGetRequest'
        }
      ]
      headers: []
      representations: []
    }
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: [
                  {
                    id: 10
                    name: 'doggie'
                    category: {
                      id: 1
                      name: 'Dogs'
                    }
                    photoUrls: [
                      'string'
                    ]
                    tags: [
                      {
                        id: 0
                        name: 'string'
                      }
                    ]
                    status: 'available'
                  }
                ]
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'PetFindByTagsGet200ApplicationJsonResponse'
          }
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<pet>\r\n  <id>10</id>\r\n  <name>doggie</name>\r\n  <category>\r\n    <id>1</id>\r\n    <name>Dogs</name>\r\n  </category>\r\n  <photoUrls>\r\n    <photoUrl>string</photoUrl>\r\n  </photoUrls>\r\n  <tags>\r\n    <tag>\r\n      <id>0</id>\r\n      <name>string</name>\r\n    </tag>\r\n  </tags>\r\n  <status>available</status>\r\n</pet>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'PetFindByTagsGet200ApplicationXmlResponse'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid tag value'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getInventory 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'getInventory'
  properties: {
    displayName: 'Returns pet inventories by status.'
    method: 'GET'
    urlTemplate: '/store/inventory'
    templateParameters: []
    description: 'Returns a map of status codes to quantities.'
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {}
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'StoreInventoryGet200ApplicationJsonResponse'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Unexpected error'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getOrderById 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'getOrderById'
  properties: {
    displayName: 'Find purchase order by ID.'
    method: 'GET'
    urlTemplate: '/store/order/{orderId}'
    templateParameters: [
      {
        name: 'orderId'
        description: 'Format - int64. ID of order that needs to be fetched'
        type: 'integer'
        required: true
        values: []
        schemaId: '681bc40410b10e0ce475cb2d'
        typeName: 'StoreOrder-orderId-GetRequest'
      }
    ]
    description: 'For valid response try integer IDs with value <= 5 or > 10. Other values will generate exceptions.'
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {
                  id: 10
                  petId: 198772
                  quantity: 7
                  shipDate: 'string'
                  status: 'approved'
                  complete: true
                }
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Order'
          }
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<order>\r\n  <id>10</id>\r\n  <petId>198772</petId>\r\n  <quantity>7</quantity>\r\n  <shipDate>string</shipDate>\r\n  <status>approved</status>\r\n  <complete>true</complete>\r\n</order>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Order'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid ID supplied'
        representations: []
        headers: []
      }
      {
        statusCode: 404
        description: 'Order not found'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getPetById 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'getPetById'
  properties: {
    displayName: 'Find pet by ID.'
    method: 'GET'
    urlTemplate: '/pet/{petId}'
    templateParameters: [
      {
        name: 'petId'
        description: 'Format - int64. ID of pet to return'
        type: 'integer'
        required: true
        values: []
        schemaId: '681bc40410b10e0ce475cb2d'
        typeName: 'Pet-petId-GetRequest'
      }
    ]
    description: 'Returns a single pet.'
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {
                  id: 10
                  name: 'doggie'
                  category: {
                    id: 1
                    name: 'Dogs'
                  }
                  photoUrls: [
                    'string'
                  ]
                  tags: [
                    {
                      id: 0
                      name: 'string'
                    }
                  ]
                  status: 'available'
                }
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Pet'
          }
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<pet>\r\n  <id>10</id>\r\n  <name>doggie</name>\r\n  <category>\r\n    <id>1</id>\r\n    <name>Dogs</name>\r\n  </category>\r\n  <photoUrls>\r\n    <photoUrl>string</photoUrl>\r\n  </photoUrls>\r\n  <tags>\r\n    <tag>\r\n      <id>0</id>\r\n      <name>string</name>\r\n    </tag>\r\n  </tags>\r\n  <status>available</status>\r\n</pet>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Pet'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid ID supplied'
        representations: []
        headers: []
      }
      {
        statusCode: 404
        description: 'Pet not found'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getUserBy 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'getUserByName'
  properties: {
    displayName: 'Get user by user name.'
    method: 'GET'
    urlTemplate: '/user/{username}'
    templateParameters: [
      {
        name: 'username'
        description: 'The name that needs to be fetched. Use user1 for testing'
        type: 'string'
        required: true
        values: []
        schemaId: '681bc40410b10e0ce475cb2d'
        typeName: 'User-username-GetRequest'
      }
    ]
    description: 'Get user detail based on username.'
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {
                  id: 10
                  username: 'theUser'
                  firstName: 'John'
                  lastName: 'James'
                  email: 'john@email.com'
                  password: '12345'
                  phone: '12345'
                  userStatus: 1
                }
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'User'
          }
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<user>\r\n  <id>10</id>\r\n  <username>theUser</username>\r\n  <firstName>John</firstName>\r\n  <lastName>James</lastName>\r\n  <email>john@email.com</email>\r\n  <password>12345</password>\r\n  <phone>12345</phone>\r\n  <userStatus>1</userStatus>\r\n</user>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'User'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid username supplied'
        representations: []
        headers: []
      }
      {
        statusCode: 404
        description: 'User not found'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_loginUser 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'loginUser'
  properties: {
    displayName: 'Logs user into the system.'
    method: 'GET'
    urlTemplate: '/user/login'
    templateParameters: []
    description: 'Log into the system.'
    request: {
      queryParameters: [
        {
          name: 'username'
          description: 'The user name for login'
          type: 'string'
          values: []
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'UserLoginGetRequest'
        }
        {
          name: 'password'
          description: 'The password for login in clear text'
          type: 'string'
          values: []
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'UserLoginGetRequest-1'
        }
      ]
      headers: []
      representations: []
    }
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<UserLoginGet200ApplicationXmlResponse>string</UserLoginGet200ApplicationXmlResponse>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'UserLoginGet200ApplicationXmlResponse'
          }
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: 'string'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'UserLoginGet200ApplicationJsonResponse'
          }
        ]
        headers: [
          {
            name: 'X-Rate-Limit'
            description: 'calls per hour allowed by the user'
            type: 'integer'
            values: []
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'UserLoginGet200X-Rate-LimitResponseHeader'
          }
          {
            name: 'X-Expires-After'
            description: 'date in UTC when token expires'
            type: 'string'
            values: []
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'UserLoginGet200X-Expires-AfterResponseHeader'
          }
        ]
      }
      {
        statusCode: 400
        description: 'Invalid username/password supplied'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_logoutUser 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'logoutUser'
  properties: {
    displayName: 'Logs out current logged in user session.'
    method: 'GET'
    urlTemplate: '/user/logout'
    templateParameters: []
    description: 'Log user out of the system.'
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: []
        headers: []
      }
      {
        statusCode: 400
        description: 'Unexpected error'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_placeOrder 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'placeOrder'
  properties: {
    displayName: 'Place an order for a pet.'
    method: 'POST'
    urlTemplate: '/store/order'
    templateParameters: []
    description: 'Place a new order in the store.'
    request: {
      queryParameters: []
      headers: []
      representations: [
        {
          contentType: 'application/json'
          examples: {
            default: {
              value: {
                id: 10
                petId: 198772
                quantity: 7
                shipDate: 'string'
                status: 'approved'
                complete: true
              }
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Order'
        }
        {
          contentType: 'application/xml'
          examples: {
            default: {
              value: '<order>\r\n  <id>10</id>\r\n  <petId>198772</petId>\r\n  <quantity>7</quantity>\r\n  <shipDate>string</shipDate>\r\n  <status>approved</status>\r\n  <complete>true</complete>\r\n</order>'
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Order'
        }
        {
          contentType: 'application/x-www-form-urlencoded'
          formParameters: [
            {
              name: 'id'
              type: 'integer'
              values: []
            }
            {
              name: 'petId'
              type: 'integer'
              values: []
            }
            {
              name: 'quantity'
              type: 'integer'
              values: []
            }
            {
              name: 'shipDate'
              type: 'string'
              values: []
            }
            {
              name: 'status'
              type: 'string'
              values: [
                'placed'
                'approved'
                'delivered'
              ]
            }
            {
              name: 'complete'
              type: 'boolean'
              values: []
            }
          ]
        }
      ]
    }
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {
                  id: 10
                  petId: 198772
                  quantity: 7
                  shipDate: 'string'
                  status: 'approved'
                  complete: true
                }
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Order'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid input'
        representations: []
        headers: []
      }
      {
        statusCode: 422
        description: 'Validation exception'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updatePet 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'updatePet'
  properties: {
    displayName: 'Update an existing pet.'
    method: 'PUT'
    urlTemplate: '/pet'
    templateParameters: []
    description: 'Update an existing pet by Id.'
    request: {
      description: 'Update an existent pet in the store'
      queryParameters: []
      headers: []
      representations: [
        {
          contentType: 'application/json'
          examples: {
            default: {
              value: {
                id: 10
                name: 'doggie'
                category: {
                  id: 1
                  name: 'Dogs'
                }
                photoUrls: [
                  'string'
                ]
                tags: [
                  {
                    id: 0
                    name: 'string'
                  }
                ]
                status: 'available'
              }
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Pet'
        }
        {
          contentType: 'application/xml'
          examples: {
            default: {
              value: '<pet>\r\n  <id>10</id>\r\n  <name>doggie</name>\r\n  <category>\r\n    <id>1</id>\r\n    <name>Dogs</name>\r\n  </category>\r\n  <photoUrls>\r\n    <photoUrl>string</photoUrl>\r\n  </photoUrls>\r\n  <tags>\r\n    <tag>\r\n      <id>0</id>\r\n      <name>string</name>\r\n    </tag>\r\n  </tags>\r\n  <status>available</status>\r\n</pet>'
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Pet'
        }
        {
          contentType: 'application/x-www-form-urlencoded'
          formParameters: [
            {
              name: 'id'
              type: 'integer'
              values: []
            }
            {
              name: 'name'
              type: 'string'
              values: []
            }
            {
              name: 'category'
              type: 'object'
              values: []
              schemaId: 'Category'
            }
            {
              name: 'photoUrls'
              type: 'array'
              values: []
            }
            {
              name: 'tags'
              type: 'array'
              values: []
            }
            {
              name: 'status'
              type: 'string'
              values: [
                'available'
                'pending'
                'sold'
              ]
            }
          ]
        }
      ]
    }
    responses: [
      {
        statusCode: 200
        description: 'Successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {
                  id: 10
                  name: 'doggie'
                  category: {
                    id: 1
                    name: 'Dogs'
                  }
                  photoUrls: [
                    'string'
                  ]
                  tags: [
                    {
                      id: 0
                      name: 'string'
                    }
                  ]
                  status: 'available'
                }
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Pet'
          }
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<pet>\r\n  <id>10</id>\r\n  <name>doggie</name>\r\n  <category>\r\n    <id>1</id>\r\n    <name>Dogs</name>\r\n  </category>\r\n  <photoUrls>\r\n    <photoUrl>string</photoUrl>\r\n  </photoUrls>\r\n  <tags>\r\n    <tag>\r\n      <id>0</id>\r\n      <name>string</name>\r\n    </tag>\r\n  </tags>\r\n  <status>available</status>\r\n</pet>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Pet'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid ID supplied'
        representations: []
        headers: []
      }
      {
        statusCode: 404
        description: 'Pet not found'
        representations: []
        headers: []
      }
      {
        statusCode: 422
        description: 'Validation exception'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updatePetWithForm 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'updatePetWithForm'
  properties: {
    displayName: 'Updates a pet in the store with form data.'
    method: 'POST'
    urlTemplate: '/pet/{petId}'
    templateParameters: [
      {
        name: 'petId'
        description: 'Format - int64. ID of pet that needs to be updated'
        type: 'integer'
        required: true
        values: []
        schemaId: '681bc40410b10e0ce475cb2d'
        typeName: 'Pet-petId-PostRequest'
      }
    ]
    description: 'Updates a pet resource based on the form data.'
    request: {
      queryParameters: [
        {
          name: 'name'
          description: 'Name of pet that needs to be updated'
          type: 'string'
          values: []
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Pet-petId-PostRequest-1'
        }
        {
          name: 'status'
          description: 'Status of pet that needs to be updated'
          type: 'string'
          values: []
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Pet-petId-PostRequest-2'
        }
      ]
      headers: []
      representations: []
    }
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {
                  id: 10
                  name: 'doggie'
                  category: {
                    id: 1
                    name: 'Dogs'
                  }
                  photoUrls: [
                    'string'
                  ]
                  tags: [
                    {
                      id: 0
                      name: 'string'
                    }
                  ]
                  status: 'available'
                }
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Pet'
          }
          {
            contentType: 'application/xml'
            examples: {
              default: {
                value: '<pet>\r\n  <id>10</id>\r\n  <name>doggie</name>\r\n  <category>\r\n    <id>1</id>\r\n    <name>Dogs</name>\r\n  </category>\r\n  <photoUrls>\r\n    <photoUrl>string</photoUrl>\r\n  </photoUrls>\r\n  <tags>\r\n    <tag>\r\n      <id>0</id>\r\n      <name>string</name>\r\n    </tag>\r\n  </tags>\r\n  <status>available</status>\r\n</pet>'
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'Pet'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'Invalid input'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updateUser 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'updateUser'
  properties: {
    displayName: 'Update user resource.'
    method: 'PUT'
    urlTemplate: '/user/{username}'
    templateParameters: [
      {
        name: 'username'
        description: 'name that need to be deleted'
        type: 'string'
        required: true
        values: []
        schemaId: '681bc40410b10e0ce475cb2d'
        typeName: 'User-username-PutRequest'
      }
    ]
    description: 'This can only be done by the logged in user.'
    request: {
      description: 'Update an existent user in the store'
      queryParameters: []
      headers: []
      representations: [
        {
          contentType: 'application/json'
          examples: {
            default: {
              value: {
                id: 10
                username: 'theUser'
                firstName: 'John'
                lastName: 'James'
                email: 'john@email.com'
                password: '12345'
                phone: '12345'
                userStatus: 1
              }
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'User'
        }
        {
          contentType: 'application/xml'
          examples: {
            default: {
              value: '<user>\r\n  <id>10</id>\r\n  <username>theUser</username>\r\n  <firstName>John</firstName>\r\n  <lastName>James</lastName>\r\n  <email>john@email.com</email>\r\n  <password>12345</password>\r\n  <phone>12345</phone>\r\n  <userStatus>1</userStatus>\r\n</user>'
            }
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'User'
        }
        {
          contentType: 'application/x-www-form-urlencoded'
          formParameters: [
            {
              name: 'id'
              type: 'integer'
              values: []
            }
            {
              name: 'username'
              type: 'string'
              values: []
            }
            {
              name: 'firstName'
              type: 'string'
              values: []
            }
            {
              name: 'lastName'
              type: 'string'
              values: []
            }
            {
              name: 'email'
              type: 'string'
              values: []
            }
            {
              name: 'password'
              type: 'string'
              values: []
            }
            {
              name: 'phone'
              type: 'string'
              values: []
            }
            {
              name: 'userStatus'
              type: 'integer'
              values: []
            }
          ]
        }
      ]
    }
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: []
        headers: []
      }
      {
        statusCode: 400
        description: 'bad request'
        representations: []
        headers: []
      }
      {
        statusCode: 404
        description: 'user not found'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_uploadFile 'Microsoft.ApiManagement/service/apis/operations@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'uploadFile'
  properties: {
    displayName: 'Uploads an image.'
    method: 'POST'
    urlTemplate: '/pet/{petId}/uploadImage'
    templateParameters: [
      {
        name: 'petId'
        description: 'Format - int64. ID of pet to update'
        type: 'integer'
        required: true
        values: []
        schemaId: '681bc40410b10e0ce475cb2d'
        typeName: 'Pet-petId-UploadImagePostRequest'
      }
    ]
    description: 'Upload image of the pet.'
    request: {
      queryParameters: [
        {
          name: 'additionalMetadata'
          description: 'Additional Metadata'
          type: 'string'
          values: []
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Pet-petId-UploadImagePostRequest-1'
        }
      ]
      headers: []
      representations: [
        {
          contentType: 'application/octet-stream'
          examples: {
            default: {}
          }
          schemaId: '681bc40410b10e0ce475cb2d'
          typeName: 'Pet-petId-UploadImagePostRequest-2'
        }
      ]
    }
    responses: [
      {
        statusCode: 200
        description: 'successful operation'
        representations: [
          {
            contentType: 'application/json'
            examples: {
              default: {
                value: {
                  code: 0
                  type: 'string'
                  message: 'string'
                }
              }
            }
            schemaId: '681bc40410b10e0ce475cb2d'
            typeName: 'ApiResponse'
          }
        ]
        headers: []
      }
      {
        statusCode: 400
        description: 'No file uploaded'
        representations: []
        headers: []
      }
      {
        statusCode: 404
        description: 'Pet not found'
        representations: []
        headers: []
      }
      {
        statusCode: 500
        description: 'Unexpected error'
        representations: []
        headers: []
      }
    ]
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_681bc40410b10e0ce475cb2d 'Microsoft.ApiManagement/service/apis/schemas@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: '681bc40410b10e0ce475cb2d'
  properties: {
    contentType: 'application/vnd.oai.openapi.components+json'
    document: {}
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_pet 'Microsoft.ApiManagement/service/apis/tagDescriptions@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'pet'
  properties: {
    description: 'Everything about your Pets'
    externalDocsDescription: 'Find out more'
    externalDocsUrl: 'https://swagger.io/'
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_store 'Microsoft.ApiManagement/service/apis/tagDescriptions@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'store'
  properties: {
    description: 'Access to Petstore orders'
    externalDocsDescription: 'Find out more about our store'
    externalDocsUrl: 'https://swagger.io/'
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_user 'Microsoft.ApiManagement/service/apis/tagDescriptions@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'user'
  properties: {
    description: 'Operations about user'
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_default 'Microsoft.ApiManagement/service/apis/wikis@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
  name: 'default'
  properties: {
    documents: []
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource Microsoft_ApiManagement_service_diagnostics_service_apim_apimv2_afd_name_azuremonitor 'Microsoft.ApiManagement/service/diagnostics@2024-06-01-preview' = {
  name: '${service_apim_apimv2_afd_name}/azuremonitor'
  properties: {
    logClientIp: true
    loggerId: service_apim_apimv2_afd_name_azuremonitor.id
    sampling: {
      samplingType: 'fixed'
      percentage: json('100')
    }
    frontend: {
      request: {
        dataMasking: {
          queryParams: [
            {
              value: '*'
              mode: 'Hide'
            }
          ]
        }
      }
    }
    backend: {
      request: {
        dataMasking: {
          queryParams: [
            {
              value: '*'
              mode: 'Hide'
            }
          ]
        }
      }
    }
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_azuremonitor_azuremonitor 'Microsoft.ApiManagement/service/diagnostics/loggers@2018-01-01' = {
  parent: Microsoft_ApiManagement_service_diagnostics_service_apim_apimv2_afd_name_azuremonitor
  name: 'azuremonitor'
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_administrators_1 'Microsoft.ApiManagement/service/groups/users@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_administrators
  name: '1'
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_developers_1 'Microsoft.ApiManagement/service/groups/users@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_developers
  name: '1'
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_addPet_pet 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_addPet
  name: 'pet'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deletePet_pet 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deletePet
  name: 'pet'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_findPetsByStatus_pet 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_findPetsByStatus
  name: 'pet'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_findPetsByTags_pet 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_findPetsByTags
  name: 'pet'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getPetById_pet 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getPetById
  name: 'pet'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updatePet_pet 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updatePet
  name: 'pet'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updatePetWithForm_pet 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updatePetWithForm
  name: 'pet'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_uploadFile_pet 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_uploadFile
  name: 'pet'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deleteOrder_store 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deleteOrder
  name: 'store'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getInventory_store 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getInventory
  name: 'store'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getOrderById_store 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getOrderById
  name: 'store'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_placeOrder_store 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_placeOrder
  name: 'store'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_createUser_user 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_createUser
  name: 'user'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_createUsersWithListInput_user 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_createUsersWithListInput
  name: 'user'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deleteUser_user 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deleteUser
  name: 'user'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getUserByName_user 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getUserBy
  name: 'user'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_loginUser_user 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_loginUser
  name: 'user'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_logoutUser_user 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_logoutUser
  name: 'user'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updateUser_user 'Microsoft.ApiManagement/service/apis/operations/tags@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updateUser
  name: 'user'
  dependsOn: [
    service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_pet_681bc40410b10e0ce475cb30 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_pet
  name: '681bc40410b10e0ce475cb30'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updatePet.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_pet_681bc40410b10e0ce475cb31 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_pet
  name: '681bc40410b10e0ce475cb31'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_addPet.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_pet_681bc40410b10e0ce475cb32 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_pet
  name: '681bc40410b10e0ce475cb32'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_findPetsByStatus.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_pet_681bc40410b10e0ce475cb33 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_pet
  name: '681bc40410b10e0ce475cb33'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_findPetsByTags.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_pet_681bc40410b10e0ce475cb34 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_pet
  name: '681bc40410b10e0ce475cb34'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getPetById.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_pet_681bc40410b10e0ce475cb35 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_pet
  name: '681bc40410b10e0ce475cb35'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updatePetWithForm.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_pet_681bc40410b10e0ce475cb36 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_pet
  name: '681bc40410b10e0ce475cb36'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deletePet.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_pet_681bc40410b10e0ce475cb37 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_pet
  name: '681bc40410b10e0ce475cb37'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_uploadFile.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_store_681bc40410b10e0ce475cb38 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_store
  name: '681bc40410b10e0ce475cb38'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getInventory.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_store_681bc40410b10e0ce475cb39 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_store
  name: '681bc40410b10e0ce475cb39'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_placeOrder.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_store_681bc40410b10e0ce475cb3a 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_store
  name: '681bc40410b10e0ce475cb3a'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getOrderById.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_store_681bc40410b10e0ce475cb3b 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_store
  name: '681bc40410b10e0ce475cb3b'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deleteOrder.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_user_681bc40410b10e0ce475cb3c 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_user
  name: '681bc40410b10e0ce475cb3c'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_createUser.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_user_681bc40410b10e0ce475cb3d 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_user
  name: '681bc40410b10e0ce475cb3d'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_createUsersWithListInput.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_user_681bc40410b10e0ce475cb3e 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_user
  name: '681bc40410b10e0ce475cb3e'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_loginUser.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_user_681bc40410b10e0ce475cb3f 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_user
  name: '681bc40410b10e0ce475cb3f'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_logoutUser.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_user_681bc40410b10e0ce475cb40 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_user
  name: '681bc40410b10e0ce475cb40'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_getUserBy.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_user_681bc40410b10e0ce475cb41 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_user
  name: '681bc40410b10e0ce475cb41'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_updateUser.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}

resource service_apim_apimv2_afd_name_user_681bc40410b10e0ce475cb42 'Microsoft.ApiManagement/service/tags/operationLinks@2024-06-01-preview' = {
  parent: service_apim_apimv2_afd_name_user
  name: '681bc40410b10e0ce475cb42'
  properties: {
    operationId: service_apim_apimv2_afd_name_swagger_petstore_openapi_3_0_deleteUser.id
  }
  dependsOn: [
    service_apim_apimv2_afd_name_resource
  ]
}
