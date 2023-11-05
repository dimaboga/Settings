import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var firstSectionData: [(name: String, iconName: String)] = [
           ("Авиарежим", "airplane"),
           ("Wi-FI", "wifi"),
           ("Bluetooth", "wave.3.forward.circle"),
           ("Сотовая связь", "antenna.radiowaves.left.and.right"),
           ("Режим модема", "personalhotspot"),
           ("VPN", "network.badge.shield.half.filled"),
       ]

       private var secondSectionData: [(name: String, iconName: String)] = [
           ("Уведомления", "app.badge"),
           ("Звуки", "speaker.wave.3"),
           ("Не беспокоить", "moon.fill"),
           ("Экранное время", "hourglass.circle"),
       ]

       private var thirdSectionData: [(name: String, iconName: String)] = [
           ("Основные", "gear"),
           ("Пункт управления", "switch.2"),
           ("Экран и яркость", "sun.max.fill"),
           ("Экран домой", "house.fill"),
           ("Универсальный доступ", "figure.walk"),
           ("Обои", "paintpalette.fill"),
           ("Siri и поиск", "mic.fill"),
           ("Face ID", "faceid"),
           ("Экстренный вызов", "phone.circle.fill"),
           ("Аккумулятор", "battery.75percent"),
           ("Конфиденциальность", "lock.fill")
       ]

       private var firstSectionIconColors: [UIColor] = [.systemOrange, .systemGreen, .blue, .systemGreen, .systemBlue, .blue]
       private var secondSectionIconColors: [UIColor] = [.systemRed, .systemPink, .systemPurple, .purple]
       private var thirdSectionIconColors: [UIColor] = [.systemBlue, .systemGreen, .systemYellow, .systemIndigo, .systemTeal, .systemPink, .systemRed, .systemOrange, .systemPurple, .systemBlue, .systemBlue]

       private lazy var tableView: UITableView = {
           let tableView = UITableView(frame: .zero, style: .insetGrouped)
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
           tableView.dataSource = self
           tableView.delegate = self
           return tableView
       }()

    override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemGray6
            title = "Настройки"
            navigationController?.navigationBar.prefersLargeTitles = true
            setupHierarchy()
            setupLayout()
        }

        private func setupHierarchy() {
            view.addSubview(tableView)
        }

        private func setupLayout() {
            tableView.snp.makeConstraints { make in
                make.top.right.bottom.left.equalTo(view)
            }
        }
    }

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return firstSectionData.count
        } else if section == 1 {
            return secondSectionData.count
        } else {
            return thirdSectionData.count
        }
    }
    
    
