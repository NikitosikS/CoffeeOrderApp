//Name: Nikita Sushko
//ID: 105075196

import UIKit

class TablePageViewController: UIViewController {
    //private var info : [Order] = [Order]()
    var info = [""]
    @IBOutlet weak var infoTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoTable.delegate = self
        infoTable.dataSource = self
    }
}

extension TablePageViewController: UITableViewDelegate{
    //TODO
}

extension TablePageViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = infoTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        //cell.textLabel?.text = info[indexPath.row]
        cell.textLabel?.text = info[indexPath.row]
        return cell
    }
    
    
}
