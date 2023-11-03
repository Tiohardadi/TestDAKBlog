//
//  ViewController.swift
//  TestDAKBlog
//
//  Created by Tio Hardadi Somantri on 11/3/23.
//

import UIKit
import CoreData

class ArticleTableViewController: UITableViewController, UISearchBarDelegate {
    var context: NSManagedObjectContext?
//    var users: [UserModel] = []
//    func getData(){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
//
//        do {
//            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
//            print(result.count)
//            guard result.count != 0 else {return}
//            users = []
//            result.forEach { user in
//                users.append(
//                    UserModel(
//                        firstName: user.value(forKey: "first_name") as! String,
//                        lastName: user.value(forKey: "last_name") as! String,
//                        aliasName: user.value(forKey: "alias_name") as! String,
//                        dateOfBirth: user.value(forKey: "date_of_birth") as! String,
//                        mobilePhone: user.value(forKey: "mobile_phone") as! String,
//                        email: user.value(forKey: "email") as! String,
//                        address: user.value(forKey: "address") as! String,
//                        notes: user.value(forKey: "notes") as! String,
//                        photo: user.value(forKey: "photo") as? Data ?? Data()
//                    )
//                )
//            }
//            print(users)
//        } catch let err{
//            print(err)
//        }
//
//        tableView.reloadData()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
//        getData()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "articleListCell")
        tableView.delegate = self
        tableView.dataSource = self
        setupNavigationItem()
    }
    
    func setupNavigationItem() {
        title = "Contact"
        buttonAddView()a
    }
    
    func buttonAddView() {
        let imageAdd = UIImage(systemName: "plus")
        let rightBarButton = UIBarButtonItem(image: imageAdd, style: .plain, target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func addAction() {
//        let vc = CreateViewController()
//        let reloadData = {self.getData()}
//        vc.reloadData = reloadData
//        let navigationVC = UINavigationController(rootViewController: vc)
//        navigationController?.present(navigationVC, animated: true, completion: nil)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleListCell", for: indexPath)
//        let row: Int = indexPath.row
//        let firstname = users[indexPath.row].firstName
//        print(firstname)
        cell.textLabel?.text = "firstname"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailViewController = DetailViewController()
//        detailViewController.fill( users[indexPath.row] )
//        navigationController?.pushViewController(detailViewController, animated: true)
    }

}


