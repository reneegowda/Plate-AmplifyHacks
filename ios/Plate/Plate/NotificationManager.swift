import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    func requestPermissionAndSchedule(dinnerTime: String) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            guard granted else { return }
            self.scheduleDinnerNotification(dinnerTime: dinnerTime)
        }
    }

    func scheduleDinnerNotification(dinnerTime: String) {
        guard let components = parseTime(dinnerTime) else { return }

        let content = UNMutableNotificationContent()
        content.title = "your plate is ready 🍽️"
        content.body = "tap to see tonight's pick"
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "dinner-notification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dinner-notification"])
        UNUserNotificationCenter.current().add(request)
    }

    private func parseTime(_ timeString: String) -> DateComponents? {
        let formatter = DateFormatter()
        for format in ["h:mm a", "h a"] {
            formatter.dateFormat = format
            if let date = formatter.date(from: timeString) {
                let cal = Calendar.current
                return DateComponents(
                    hour: cal.component(.hour, from: date),
                    minute: cal.component(.minute, from: date)
                )
            }
        }
        return nil
    }
}
