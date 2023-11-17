//
//  GCDTimerManager.swift
//  voice
//
//  Created by Mac on 2023/3/28.
//

import Foundation

/* 使用示例
 GCDTimerManager.shared.scheduleDispatchTimer(timerName: kRoundTimerName, timeInterval: 1, repeats: true) {[weak self] in
     self?.updateView()
 }
 
 // 销毁
 deinit{
     GCDTimerManager.shared.invalidateTimer(timerName: kRoundTimerName)
 }
 */

/// GCD 定时器
@objcMembers class GCDTimerManager: NSObject {

    static let shared = GCDTimerManager()

    private var timerMap = [String: DispatchSourceTimer]()
    
    private override init() {}

    public func invalidateAllTimer() {
        for (_, value) in self.timerMap {
            value.cancel()
        }
        self.timerMap.removeAll()
    }

    public func invalidateTimer(timerName: String) {
        if let timer = timerMap[timerName] {
            timer.cancel()
            timerMap.removeValue(forKey: timerName)
        }
    }
    
    public func hasTimer(timerName: String) -> Bool {
        if let _ = timerMap[timerName]  {
            return true
        }
        return false
    }

    public func scheduleDispatchTimer(timerName: String, timeInterval: Double, repeats: Bool, action:@escaping() -> Void) {
        invalidateTimer(timerName: timerName)
        
        let dispatchQueue = DispatchQueue.global(qos: .default)
        let currentTimer =  DispatchSource.makeTimerSource(flags: [], queue: dispatchQueue)
        timerMap[timerName] = currentTimer
        
        if repeats {
            currentTimer.schedule(deadline: .now(), repeating:  timeInterval , leeway: DispatchTimeInterval.seconds(0))
        } else {
            currentTimer.schedule(deadline: .now() + .seconds(Int(timeInterval)), repeating:  .never , leeway: DispatchTimeInterval.seconds(0))
        }
        currentTimer.setEventHandler { [weak self] in
            DispatchQueue.main.async{
                action()
            }
            if !repeats {
                self?.invalidateTimer(timerName: timerName)
            }
        }
        currentTimer.resume()
    }
}
