//
//  HorizonalViewController.swift
//  SearchFormPractise
//
//  Created by Jolly Gupta on 10/1/25.
//

import UIKit

class HorizonalViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
}

struct ArticleAPIModel: Codable {
    let articles:[Article]?
}

struct Article: Codable {
    let author:String?
    let content:String?
    let description:String?
    
}



class HorizonalViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var articleList: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        fetchData()

        // Do any additional setup after loading the view.
    }
    
    func fetchData() {
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
        
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizonalViewCell", for: indexPath) as! HorizonalViewCell
        let articleAuthor = articleList[indexPath.row].author
        cell.title.text = articleAuthor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
    }
    

}
