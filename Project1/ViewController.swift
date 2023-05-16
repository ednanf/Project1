//
//  ViewController.swift
//  Project1
//
//  Created by Ednan R. Frizzera Filho on 13/05/23.
//

import UIKit

class ViewController: UITableViewController {
// MARK: - Properties
    var pictures: [String] = []
    
    
// MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // ***CHALLENGE 2 from PROJECT 3***: add a bar button to the main VC that recommends the app to other people
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        // This loop appends the files in the filesystem that have the prefix "nssl" to the array declared above called "pictures."
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item) // Append to the array.
                // ***CHALLENGE 2***: sort pictures
                pictures.sort()
            }
        }
    }
    
    // This function will create as many cells as needed for pictures.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // This function recycles the cells while scrolling, obtaining the file name and adding it as the cell's content.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) // This method called on tableView returns a UITableViewCell
        cell.textLabel?.text = pictures[indexPath.row] // Access the properties from the constant cell created above - the text.
        return cell // Returns the declared cell to the function.
    }
    
    // Creates DetailViewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // This will make DeatailViewController to be named "vc" -- The screen is called "Detail" in the IB
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
            // ***CHALLENGE 3***: send array position + total number of pictures to DetailViewController
            vc.selectedPictureNumber = indexPath.row + 1 // +1 is to compensate array index starting at 0
            vc.totalPictures = pictures.count
        }
    }
    
    // ***CHALLENGE 2 from PROJECT 3***: add a bar button to the main VC that recommends the app to other people
    @objc func shareApp() {
        if let URL = URL(string: "https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt=8"), !URL.absoluteString.isEmpty {
        let objectsToShare = [URL]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.present(activityVC, animated: true, completion: nil)
        } else {
           missingApp()
        }
    }
    
    func missingApp() {
        let noApp = UIAlertController(title: "Attention!", message: "The app is not available yet!.", preferredStyle: .alert)
        present(noApp, animated: true)
    }

    
}

