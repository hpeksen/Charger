//
//  CityViewController.swift
//  Charger
//
//  Created by Hakan Pekşen on 6.07.2022.
//

import UIKit

class CityViewController: UIViewController {

    @IBOutlet weak var tableViewCity: UITableView!
    @IBOutlet weak var txtSearchCity: UISearchBar!
    var selectedCity: String = ""
    var searchCities : [String] = []
    var models: [String] = ["Adana","Adıyaman","Afyonkarahisar","Ağrı","Aksaray","Amasya","Ankara","Antalya","Ardahan","Artvin","Aydın","Balıkesir","Bartın","Batman","Bayburt","Bilecik","Bingol","Bitlis","Bolu","Burdur","Bursa","Çanakkale","Çankırı","Çorum","Denizli","Diyarbakır","Düzce","Edirne","Elazığ","Erzincan","Erzurum","Eskişehir","Gaziantep","Giresun","Gümüşhane","Hakkari","Hatay","Iğdır","Isparta","İstanbul","İzmir","Kahramanmaraş","Karabük","Karaman","Kars","Kastamonu","Kayseri","Kilis","Kırıkkale","Kırklareli","Kırşehir","Kocaeli","Konya","Kütahya","Malatya","Manisa","Mardin","Mersin","Muğla","Muş","Nevşehir","Niğde","Ordu","Osmaniye","Rize","Sakarya","Samsun","Şanlıurfa","Siirt","Sinop","Şırnak","Sivas","Tekirdağ","Tokat","Trabzon","Tunceli","Uşak","Van","Yalova","Yozgat","Zonguldak"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCity.delegate = self
        tableViewCity.dataSource = self
        searchCities = models
        
        
//        getCityRequest() {  code in
//            switch code{
//            case .success(let code):
//                if(code == 200){
//                    DispatchQueue.main.async {
//                       // if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
//                           // self.navigationController.pushViewController(vc, animated: true)
//                        self.tableViewCity.reloadData()
//                        //}
//                    }
//                }
//            case .failure(let err):
//                print(err)
//            }
//        }
    }
    func goDetail(city: String) {
        selectedCity = city
        performSegue(withIdentifier: "stationSelection", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "stationSelection" {
               let detailVC = segue.destination as! StationViewController
               detailVC.selectedCity = selectedCity
           }
       }
    
    func getCityRequest( completion: @escaping (Result<Int, Error>) -> Void){
        var userId:Int
        userId = UserDefaults.standard.object(forKey: "userID") as! Int
        var token:String!
        token = UserDefaults.standard.object(forKey: "token") as? String
        let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/provinces?userID=\(String(describing: userId))")!
       
        print("URLLLL: \(url.absoluteURL)")
        // create the session object
        let session = URLSession.shared
        
        // now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "GET" //set http method as GET

        request.addValue(token!, forHTTPHeaderField: "token")
       
        // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                return
            }
            
            // ensure there is valid response code returned from this HTTP response
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                print("Invalid Response received from the server")
                return
            }
            
            // ensure there is data returned
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            
            do {
                // create json object from data or use JSONDecoder to convert to Model stuct
                let city = try JSONDecoder().decode(CityData.self, from: responseData)
                completion(.success(httpResponse.statusCode))
              
                print("\(String(describing: city.city))")
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        // perform the task
        task.resume()
    
        
        
        
    }
    
}
extension CityViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCities = models.filter({$0.lowercased().contains(searchText.lowercased())})
        self.tableViewCity.reloadData()
    }
}
extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        goDetail(city: models[indexPath.row])
    }
    
}
extension CityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchCities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            cell.textLabel?.text = searchCities[indexPath.row]
            return cell
        }
}



struct CityData: Decodable, Equatable {
    
    let city : City
    
    
    struct City: Decodable, Equatable {
        let city : String
    }
}
