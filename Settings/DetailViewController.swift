import UIKit

class DetailViewController: UIViewController {

    var iconName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = " "
        
        if let iconName = iconName {
            let imageView = UIImageView()
            let configuration = UIImage.SymbolConfiguration(pointSize: 150)
            imageView.image = UIImage(systemName: iconName, withConfiguration: configuration)
            
            view.addSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
}
