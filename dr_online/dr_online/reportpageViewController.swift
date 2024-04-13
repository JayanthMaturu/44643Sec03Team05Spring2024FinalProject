//
//  reportpageViewController.swift
//  dr_online
//
//  Created by JahnaviChava on 4/7/24.
//

import UIKit
import PDFKit
import MyModule // Replace 'MyModule' with the correct module name



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
        
        createPDF()

    }
    var patientData: PatientData?
    
    
    @objc func downloadReport() {
        createPDF()
    }
    private func createPDF() {
        let pdf = PDFDocument()
        
        // Create a PDF page and add patient details
        let page = PDFPage()
        let pageInfo = [
            "Name": nameTextField.text ?? "",
            "Age": ageTextField.text ?? "",
            "Gender": genderTextField.text ?? "",
            "Diagnosis": diagnosisTextField.text ?? "",
            "Prescription": prescriptionTextField.text ?? ""
        ]
        //private func setupUI() {
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
            
            configureScrollViewContent()
                    
                    // Set up download button
            DownloadBTN.setTitle("Download Report", for: .normal)
            DownloadBTN.addTarget(self, action: #selector(ReportPage(_:)), for: .touchUpInside)
                }
            
        func createPDF() {
               let pdf = PDFDocument()
               
               // Create a PDF page and add patient details
               let page = PDFPage()
               let pageInfo = [
                   "Name": nameTextField.text ?? "",
                   "Age": ageTextField.text ?? "",
                   "Gender": genderTextField.text ?? "",
                   "Diagnosis": diagnosisTextField.text ?? "",
                   "Prescription": prescriptionTextField.text ?? ""
               ]
               var pageContent = ""
               for (key, value) in pageInfo {
                   pageContent += "\(key): \(value)\n"
               }
               page.addAnnotation(PDFAnnotation(bounds: CGRect(x: 20, y: 20, width: 200, height: 200), forType: .text, withProperties: [key: pageContent]))
               pdf.insert(page, at: pdf.pageCount)
               
               // Save or share the PDF document
               let pdfData = pdf.dataRepresentation()
               let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
               present(activityViewController, animated: true, completion: nil)
           }
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
        

