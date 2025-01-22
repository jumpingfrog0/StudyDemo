//
//  StringExtension.swift
//  SwiftDemo
//
//  Created by huangdonghong on 2024/10/25.
//  Copyright © 2024 lizhi. All rights reserved.
//

import Foundation

extension String {
    var length: Int {
        return utf16.count
    }
    
    var sequences: [String] {
        var arr = [String]()
        enumerateSubstrings(in: startIndex..<endIndex, options: .byComposedCharacterSequences) { (substring, _, _, _) in
            if let str = substring { arr += [str] }
        }
        return arr
    }
    
    func substring(toLength: Int) -> String {
        guard toLength < length else {
                return self
        }
        var results = String()
        for index in 0 ..< sequences.count {
            if results.length + sequences[index].length <= toLength {
                results.append(sequences[index])
            }
            else {
                return results
            }
        }
        return self
    }
}
