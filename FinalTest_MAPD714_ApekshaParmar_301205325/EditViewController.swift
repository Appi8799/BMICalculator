//
//  EditViewController.swift
//  FinalTest_MAPD714_ApekshaParmar_301205325
//
//  Student Name: Apeksha Parmar
//  Student ID: 301205325
//
//  Created by Apeksha Parmar on 2022-12-16.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var editAge: UITextField!
    @IBOutlet weak var editDate: UIDatePicker!
    @IBOutlet weak var editW: UITextField!
    @IBOutlet weak var editH: UITextField!
    
    @IBOutlet weak var editScore: UILabel!
    
    @IBOutlet weak var lblWString: UILabel!
    @IBOutlet weak var lblHString: UILabel!
    
    var a = Double()
    let b = Double()
    var c = Double()
    
    var multHE = Double()
    var divBMI = Double()
    
    var txtCategory: String?
    var txtBMIScore: String?
    
    var DBManager : Data!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var segment = "Metrics"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editAge.text = DBManager.age
        editDate.date = DBManager.date ?? Date.now
        editW.text = DBManager.weight
        editH.text = DBManager.height
        
    }
    
    //Update button to update weight and height value
    @IBAction func btnUpdate(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Confirmation!", message: "Do you want to update your data?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in}))
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { [self] action in
            
            if self.txtBMIScore != nil {
                let a = Double(editH.text!)
                let b = Double(editW.text!)
                
                if segment == "Metric" {
                    multHE = a! * a!
                    divBMI = b! / multHE
                    
                    editScore.text = String(divBMI)
                }else {
                    multHE = a! * a!
                    c = b! * 703
                    divBMI = c / multHE
                    
                    editScore.text = String(divBMI)
                }
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/d/yyyy, h:mm a"
            
            self.DBManager.age = self.editAge.text
            self.DBManager.weight = self.editW.text
            self.DBManager.height = self.editH.text
            self.DBManager.score = self.editScore.text
            self.DBManager.addedDate = formatter.string(from: self.editDate.date)
            self.DBManager.date = self.editDate.date
            
            self.updateData()
            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "tableViewController") as! TableResultViewController
//
//            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        
        present(alert, animated: true)
    }
    
    //Update function to update data
    func updateData(){
        do{
            try self.context.save()
            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "tableViewController") as! TableResultViewController
//
//            self.navigationController?.pushViewController(vc, animated: true)
            
            _ = self.navigationController?.popToRootViewController(animated: true)
            
        }catch{}
    }
    
    
    
    //Delete button to delete recorded data
    @IBAction func btnDelete(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Confirmation!", message: "Do you want to Delete the data ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in}))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
            self.deleteData()
        }))
        present(alert, animated: true)
        
    }
    
    //Delete function to delete data
    func deleteData(){
        self.context.delete(DBManager)
        do{
            try self.context.save()
            _ = navigationController?.popToRootViewController(animated: true)
            
        }catch{
            print("Error")
        }
    }
    
    
    //Cancel button to cancel all the changes made in data
    @IBAction func btnCancel(_ sender: UIButton) {
        cancelAction()
    }
    
    //Cancel action function to cancel all changes
    func cancelAction(){
        let alert = UIAlertController(title: "Confirmation!", message: "Do you want to Discard All Changes ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {action in}))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {action in
            _ = self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    @IBAction func editWHSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            segment = "Metric"
            lblWString.text = " / KG"
            lblHString.text = " / meter"
        }
        else {
            segment = "Imperial"
            lblWString.text = " / pounds"
            lblHString.text = " / inches"
        }
    }

}
