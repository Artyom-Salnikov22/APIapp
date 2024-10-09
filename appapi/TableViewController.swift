//
//  TableViewController.swift
//  appapi
//
//  Created by Артём Сальников on 05.10.2024.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON


class TableViewController: UITableViewController {

    var arrayChar: [Characters] = []
    var location: [Location] = []
    
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        tableView.addSubview(refreshControl!)
    }
    
    @objc func handleRefresh() {
        if !isLoading {
            isLoading = true
            arrayChar.removeAll()
            location.removeAll()
            tableView.reloadData()
            loadData()
        }
    }
    
    
    func loadData() {
        SVProgressHUD.show()
        
        AF.request("https://rickandmortyapi.com/api/character", method: .get).responseJSON { response in
            
            SVProgressHUD.dismiss()
            self.isLoading = false
            self.refreshControl?.endRefreshing()

            if response.response?.statusCode == 200 {
                // Убедитесь, что response.value можно преобразовать в JSON
                if let value = response.value {
                    let json = JSON(value)
                    print(json)
                    
                    // Объявляем resultArray перед условием
                    if let resultArray = json["results"].array {
                        for item in resultArray {
                            let character = Characters(json: item)
                            self.arrayChar.append(character)
                            
                            // Извлекаем локацию для каждого персонажа
                            if let locationJSON = item["location"].dictionary {
                                let location = Location(json: JSON(locationJSON))
                                self.location.append(location)
                            }
                        }
                        self.tableView.reloadData()
                    }
                }
            } else {
                // Обработка ошибки, если код состояния не 200
                print("Error: \(response.error?.localizedDescription ?? "Unknown error")")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayChar.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        cell.setData1(character: arrayChar[indexPath.row])
        cell.setData2(location: location[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 177.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let detailVc = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! ViewController
            
            let selectedCharacter = arrayChar[indexPath.row]
            let selectedLocation = location[indexPath.row]
            
            detailVc.character = selectedCharacter // Передаем персонажа
            detailVc.location = selectedLocation // Передаем локацию
            detailVc.locationURL = selectedLocation.url // URL для загрузки локации
            
            navigationController?.pushViewController(detailVc, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
