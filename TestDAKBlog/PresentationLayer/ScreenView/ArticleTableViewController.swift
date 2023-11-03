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
    let userDefault = UserDefaults.standard
    var article: [DataArticle] = []
    func getData(){
        NetworkServices().getArticle() { (result) in
            switch result {
            case .success(let success):
                self.article = success.data!
                self.tableView.reloadData()
            case .failure(let error):
                print("==>> get Fail :",error)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getData()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "articleListCell")
        tableView.delegate = self
        tableView.dataSource = self
        setupNavigationItem()
    }
    
    func setupNavigationItem() {
        title = "Artikel"
        buttonAddView()
    }
    
    func buttonAddView() {
        let imageAdd = UIImage(systemName: "plus")
        let rightBarButton = UIBarButtonItem(image: imageAdd, style: .plain, target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func addAction() {
        let alert = UIAlertController(title: "Tambah Artikel", message: "Buat Artikel Baru", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Judul"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Deskripsi"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let title = alert?.textFields![0].text ?? ""
            let desc = alert?.textFields![1].text ?? ""
            NetworkServices().addArticle(title: title, description: desc) { (result) in
                switch result {
                case .success(let success):
                    self.getData()
                case .failure(let error):
                    self.getData()
                    print("==>> add article Fail :",error)
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
       
        
        
        
//        let vc = CreateViewController()
//        let reloadData = {self.getData()}
//        vc.reloadData = reloadData
//        let navigationVC = UINavigationController(rootViewController: vc)
//        navigationController?.present(navigationVC, animated: true, completion: nil)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return article.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleListCell", for: indexPath)
        let row: Int = indexPath.row
        let title = article[row].title
        cell.textLabel?.text = title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailViewController = DetailViewController()
//        detailViewController.fill( users[indexPath.row] )
//        navigationController?.pushViewController(detailViewController, animated: true)
    }

}


