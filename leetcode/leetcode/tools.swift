//
//  tools.swift
//  leetcode
//
//  Created by doxie on 9/20/18.
//  Copyright © 2018 Xie. All rights reserved.
//

import Foundation
func arryToList(array: [Int]) -> ListNode? {
    if array.count > 0 {
        let root = ListNode(array[0])
        var temp = root
        for i in 1..<array.count
        {
            let node = ListNode(array[i])
            temp.next = node
            temp = node
        }
        return root
    } else {
        return nil
    }
}

func listToArray(head: ListNode) -> [Int] {
    var array = [Int]()
    var temp = head
    array.append(head.val)
    while temp.next != nil {
        array.append((temp.next?.val)!)
        temp = temp.next!
    }

    return array
}
