//
//  ViewController.swift
//  SUChemistryiOSApp
//


import UIKit

class ViewController: UIViewController {
    
    //@IBOutlet var label: UILabel! connected to label from main
    var label1: UILabel!
    var label2: UILabel!
    var label3: UILabel!
    var textField1: UITextField!
    var textField2: UITextField!
    
    var button = dropDownBtn()

    override func loadView() {
        view = UIView() // parent class of UIKIT view types
        view.backgroundColor = .white
        
        
        //Configure the button
        button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height:0 ))// changing these does nothing
        button.setTitle("Sample List", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //Add Button to the View Controller
        self.view.addSubview(button)
        
 
        
        //Set the drop down menu's options
        
        label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.font = UIFont.systemFont(ofSize: 15)
        label1.textAlignment = .left
        label1.text = "Sample Name:"
        view.addSubview(label1)
        
        label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.font = UIFont.systemFont(ofSize: 15)
        label2.text = "Label 2"
        label2.numberOfLines = 0
        view.addSubview(label2)
        /*
        label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.font = UIFont.systemFont(ofSize: 24)
        label3.text = "Label 3"
        label2.numberOfLines = 0
        view.addSubview(label3)
        */
        
        textField1 = UITextField()
        textField1.translatesAutoresizingMaskIntoConstraints = false
        textField1.font = UIFont.systemFont(ofSize: 15)
        textField1.text = "Input 1"
        view.addSubview(textField1)
        
        textField2 = UITextField()
        textField2.translatesAutoresizingMaskIntoConstraints = false
        textField2.font = UIFont.systemFont(ofSize: 15)
        textField2.autocorrectionType = .no // to get rid of stupid constrain warning -_-
        textField2.text = "Input 2"
        view.addSubview(textField2)
        //button Constraints
        //button.topAnchor.constraint(equalTo: label2.bottomAnchor)
        //button.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.firstBaselineAnchor, constant: 75).isActive = true // must find way to scale with other phones
        //button.firstBaselineAnchor.constraint(equalTo: self.view.firstBaselineAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 275).isActive = true
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.dropView.dropDownOptions = ["Blue", "Green", "Magenta", "White", "Black", "Pink"]
        
        
        NSLayoutConstraint.activate([ // initial all anchors at the same time
            
           
                      // label1.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            //label1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            //button.topAnchor.constraint(equalTo: label1.bottomAnchor) // constant + pushes it down the screen
           // button.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor), // constant + decreases width
            //button.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.5, constant: -50),
            
            
            label1.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 100),
            label1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            textField1.topAnchor.constraint(equalTo: label1.topAnchor),
            textField1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 110),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 25),
            label2.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            //label2.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6,constant: -100 ),
            
            
            textField2.topAnchor.constraint(equalTo: label2.topAnchor),
            textField2.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 75),            /*
            label3.topAnchor.constraint(equalTo: button.bottomAnchor),
            label3.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100), // 15:03
            label3.widthAnchor.constraint(equalTo:view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            label3.heightAnchor.constraint(equalTo: label2.heightAnchor)
             */
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        //Configure the button
        button = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Colors", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        //Add Button to the View Controller
        self.view.addSubview(button)
        
        //button Constraints
        button.topAnchor.constraint(equalTo: label2.bottomAnchor)
        //button.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.firstBaselineAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Set the drop down menu's options
        button.dropView.dropDownOptions = ["Blue", "Green", "Magenta", "White", "Black", "Pink"]
        */
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// waiting for others to push code to start working on showing data on UI
    // Deletes the current samples saved data or just clears the screen back to default if no data is saved
    @objc
    func deleteAction(){
        
    }
    // Saves the current samples data(name,concentration, RGB, absorbance, wavelength, thumbnails)
    @objc
    func saveAction(){
        
    }
    
    func defaultValues(){
        
    }
    
    func updateValues(){
        
    }
    
    func deleteValues(){
        
    }

}

protocol dropDownProtocol {
    func dropDownPressed(string : String)
}
    
    
class dropDownBtn: UIButton, dropDownProtocol {
    
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    var dropView = dropDownView()
    
    var height = NSLayoutConstraint()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
        
        dropView = dropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true // where the drop spawns
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true //
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
             
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropView.tableView.contentSize.height > 75 { // size of dropdown animation
                self.height.constant = 75
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    var dropDownOptions = [String]()
    
    var tableView = UITableView()
    
    var delegate : dropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = UIColor.darkGray
        self.backgroundColor = UIColor.darkGray
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
