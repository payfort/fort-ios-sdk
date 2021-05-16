Pod::Spec.new do |s|
    s.name              = 'PayFortSDK'
    s.version           = '3.0'
    s.summary           = 'The FORT Mobile SDK allows Merchants to securely integrate the payment functions. It also allows Merchants to easily accept In-App payments. Instead of the traditional, time-consuming, and complex way of being redirected to the mobile browser to complete the payment, In-App payments can be completed through our FORT Mobile SDK. In turn, this gives the Merchant’s consumers a smooth, pleasing user-experience by using In-App payment functions through the native applications.'
    s.homepage          = 'https://paymentservices.amazon.com/'

    s.author            = { 'Amazon Payment Service' => 'merchantsupport-ps@amazon.com' }
    s.license           = { :type => 'MIT', :file => 'LICENSE.md' }

    s.platform          = :ios
   s.source            = { :git => 'https://github.com/payfort/fort-ios-sdk',:tag => s.version}

    s.ios.deployment_target = '11.2'
    s.ios.vendored_frameworks = 'PayFortSDK.xcframework'
    s.requires_arc = true
    s.swift_version = '5.0'
end
