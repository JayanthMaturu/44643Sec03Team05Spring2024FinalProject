import UIKit

var doctors: [Doctor] = []

class DoctorListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var selectedSymptoms: [String] = []
    var filteredDoctors: [Doctor] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.title = "Doctor List"
        self.tableView.register(UINib(nibName: "DoctorCell", bundle: nil), forCellReuseIdentifier: "DoctorCell")

        
        if doctors.isEmpty {
            DataManager().loadDoctors { result in
                doctors = result ?? []
                self.filterDoctorsAndReloadTable()
            }
        } else {
            self.filterDoctorsAndReloadTable()
        }
    }
    
    func filterDoctorsAndReloadTable() {
        
        
        for item in doctors {
            
            let diseases = item.Diseases ?? ""
            
            for xItem in selectedSymptoms {
                
                if(diseases.lowercased().contains(xItem.lowercased())){
                    filteredDoctors.append(item)
                    break
                }
                
                 
            }
            
        }
        
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDoctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "DoctorCell")
        let doctor = filteredDoctors[indexPath.row]
        cell.textLabel?.text = ( doctor.Doctors ?? "") + "\n\n"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}
