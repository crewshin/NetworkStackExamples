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
    
    let viewModel = ViewControllerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchPeople()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        
        cell.textLabel?.text = viewModel.people[indexPath.row].name
        
        let height = viewModel.people[indexPath.row].height
        let inches = viewModel.convertCentimetersToInches(centimeters: Double(height) ?? 0)
        let feet = viewModel.convertInchesToFeet(inches: inches)
        cell.detailTextLabel?.text = "Height: \(viewModel.formatHeight(height: feet))ft"
        
        return cell
    }
}

// MARK: - ViewControllerViewModelDelegate

extension ViewController: ViewControllerViewModelDelegate {
    func peopleFetched() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func peopleFetchErrored(error: SWAPIError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
