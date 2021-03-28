//Name: Nikita Sushko
//ID: 105075196

import UIKit

import CoreData

class TablePageViewController: UIViewController, UITextFieldDelegate {
    private var taskList : [Order] = [Order]()
    var info = [""]
    var info2 = [""]
    private let dbHelper = DatabaseHelper.getInstance()

    @IBOutlet weak var infoTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        infoTable.delegate = self
        infoTable.dataSource = self
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Order")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                info2.append(data.value(forKey: "cType") as! String)
                info2.append(data.value(forKey: "cSize") as! String)
                info2.append(data.value(forKey: "cQuantity") as! String)
                info2.append("")
            }
        }catch {
                print("Failed");
            }
        
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
        return info2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = infoTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        //cell.textLabel?.text = info[indexPath.row]
        cell.textLabel?.text = info2[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (indexPath.row < self.info2.count){
            //ask for the confirmation first
            
            self.deleteTaskFromList(indexPath: indexPath)
        }
    }
    
    private func deleteTaskFromList(indexPath: IndexPath){
//        //remove task from the list
//        self.taskList.remove(at: indexPath.row)
//
//        //delete the table row
//        self.tableView.deleteRows(at: [indexPath], with: .automatic)
//        self.tableView.reloadData()
        self.fetchAllOrders()
        var r = indexPath.row
        r = r / 4
        self.dbHelper.deleteTask(taskID: self.taskList[r].id!)
        self.fetchAllOrders()
    }
    
    private func fetchAllOrders(){
        if (self.dbHelper.getAllOrders() != nil){
            self.taskList = self.dbHelper.getAllOrders()!
            //self.tableView.reloadData()
        }else{
            print(#function, "No data recieved from dbHelper")
        }
    }
}
