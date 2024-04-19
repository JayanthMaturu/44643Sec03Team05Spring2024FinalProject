import UIKit
import Firebase
import PDFKit

class ProfileVC: UIViewController {

    // Outlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var age: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInfo()
        getUserData()
    }

    func getUserData() {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(DefaultHelper.shared.getUID())
        
        userRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                let userData = document.data()
                
                if let name = userData?["name"] as? String {
                    print("User's name:", name)
                    DispatchQueue.main.async {
                        self.name.text = "Name: " + name.capitalized
                    }
                }
                
                if let age = userData?["age"] as? Int {
                    print("User's age:", age)
                    DispatchQueue.main.async {
                        self.age.text = "Age: \(age)"
                    }
                }
                
                if let mobile = userData?["phoneNumber"] as? String {
                    print("User's phone number:", mobile)
                    DispatchQueue.main.async {
                        self.mobile.text = "Mobile: \(mobile)"
                    }
                }
                
                if let mobile = userData?["phoneNumber"] as? Int {
                    print("User's phone number:", mobile)
                    DispatchQueue.main.async {
                        self.mobile.text = "Mobile: \(mobile)"
                    }
                }
            } else {
                print("User document does not exist")
            }
        }
    }

    private func setupUserInfo() {
        name.text = "Name: " + DefaultHelper.shared.getName().capitalized
        email.text = "Email: " + DefaultHelper.shared.getEmail().capitalized
        mobile.text = "Mobile: " + (DefaultHelper.shared.getMobile() ?? "")
    }

    @IBAction func onDownload(_ sender: Any) {
        generateAndSavePDF()
    }

    func generateAndSavePDF() {
        let pdfData = createFlyer()
        let pdfURL = FileManager.default.temporaryDirectory.appendingPathComponent("profile.pdf")

        do {
            try pdfData.write(to: pdfURL)
            sharePDF(at: pdfURL)
        } catch {
            print("Error saving PDF: \(error.localizedDescription)")
        }
    }

    func sharePDF(at url: URL) {
        let documentInteractionController = UIDocumentInteractionController(url: url)
        documentInteractionController.delegate = self
        documentInteractionController.presentPreview(animated: true)
    }
}

extension ProfileVC: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

extension ProfileVC {
    func createFlyer() -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "Parient Report",
            kCGPDFContextAuthor: name.text!
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        let data = renderer.pdfData { (context) in
            context.beginPage()
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 20)
            ]
            let text = """
                \(name.text ?? "")
                \(email.text ?? "")
                \(mobile.text ?? "")
                \(age.text ?? "")
                """
            text.draw(at: CGPoint(x: 20, y: 20), withAttributes: attributes)
        }

        return data
    }
}
