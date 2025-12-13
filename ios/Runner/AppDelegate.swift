import UIKit
import Flutter
import Vision

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let imageChannel = FlutterMethodChannel(name: "com.example.outfit_app/image_processing",
                                              binaryMessenger: controller.binaryMessenger)
    
    imageChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "segmentGarment" {
        guard let args = call.arguments as? [String: Any],
              let imagePath = args["imagePath"] as? String else {
          result(FlutterError(code: "INVALID_ARGUMENTS", message: "imagePath is required", details: nil))
          return
        }
        self.segmentGarment(imagePath: imagePath, result: result)
      } else if call.method == "composeOutfit" {
        guard let args = call.arguments as? [String: Any],
              let selfiePath = args["selfiePath"] as? String,
              let garmentPaths = args["garmentPaths"] as? [String] else {
          result(FlutterError(code: "INVALID_ARGUMENTS", message: "selfiePath and garmentPaths are required", details: nil))
          return
        }
        self.composeOutfit(selfiePath: selfiePath, garmentPaths: garmentPaths, result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func segmentGarment(imagePath: String, result: @escaping FlutterResult) {
    // TODO: Implement Vision/CoreML segmentation
    // For now, just return the original path as a mock mask
    print("Native: Segmenting \(imagePath)")
    
    // Simulate async work
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
      result(imagePath)
    }
  }

  private func composeOutfit(selfiePath: String, garmentPaths: [String], result: @escaping FlutterResult) {
    // TODO: Implement Metal/CoreImage composition
    print("Native: Compositing \(selfiePath) with \(garmentPaths.count) garments")
    
    // Simulate async work
    DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
      result(selfiePath)
    }
  }
}
