//
//  reportpageViewController.swift
//  dr_online
//
//  Created by JahnaviChava on 4/7/24.
//

import UIKit

class reportpageViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var diagnosisTextField: UITextField!
    @IBOutlet weak var prescriptionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func configureScrollViewContent() {
            let labels = ["Name", "Age", "Gender", "Diagnosis", "Prescription"]
            var currentYPosition: CGFloat = 20
            
            for labelText in labels {
                let label = UILabel(frame: CGRect(x: 20, y: currentYPosition, width: scrollView.bounds.width - 40, height: 30))
                label.text = labelText
                scrollView.addSubview(label)
                
                currentYPosition += 40
                
                let textField = UITextField(frame: CGRect(x: 20, y: currentYPosition, width: scrollView.bounds.width - 40, height: 30))
                textField.borderStyle = .roundedRect
                scrollView.addSubview(textField)
                textField.tag = labels.firstIndex(of: labelText)! + 1
                
                currentYPosition += 50
            }
                scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: currentYPosition + 20)
        }
}
