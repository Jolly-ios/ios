//
//  TableViewPractiseVC.swift
//  SearchFormPractise
//
//  Created by Jolly Gupta on 9/26/25.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
}
class TableViewPractiseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var articleList:[Article] = []
    
   // let list:[String] = ["Hello", "jOLLY", " TONY","Hello", "jOLLY", " TONY","Hello", "jOLLY", " TONY","Hello", "jOLLY", " TONY","Hello", "jOLLY", " TONY"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UINib(nibName: "NameTableViewCell", bundle: nil), forCellReuseIdentifier: "NameTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()

        // Do any additional setup after loading the view.
    }
    
    func fetchData() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=14909627b27d48cebf387d17473c9c2c") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("❌ No data received")
                return
                
            }
            
            DispatchQueue.main.async {
                do{
                    let articleAPIModel = try JSONDecoder().decode(ArticleAPIModel.self, from:data)
                    print(articleAPIModel)
                    self.articleList = articleAPIModel.articles ?? []
                    self.tableView.reloadData()
                }catch{
                    print("JSON parsing error:" , error)
                }
            }
        }
        
        task.resume()
    }
    
    /*func fetchData() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=14909627b27d48cebf387d17473c9c2c") else { return }


        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("❌ No data received")
                return
            }
            
            DispatchQueue.main.async {
                do{
                    let articleAPIModel = try JSONDecoder().decode(ArticleAPIModel.self, from: data)
                    print(articleAPIModel)
                    self.articleList = articleAPIModel.articles ?? []
                    self.collectionView.reloadData()
                }catch{
                    print("❌ JSON parsing error:", error)
                }
            }
            
           
            
//            do {
//                // Example: parse JSON into a dictionary
//                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
//                    print("✅ Response JSON:", json)
//                    if let articles = json["articles"] as? [[String: Any]] {
//                        if let author = articles.first?["author"] as? String {
//                            print(author)
//                            //print(
//                        }
//                        if let title = articles.first?["title"] as? String {
//                            print(title)
//                        }
//                        if let url = articles.first?["url"] as? String {
//                            print(url)
//                        }
//                        if let source = articles.first?["source"] as? [String: Any] {
//                            if let name = source["name"] as? String {
//                                print(name)
//                            }
//                        }
//                    }
//                }
//            } catch {
//                print("❌ JSON parsing error:", error)
//            }
        }
        
        
    }*/
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //if (indexPath.row % 2 != 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell", for: indexPath) as! NameTableViewCell

            let article = articleList[indexPath.row]
            cell.FirstLabel.text = article.author
            cell.SecondLabel.text = article.content
            return cell
        
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
//            cell.titleLabel.text = list[indexPath.row]
//            return cell
//        }
//    
    }
 

    
}
