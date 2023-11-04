//
//  ViewController.swift
//  TodoAPP
//
//  Created by Bowon Han on 11/4/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

// MARK: - for canvas
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable{
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider{
    static var previews: some View{
        ViewControllerRepresentable()
    }
}
