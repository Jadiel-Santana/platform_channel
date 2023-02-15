import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
override func application(
 _ application: UIApplication,
 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
 
 let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
 let channel = FlutterMethodChannel(name: "br.com.platform.channel/palindrome",
                                           binaryMessenger: controller.binaryMessenger)
 channel.setMethodCallHandler({
    [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
    switch (call.method) {
      case "isPalindrome":
        guard let args = call.arguments as? Dictionary<String, String> else {return}
        result(self?.isPalindrome(word: args["word"]!))
      break
      default: result(FlutterMethodNotImplemented)
    }
 })
    
    

 let randomNameChannel = FlutterEventChannel(name: "br.com.platform.channel/randomName", binaryMessenger: controller.binaryMessenger)
 let randomNameStreamHandler = RandomNameStreamHandler()
 randomNameChannel.setStreamHandler(randomNameStreamHandler)
 
 GeneratedPluginRegistrant.register(with: self)
 return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
    
    
func isPalindrome(word: String) -> String {
    if(String(word.lowercased()) == String(word.lowercased().reversed())) {
        return "\(word) é um palíndromo"
    } else {
        return "\(word) NÃO é um palíndromo"
    }
 }
    
}
