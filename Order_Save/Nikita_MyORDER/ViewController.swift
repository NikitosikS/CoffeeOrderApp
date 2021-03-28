//Name: Nikita Sushko
//ID: 105075196

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBAction func click(_ sender: Any) {
        info.append(coffeeType.text!)
        info.append(coffeeSize.text!)
        info.append(quantity.text!)
    }
    var info = [""]

    @IBOutlet weak var coffeeType: UITextField!
    
    @IBOutlet weak var coffeeSize: UITextField!
    

    @IBOutlet weak var quantity: UITextField!
    
    @IBOutlet weak var test: UITextField!
    let types = ["Dark Roast", "Original Blend", "Vanilla", "Iced Coffee"]
    
    let sizes = ["Small", "Medium", "Large"]
    
    var pickerView = UIPickerView()
    var pickerView1 = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Proceed", style: .plain, target: self, action: #selector(nextScreen))
        
        navigationItem.title = "Order Page"
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        coffeeType.inputView = pickerView
        coffeeType.textAlignment = .center
        coffeeType.placeholder = "Select Coffee Type"
        coffeeSize.inputView = pickerView1
        coffeeSize.textAlignment = .center
        coffeeSize.placeholder = "Select Coffee Size"
        
        quantity.textAlignment = .center
        quantity.placeholder = "Enter Quantity"
        
        pickerView.tag = 1;
        pickerView1.tag = 2;
        
        quantity.becomeFirstResponder()
        
    }
    
    @objc func nextScreen(){
        performSegue(withIdentifier: "information", sender: self)
        let vc = storyboard?.instantiateViewController(identifier: "table_vc") as! TablePageViewController
        present(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! TablePageViewController
        vc.info = self.info
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return types.count
        case 2:
            return sizes.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return types[row]
        case 2:
            return sizes[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            coffeeType.text = types[row]
            //coffeeType.resignFirstResponder()
        case 2:
            coffeeSize.text = sizes[row]
            //coffeeSize.resignFirstResponder()
        default:
            return
        }
    }
}
