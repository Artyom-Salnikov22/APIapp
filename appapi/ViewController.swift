//
//  ViewController.swift
//  appapi
//
//  Created by Артём Сальников on 05.10.2024.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    var locationURL: String?

        var character: Characters? // Добавляем свойство для хранения персонажа
        var location: Location? // Добавляем свойство для хранения локации
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Убедитесь, что character и location не nil
            if let character = character {
                setData1(character: character)
            }
            
            if let location = location {
                setData2(location: location)
            }
            
            loadLocationData()
        }

    func loadLocationData() {
            guard let url = locationURL else { return }

            AF.request(url).responseJSON { response in
                if response.response?.statusCode == 200 {
                    if let value = response.value {
                        let json = JSON(value)
                        print(json)
                        self.typeLabel.text = "Type: \(json["type"].stringValue)"
                        self.sizeLabel.text = "Size is: \(json["dimension"].stringValue)"
                    }
                }
            }
     }
    
    func setData1(character: Characters) {
        nameLabel.text = character.name
        infoLabel.text = "\(character.status) - \(character.species)"
        genderLabel.text = "Gender: \(character.gender)"
        
        pictureImageView.sd_setImage(with: URL(string: character.image), completed: nil)
    }
    
    func setData2(location: Location) {
        liveLabel.text = "Live in: \(location.name)"
    }
    
    private func showErrorAlert(_ message: String) {
            let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ОК", style: .default))
            present(alert, animated: true)
        }

}
