//
//  GlobalFuncs.swift
//  iOSAppNext
//
//  Created by Jin Sun on 2019/12/23.
//  Copyright © 2019 -. All rights reserved.
//

import Foundation
import RxCocoa
import CoreLocation


/// 在主线程执行任务，如果当前在主线程，直接执行，如果不在，会在主队列异步执行
/// - Parameter action: 要执行的任务
func XMainThreadExecute(action:@escaping ()->Void) {
    if Thread.isMainThread {
        action()
    } else {
        DispatchQueue.main.async {
            action()
        }
    }
}

//MARK: - Utility

public let decimalFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = false
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 16
    return formatter
}()

/*
 + (NSString *)currentTimeStr{
     NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
     NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
     NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
     return timeString;
 }
 */

public func currentTimeStr() -> String {
    let date = Date.init(timeIntervalSinceNow: 0)//获取当前时间0秒后的时间
    let time = date.timeIntervalSince1970*1000// *1000 是精确到毫秒，不乘就是精确到秒
    let timeString = String(format: "%.0f", time)
    return timeString
}

public func keyWindow() -> UIWindow {
    var keyWindow = UIApplication.shared.keyWindow
    if keyWindow == nil {
        let windows = UIApplication.shared.windows.filter { (win) -> Bool in
            !win.isHidden && win.alpha > 0 && win.bounds != .zero 
        }
        keyWindow = windows.last
    }
    return keyWindow!
}

public func CRMainWindow() -> UIWindow {
    var mainWindow: UIWindow? = UIApplication.shared.delegate?.window ?? nil
    if mainWindow == nil {
        let arrWindow = UIApplication.shared.windows
        if arrWindow.count > 0 {
            mainWindow = arrWindow.first
        }
    }
    return mainWindow!
}

public func CRScreenBounds() -> CGRect {
    let landscape = UIDevice.current.orientation.isLandscape
    var rect = UIScreen.main.bounds
    if landscape && rect.width < rect.height {
        let height = rect.height
        rect.size.height = rect.width
        rect.size.width = height
    }
    return rect
}

@discardableResult
public func ensureExistsOfDirectory(dirPath: String) -> Bool {
    var isDir = ObjCBool(false)
    if !FileManager.default.fileExists(atPath: dirPath, isDirectory: &isDir) || !isDir.boolValue {
        do {
            try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("createDirectory error :\(error.localizedDescription)")
        }
    }
    return true
}



//MARK: - 输入值校验

public func CRIsNullOrEmpty(text: String?) -> Bool {
    if (text as Any) is NSNull {
        return true
    }
    if let string: String = text {
        guard !string.isEmpty && string != "(null)" && string != "<null>" else {
            return true
        }
    } else { return true }
    return false
}

public func CRMatches(pattern: String, text: String?) -> [NSTextCheckingResult]? {
    guard let string = text else { return nil }
    if string.count <= 0 {
        return nil
    }
    if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
        return regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
    }
    return nil
}

public func CRMatch(pattern: String, text: String?) -> NSTextCheckingResult? {
    return CRMatches(pattern: pattern, text: text)?.first
}

public func CRIsMatch(pattern: String, text: String?) -> Bool {
    if CRIsNullOrEmpty(text: text) {
        return false
    }
    if CRMatch(pattern: pattern, text: text) == nil {
        return false
    }
    return true
}

/// 判断纬度是否有效
/// - Parameter lat: 纬度
public func IsValidLatitude(_ lat: Double) -> Bool {
    return -90 <= lat && lat <= 90
}

/// 判断经度是否有效
/// - Parameter lon: 经度
public func IsValidLongitude(_ lon: Double) -> Bool {
    return -180 <= lon && lon <= 180
}

//MARK: - 距离计算

//public func distanceFromCurrent(to: (lat: Double, lon: Double)) -> String? {
//    guard let current = LocationService.shared.location else { return nil }
//    let meters = current.distance(from: CLLocation(latitude: to.lat, longitude: to.lon))
//    decimalFormatter.maximumFractionDigits = 2
//    let km = decimalFormatter.string(from: NSNumber(value: (meters / 1000.0)))
//    return km == nil ? nil : "\(km!)千米"
//}


//MARK: - 拨打电话

public func CRCallPhoneNumber(phone: String?) {
    if CRIsNullOrEmpty(text: phone) {
        return
    }
    
    if let url = URL(string: "tel:\(phone!)") {
        UIApplication.shared.open(url, options: [:]) { (success) in
            // success=选择 呼叫 为 1  选择 取消 为0
            print("Open Phone Success \(success)")
        }
    }
}




//MARK: - Type Casting
// workaround for Swift compiler bug, cheers compiler team :)
func castOptionalOrFatalError<T>(_ value: Any?) -> T? {
    if value == nil {
        return nil
    }
    let v: T = castOrFatalError(value)
    return v
}

func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw myCastingError(object, targetType: resultType)
    }

    return returnValue
}

func castOptionalOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T? {
    if NSNull().isEqual(object) {
        return nil
    }

    guard let returnValue = object as? T else {
        throw myCastingError(object, targetType: resultType)
    }

    return returnValue
}

func castOrFatalError<T>(_ value: Any!, message: String) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        myFatalError(message)
    }
    
    return result
}

func castOrFatalError<T>(_ value: Any!) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        myFatalError("Failure converting from \(String(describing: value)) to \(T.self)")
    }
    
    return result
}

func myCastingError<T>(_ object: Any, targetType: T.Type) -> Error {
    RxCocoaError.castingError(object: object, targetType: targetType)
}

func myFatalError(_ lastMessage: String) -> Never  {
    // The temptation to comment this line is great, but please don't, it's for your own good. The choice is yours.
    fatalError(lastMessage)
}
