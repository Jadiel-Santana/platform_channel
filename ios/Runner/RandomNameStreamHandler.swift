import Foundation
import Flutter

class RandomNameStreamHandler: NSObject, FlutterStreamHandler{
    var sink: FlutterEventSink?
    var timer: Timer?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(sendNewRandomNumber), userInfo: nil, repeats: true)
        return nil
    }
    
    @objc func sendNewRandomNumber() {
        guard let sink = sink else { return }
        
        var namesList = ["Bife", "Eduardo", "Gabriel", "Gus", "Italo", "Jadiel"]
        let randomNumber = Int.random(in: 0..<6)
        sink(namesList[randomNumber])
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        timer?.invalidate()
        return nil
    }
}
