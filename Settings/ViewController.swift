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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let pair: (name: String, iconName: String)
           let iconColor: UIColor
           
           if indexPath.section == 0 {
               pair = firstSectionData[indexPath.row]
               iconColor = firstSectionIconColors[indexPath.row]
           } else if indexPath.section == 1 {
               pair = secondSectionData[indexPath.row]
               iconColor = secondSectionIconColors[indexPath.row]
           } else {
               let validIndex = min(indexPath.row, thirdSectionIconColors.count - 1)
               pair = thirdSectionData[validIndex]
               iconColor = thirdSectionIconColors[validIndex]
           }
           
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           cell.textLabel?.text = pair.name
           cell.imageView?.image = UIImage(systemName: pair.iconName)
           cell.imageView?.tintColor = iconColor
           
           if (pair.name == "Авиарежим" || pair.name == "VPN") {
               let switchControl = UISwitch()
               switchControl.tag = indexPath.row
               switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
               cell.accessoryView = switchControl
           } else {
               cell.accessoryType = .disclosureIndicator
           }
           
           return cell
       }
   }

   extension ViewController: UITableViewDelegate {
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if let cell = tableView.cellForRow(at: indexPath) {
               let pair: (name: String, iconName: String)
               if indexPath.section == 0 {
                   pair = firstSectionData[indexPath.row]
               } else if indexPath.section == 1 {
                   pair = secondSectionData[indexPath.row]
               } else {
                   pair = thirdSectionData[indexPath.row]
               }
               print("Нажато \(pair.name)")
               cell.setSelected(false, animated: true)
               
               if let detailViewController = getDetailViewController(for: pair) {
                   navigationController?.pushViewController(detailViewController, animated: true)
               }
           }
       }

       private func getDetailViewController(for pair: (name: String, iconName: String)) -> DetailViewController? {
           let detailViewController = DetailViewController()
           detailViewController.iconName = pair.iconName
           return detailViewController
       }

       @objc func switchValueChanged(_ sender: UISwitch) {
           let pair: (name: String, iconName: String)
           if sender.tag < firstSectionData.count {
               pair = firstSectionData[sender.tag]
           } else if sender.tag < firstSectionData.count + secondSectionData.count {
               pair = secondSectionData[sender.tag - firstSectionData.count]
           } else {
               pair = thirdSectionData[sender.tag - firstSectionData.count - secondSectionData.count]
           }
           print("Изменен переключатель для \(pair.name) на \(sender.isOn ? "включен" : "выключен")")
       }
   }
    
