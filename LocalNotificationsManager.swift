import Foundation
import UIKit

class LocalNotificationsManager {
    
    let CATEGORY = "some text"
    let NOTIFICATION_TEXT = "some text here"
    
    
    init() {
        
    }
    
    func RegisterNotificationsWithDevice() {
        
        let settings : UIUserNotificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        print ("Local Notifications -> Attempted to register local notifications")
        
    }
    
    var IsEnabled : Bool {
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        if settings == nil || settings!.types == UIUserNotificationType.None {
            print("Local Notifications -> None")
            return false
        } else if (settings!.types == [.Sound, .Alert, .Badge] ) {
            print("Local Notifications -> Sound, Alert, Badge")
        } else if (settings!.types == [.Sound, .Alert] ) {
            print("Local Notifications -> Sound, Alert")
        } else if (settings!.types == .Alert){
            print("Local Notifications -> Alert")
        } else if (settings!.types == .Badge){
            print("Local Notifications -> Badge")
        } else {
            print("Local Notifications -> ???")
        }
        
        return true
    }
    
    func ClearAllNotifications() {
        print("Local Notifications -> Clearing All")
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    
    func ScheduleNextNotification() {
        
        if (self.IsEnabled) {
            self.ClearAllNotifications()
        
            let calendar = NSCalendar.currentCalendar()
            let timeFromNow = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: 1, toDate: NSDate(), options: [])
            let notification = UILocalNotification()
            notification.fireDate = timeFromNow
            notification.repeatInterval = .Day
            notification.category = CATEGORY
            
            let randomChoice = Int(arc4random_uniform(2)) + 1
            
            let notificationText = NOTIFICATION_TEXT
            
            notification.alertBody =  self.Language.Localize(notificationText)
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            print("Local Notifications -> Scheduled \(timeFromNow)")
            
        }
        
        
        
    }
}
