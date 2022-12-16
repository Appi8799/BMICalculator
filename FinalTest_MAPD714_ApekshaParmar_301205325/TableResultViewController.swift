//
//  TableResultViewController.swift
//  FinalTest_MAPD714_ApekshaParmar_301205325
//
//  Student Name: Apeksha Parmar
//  Student ID: 301205325
//
//  Created by Apeksha Parmar on 2022-12-14.
//

import UIKit
import CoreData

class TableResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var DBManager = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.delegate = self
        table.separatorInset = table.layoutMargins
        
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DBManager.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = Date()
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let thisData: Data!
        
        thisData = DBManager[indexPath.row]
        cell.lblUserName.text = thisData.name
        cell.lblAge.text = (thisData.age ?? "No Age") + "year"
        cell.lblDate.text = thisData.addedDate
        cell.lblBMIScore.text = "BMI Score: " + thisData.score! + " kg/m²"
        cell.lblWE.text = "Weight: " + (thisData.weight!)
        cell.lblHE.text = "Height: " + (thisData.height!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            
            self.context.delete(self.DBManager[indexPath.row])
            self.table.reloadData()
            self.DBManager.remove(at: indexPath.row)
            
            do{
                try self.context.save()
            }catch _ {}
            
            self.table.deleteRows(at: [indexPath], with: .fade)
            self.table.reloadData()
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete])
        return swipeConfiguration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //passing the data to another view controller using identifier
        if(segue.identifier == "editViewController") {
            let index = table.indexPathForSelectedRow!
            let navigate = segue.destination as? EditViewController
            let selectedData: Data!
            selectedData = DBManager[index.row]
            navigate?.DBManager = selectedData
            table.deselectRow(at: index, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData() {
        do {
            self.DBManager = try context.fetch(Data.fetchRequest())
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }catch{}
    }
    
}
