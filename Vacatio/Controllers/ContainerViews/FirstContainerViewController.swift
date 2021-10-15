//
//  FirstContainerViewController.swift
//  Vacatio
//
//  Created by Andrew Saeyang on 10/5/21.
//

import UIKit

class FirstContainerViewController: UIViewController {
    
    // MARK: - Properties
    private let cellReuse = "firstContainer"
    
    // TODO: Does this need to be in a didSet?
    var items: [Item]?{
        didSet{
            updateView()
        }
    }
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func updateView(){
        //guard let items = items else { return }
        //tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
} // End of class

extension FirstContainerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let items = items{
            return items.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuse, for: indexPath) as? FirstContainerTableViewCell else { return UITableViewCell()}
        
        if let items = items{
            cell.item = items[indexPath.row]
        }
        
        return cell
        
    }
} // End of Extension
