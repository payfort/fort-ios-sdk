Pod::Spec.new do |s|
    s.name              = 'PayFortSDK'
    s.version           = '3.2.0'
    s.summary           = 'The Amazon Payment Services IOS SDK allows Merchants to securely integrate the payment functions and easily accept In-App payments.Instead of the traditional, time-consuming, and complex way of being redirected to the mobile browser to complete the payment, In-App payments can be completed through our APS Mobile SDK. In turn, this gives the Merchant’s consumers a smooth, pleasing user-experience by using In-App payment functions through the native applications.'
    s.homepage          = 'https://github.com/payfort/fort-ios-sdk'

    s.author            = { 'Amazon Payment Service' => 'merchantsupport-ps@amazon.com' }
    s.license           = { :type => 'MIT', :file => 'LICENSE.md' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/payfort/fort-ios-sdk.git', :tag => s.version}

    s.ios.deployment_target = '11.0'
    s.ios.vendored_frameworks = 'PayFortSDK.xcframework'
    s.requires_arc = true
    s.swift_version = '5.0'
end
