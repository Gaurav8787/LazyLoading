//
//  ViewController.swift
//  LazyLoading
//
//  Created by Gaurav on 09/02/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableview: UITableView!
    var items:Array = [AnyObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
       
        cell.lblTitle.text = "Row \(indexPath.row)"
        cell.imgPic.image = nil
        let rowno = ((indexPath.row+1)%6)
        
        //cell.lazyImage.showWithSpinner(imageView:cell.imgPic, url:"http://placehold.it/2000x2000&text=imagesfdsgdgsdgdsdfsdfs\(indexPath.row+1)")
        cell.lazyImage.showWithSpinner(imageView:cell.imgPic, url:"https://eoimages.gsfc.nasa.gov/images/imagerecords/74000/74393/world.topo.200407.3x5400x2700.jpg")
        
//        let imageDictionary = items[indexPath.row] as! NSDictionary
//        let imageUrlString = imageDictionary.object(forKey: "thumb") as! String
        
      //    cell.lazyImage.showWithSpinner(imageView:cell.imgPic, url:imageUrlString)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//         items.append("http://i0.wp.com/hypebeast.com/image/2013/01/hot-toys-iron-man-3-mark-xlii-collectible-bust_1.jpg?w=1410");
//         items.append("http://t0.gstatic.com/images?q=tbn:ANd9GcT4PZc648WRoXzxEdLQA9zMGqBx93_um_HxvsjgYhoY3AvDtkzI");
//         items.append("http://i0.wp.com/hypebeast.com/image/2013/03/hot-toys-iron-man-3-iron-patriot-collectible-bust-2.jpg?w=930");
//         items.append("http://t3.gstatic.com/images?q=tbn:ANd9GcTf_6e7G9pIiw7ZlRRPfdq63NP-jRA6tmstL1ji-ZFEVnTkDjSp");
//         items.append("http://i0.wp.com/hypebeast.com/image/2013/01/hot-toys-iron-man-3-mark-xlii-collectible-bust_1.jpg?w=1410");
//         items.append("http://4.bp.blogspot.com/-KlZshKtr0DM/UWDGlG1YqtI/AAAAAAAAAFc/Qt89IIY3s6s/s1600/iron-man-3.jpg");
//
      //  loadListOfImages()
        
        
    }
    
    func loadListOfImages()
    {
        // Send HTTP GET Request
        
        // Define server side script URL
        let scriptUrl = "http://swiftdeveloperblog.com/list-of-images/"
        
        // Add one parameter just to avoid caching
        let urlWithParams = scriptUrl + "?UUID=\(NSUUID().uuidString)"
        
        // Create NSURL Ibject
        let myUrl = URL(string: urlWithParams);
        
        // Creaste URL Request
        var request = URLRequest(url:myUrl!)
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = "GET"
        
        
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            // Check for error
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // Convert server json response to NSDictionary
            do {
                if let convertedJsonIntoArray = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                    
                    self.items = convertedJsonIntoArray as [AnyObject]
                    
                    DispatchQueue.main.async {
                        self.myTableview!.reloadData()
                    }
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

