//
//  ViewController.swift
//  FinalTest_MAPD714_ApekshaParmar_301205325
//
//  Student Name: Apeksha Parmar
//  Student ID: 301205325
//
//  Created by Apeksha Parmar on 2022-12-14.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtW: UITextField!
    @IBOutlet weak var txtH: UITextField!
    @IBOutlet weak var txtWString: UILabel!
    @IBOutlet weak var txtHString: UILabel!
    
    @IBOutlet weak var lblBMIScore: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!

    var a = Double()
    let b = Double()
    var c = Double()
    
    var multHE = Double()
    var divBMI = Double()
    
    var txtCategory: String?
    var txtBMIScore: String?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var segment = "Metrics"

    override func viewDidLoad() {
        
        txtW.delegate = self
        txtH.delegate = self
        txtAge.delegate = self
        
        super.viewDidLoad()
        
    }

    
    //Save data function to save the data
    func saveData() {
        do {
            try self.context.save()
            _ = try self.context.fetch(Data.fetchRequest())
        }catch {
            print("Error")
        }
    }
    
    //Action button for calculate the BMI score and go to next page for details.
    @IBAction func btnCalculate(_ sender: UIButton) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/d/yyyy, h:mm a"
        
        let data = Data(context: self.context)
        data.id = Int32(truncating: 0 as NSNumber)
        data.name = self.txtName.text
        data.height = self.txtH.text! + "\(self.txtHString.text ?? "meter")"
        data.weight = self.txtW.text! + "\(self.txtWString.text ?? "KG")"
        data.age = self.txtAge.text
        data.score = self.lblBMIScore.text
        data.addedDate = formatter.string(from: self.datePicker.date)
        data.date = self.datePicker.date
        
        if lblCategory != nil && lblBMIScore != nil {
            let a = Double(txtH.text!)
            let b = Double(txtW.text!)
            
            if segment == "Metric" {
                multHE = a! * a!
                divBMI = b! / multHE
                
                lblBMIScore.text = String(divBMI)
                data.score = self.lblBMIScore.text
            }else {
                multHE = a! * a!
                c = b! * 703
                divBMI = c / multHE
                
                lblBMIScore.text = String(divBMI)
                data.score = self.lblBMIScore.text
                
            }
            
            
            if(divBMI < 16){
                lblCategory.text = "Severe Thinness"
            }else if 16 ... 17 ~= divBMI{
                lblCategory.text = "Moderate Thinness"
            }else if 17 ... 18.5 ~= divBMI{
                lblCategory.text = "Mild Thinness"
            }else if 18.5 ... 25 ~= divBMI{
                lblCategory.text = "Normal"
            }else if 25 ... 30 ~= divBMI{
                lblCategory.text = "Overweight"
            }else if 30 ... 35 ~= divBMI{
                lblCategory.text = "Obese Class I"
            }else if 35 ... 40 ~= divBMI{
                lblCategory.text = "Obese Class II"
            }else if(divBMI > 40){
                lblCategory.text = "Obese Class III"
                lblCategory.backgroundColor = UIColor.red
            }
        }
        
        
        self.saveData()
        
        
        
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "resultViewController") as! ResultViewController
//        vc.lblWR = txtW.text
//        vc.lblHR = txtH.text
        //vc.modalPresentationStyle = .fullScreen
        //self.present(vc, animated: true)
    }
    
    //For only accepting numbers in Age, Height and Weight textfield.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
    @IBAction func WHUnitSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            segment = "Metric"
            txtWString.text = " / KG"
            txtHString.text = " / meter"
        }
        else {
            segment = "Imperial"
            txtWString.text = " / pounds"
            txtHString.text = " / inches"
        }
        
    }
    
    
}

