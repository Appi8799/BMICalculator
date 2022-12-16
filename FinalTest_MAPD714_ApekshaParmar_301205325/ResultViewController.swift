//
//  ResultViewController.swift
//  FinalTest_MAPD714_ApekshaParmar_301205325
//
//  Created by Apeksha Parmar on 2022-12-14.
//


import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var lblWE: UILabel!
    @IBOutlet weak var lblHE: UILabel!
    
    var lblWR: String?
    var lblHR: String?
    
    let a = Double()
    let b = Double()
    let c = Double()
    var multHE = Double()
    var divBMI = Double()
    
    
    
    var txtCategory: String?
    var txtBMIScore: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if lblWR != nil && lblHR != nil {
            lblWE.text = lblWR
            lblHE.text = lblHR
        }
        
        if lblCategory != nil && lblScore != nil {
            let a = Double(lblHE.text!)
            let b = Double(lblHE.text!)
            let c = Double(lblWE.text!)
            
            multHE = a! * b!
            divBMI = c! / multHE
            
            lblScore.text = String(divBMI)
            
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
        
    }
    @IBAction func btnDone(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "tableViewController") as! TableResultViewController
        vc.modalPresentationStyle = .fullScreen
    }
    
    @IBAction func btnHomeBack(_ sender: UIButton) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}
