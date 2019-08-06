//
//  ViewController.swift
//  MergeSort
//
//  Created by syj on 2019/8/2.
//  Copyright © 2019 syj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var debug = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let ret = mergeSortBottomUp(array, <)
        print("ret", ret);
    }
    
    let array = [8, 4, 5, 7, 1, 3, 6, 2]
    
    func mergeSortBottomUp<T>(_ a: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        let n = a.count
        var z = [a, a]   // the two working arrays
        var d = 0        // z[d] is used for reading, z[1 - d] for writing
        
        var width = 1
        while width < n {
            
            if(debug) {
                for int in 0..<n {
                    z[1-d][int] = 0 as! T
                }
            }
            
            var i = 0
            while i < n {
                
                var j = i
                var l = i
                var r = i + width
                
                let lmax = min(l + width, n)
                let rmax = min(r + width, n)
                
                while l < lmax && r < rmax {
                    if isOrderedBefore(z[d][l], z[d][r]) {
                        z[1 - d][j] = z[d][l]
                        l += 1
                    } else {
                        z[1 - d][j] = z[d][r]
                        r += 1
                    }
                    j += 1
                }
                while l < lmax {
                    z[1 - d][j] = z[d][l]
                    j += 1
                    l += 1
                }
                while r < rmax {
                    z[1 - d][j] = z[d][r]
                    j += 1
                    r += 1
                }
                i += width*2
            }
            
            width *= 2   // in each step, the subarray to merge becomes larger
            d = 1 - d
        }
        
        return z[d];
    }

}

