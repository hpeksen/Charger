//
//  DataAndTimeViewController.swift
//  Charger
//
//  Created by Hakan Pekşen on 17.07.2022.
//

import UIKit

class DataAndTimeViewController: UIViewController {

    @IBOutlet weak var socket1CollectionView: UICollectionView!
    @IBOutlet weak var socket2CollectionView: UICollectionView!
    @IBOutlet weak var socket3CollectionView: UICollectionView!
    private var time: [String] = ["00:00","01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    @IBOutlet weak var txtDate: UITextField!
    let datePicker = UIDatePicker()
    var models: SocketData.Socket?
    let formatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI(){
          // Collection View
        socket1CollectionView.delegate = self
        socket1CollectionView.dataSource = self
        
        socket2CollectionView.delegate = self
        socket2CollectionView.dataSource = self
        
        socket3CollectionView.delegate = self
        socket3CollectionView.dataSource = self
        // Register custom cell
        //socket1CollectionView.register(.init(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeCollectionViewCell")
        socket1CollectionView.register(UINib(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")
        socket2CollectionView.register(UINib(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")
        socket3CollectionView.register(UINib(nibName: "TimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")

        let date = Date()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date = formatter.string(from: date)
        txtDate.text = current_date
        print("current_date-->",current_date)
        
        
        createDatePicker()
        
        getCityRequest() {  code in
            switch code{
            case .success(let code):
                if(code == 200){
                    DispatchQueue.main.async {
                        self.socket1CollectionView.reloadData()
                        self.socket2CollectionView.reloadData()
                        self.socket3CollectionView.reloadData()
                    }
                }
            case .failure(let err):
                print(err)
            }
        }
        
      }
  
    func createDatePicker() {
        txtDate.textAlignment = .center
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(doneButtonClicked))
        toolbar.setItems([doneButton], animated: true)
        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = datePicker
        datePicker.datePickerMode = .date
        }
    @objc func doneButtonClicked(){
        txtDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    func getCityRequest( completion: @escaping (Result<Int, Error>) -> Void){
        var userId:Int
        userId = UserDefaults.standard.object(forKey: "userID") as! Int
        var token:String!
        token = UserDefaults.standard.object(forKey: "token") as? String
        let url = URL(string: "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/stations/10?userID=\(String(describing: userId))&date=2022-11-30")!
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
                let socketData = try JSONDecoder().decode(SocketData.Socket.self, from: responseData)
                completion(.success(httpResponse.statusCode))
                self.models = socketData
                print("\(socketData)")
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        // perform the task
        task.resume()
    }
}

extension DataAndTimeViewController:UICollectionViewDelegate{
}
extension DataAndTimeViewController:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as? TimeCollectionViewCell else { return UICollectionViewCell() }
            let time = time[indexPath.row]
            cell.btnTime.setTitle(time, for: .normal)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return time.count
           
    }
}
