//
//  ViewController.swift
//  BMICalculator--IOS
//
//  Created by Tardes on 6/6/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
       @IBOutlet weak var statusLabel: UILabel!
    
    var weight: Float = 0
    var height: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func onWeightChanged(_ sender: UIStepper) {
        weight = Float(sender.value)
        weightLabel.text = "\(Int(weight)) kg"
    }
    @IBAction func onHeightChanged(_ sender: UISlider) {
        height = sender.value
        heightLabel.text = "\(Int(height)) cm"
    }
    
    @IBAction func calculateButton(_ sender: Any) {
        let heightInMeter: Float = height / Float(100)
        let bmi: Float = weight / pow(heightInMeter, 2)
        resultLabel.text = "\(String(format: "%.2f", bmi))"
        
        // Determinar el estado según el IMC
        if bmi < 18.5 {
            statusLabel.text = "Delgado"
            statusLabel.textColor = UIColor.blue
        } else if bmi >= 18.5 && bmi < 25 {
            statusLabel.text = "Normal"
            statusLabel.textColor = UIColor.green
        } else {
            statusLabel.text = "Obeso"
            statusLabel.textColor = UIColor.red
        }
            
        
    }
   
      
}

