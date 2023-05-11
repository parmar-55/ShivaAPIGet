//
//  ViewController.swift
//  getDataInTableView
//
//  Created by Demo 01 on 15/03/23.
//  Copyright © 2023 scs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mytableView: UITableView!
    var arrId=[String]()
    var arrCourse=[String]()
    var arrFess=[String]()
//    var arrPath=[String]()
    var arrDur=[String]()
    var arrImage=[String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequest()
    }

    func getRequest() {
        
        let url = URL(string:"https://shivaconceptdigital.com/api/viewallcourse.php") // change the url
        
        // create URLSession with default configuration
        let session = URLSession.shared
        
        // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: url!) { data, response, error in
            
            if let error = error {
                print("GET Request Error: \(error.localizedDescription)")
                return
            }
            
            // ensure there is valid response code returned from this HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid Response received from the server")
                    return
            }
            
            // ensure there is data returned
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            do {
                // serialise the data object into Dictionary [String : Any]
                let json = try! JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any]
                if let data = json?["result"] as? [Any]
                    
                {
                    for item in data {
                        let object = item as? [String: Any]
                        
                        let id = object?["courseid"]
                        let name = object?["coursename"]
                        let dur = object?["duration"]
                        let fees = object?["fees"]
                        var path = object?["path"]
                        path = "https://shivaconceptdigital.com/\(path!)"
                        //   let data  = ("\(id!)  \(name!) \(dur!), \(fees!)")
                        //                        print(data)
                        self.arrId.append(id! as! String)
                        self.arrCourse.append(name! as! String)
                        self.arrDur.append(dur! as! String)
                        self.arrFess.append(fees! as! String)
                        self.arrImage.append(path! as! String)
                    }
                    DispatchQueue.main.async {
                        self.mytableView.reloadData()
                    }
                } else {
                    print("data maybe corrupted or in wrong format")
                    throw URLError(.badServerResponse)
                }
            } catch let error {
                print("JSON Parsing Error: \(error.localizedDescription)")
            }
        }
        // resume the task
        task.resume()
        
    }
}


class tableviewCl: UITableViewCell {
    @IBOutlet var idlbl : UILabel!
    @IBOutlet var Courselbl : UILabel!
}


extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tableviewCl
        cell.idlbl.text = arrId[indexPath.row]
        cell.Courselbl.text = arrCourse[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "second") as? secondViewController
        vc!.course = arrCourse[indexPath.row]
        vc!.fees = ("$\(arrFess[indexPath.row])")
        vc!.duration = arrDur[indexPath.row]
        vc!.img = arrImage[indexPath.row]

        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
   
}
