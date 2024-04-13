//
//  reportpageViewController.swift
//  dr_online
//
//  Created by JahnaviChava on 4/7/24.
//

import UIKit

class reportpageViewController: UIViewController {
    
    struct PatientData {
        var name: String
        var age: String
        var gender: String
        var symptoms: [String]
        var diagnosis: String
        var prescription: String
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var diagnosisTextField: UITextField!
    @IBOutlet weak var prescriptionTextField: UITextField!
    @IBOutlet weak var DownloadBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func DownLoadBTN(_ sender: UIButton) {
        
        
    }
    
    
    
    
    private func setupUI() {
        // Create and set up the scroll view
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
        
        //    func displayPatientDetails() {
        //            if let data = patientData {
        //
        //                Name: \(data.name)
        //                Age: \(data.age)
        //                Gender: \(data.gender)
        //                Symptoms: \(data.symptoms.joined(separator: ", "))
        //                Diagnosis: \(data.diagnosis)
        //                Prescription: \(data.prescription)
        //                """
        //            }
        //    }
        
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
}
