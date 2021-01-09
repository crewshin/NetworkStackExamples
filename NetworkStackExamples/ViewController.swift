//
//  ViewController.swift
//  NetworkStackExamples
//
//  Created by Gene Crucean on 1/8/21.
//

//////////////////////////////////////////////////////////////////////////////////////////
// This is about as simple as it gets with a tiny bit of logic to test...
// however, this is not exactly the best way to architect an app.
//
// The intention here is to showcase different examples on how to
// architect an app with a network stack and unit tests.
//
// Feel free to checkout whichever branch you want to learn more about.
//
// Dig in and git yer learn on.
//
// Contribute if you think you have a clean technique.
// - Fork
// - Create branch (name it something like `examples/protocol-based-mvvm-[username if needed]`)
// - Create pull request to merge into this repo. Let's keep the branch names intact.
//      - The PR shouldn't merge into `main`.
//////////////////////////////////////////////////////////////////////////////////////////

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadData()
    }

    func downloadData() {
        let request = URLRequest(url: URL(string: "https://swapi.dev/api/people")!)
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in

            guard let data = data, error == nil, let peopleResponse = try? JSONDecoder().decode(PersonResponse.self, from: data) else {
                return
            }
            
            self?.people = peopleResponse.results
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.resume()
    }
    
    func convertCentimetersToInches(centimeters: Double) -> Double {
        // 1in = 2.54cm
        return centimeters / 2.54
    }
    
    func convertInchesToFeet(inches: Double) -> Double {
        // 1ft = 12in
        return inches / 12
    }
    
    func formatHeight(height: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: height)) ?? "ERROR"
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        
        cell.textLabel?.text = people[indexPath.row].name
        
        let height = people[indexPath.row].height
        let inches = convertCentimetersToInches(centimeters: Double(height) ?? 0)
        let feet = convertInchesToFeet(inches: inches)
        cell.detailTextLabel?.text = "Height: \(formatHeight(height: feet))ft"
        
        return cell
    }
}
