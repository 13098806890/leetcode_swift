//
//  main.swift
//  leetcode
//
//  Created by doxie on 8/24/18.
//  Copyright © 2018 Xie. All rights reserved.
//

import Foundation

//https://leetcode.com/problems/rabbits-in-forest/description/

func numRabbits(_ answers: [Int]) -> Int {
    if answers.count == 0 {
        return 0
    } else {
        var dic: [Int: Int] = [Int: Int]()
        for count in answers {
            if let value = dic[count] {
                dic[count] = value + 1
            } else {
                dic[count] = 1
            }
        }
        var rabbits = 0
        for key in dic.keys {
            if let value = dic[key] {
                rabbits += calculateRabbits(key: key, value: value)
            }
        }
        return rabbits
    }
}

func calculateRabbits(key: Int, value: Int) -> Int {
    if value == 0 {
        return 0
    }
    if key == 0 {
        return value
    } else if value == key + 1 {
        return value
    } else if value <= key {
        return key + 1
    } else {
        return value / (key + 1) * (key + 1) + calculateRabbits(key: key, value: value % (key + 1))
    }
}

//print(numRabbits([0,1,0,2,0,1,0,2,1,1]))

//https://leetcode.com/problems/super-pow/description/
//func superPow(_ a: Int, _ b: [Int]) -> Int {
//    if a == 1 {
//        return 1
//    } else {
//        let length = b.count
//        if length > 2 {
//            return superPow(a, [b[length-2],b[length - 1]])
//        } else if length == 2 {
//
//        }
//    }
//}
let a = 33
func mod(di: Int, count: Int){
    var mul:CLong = di
    for _ in 0...count {
        print(mul%a)
        mul *= di
    }
}

//mod(di: 3,count: 60)

//https://leetcode.com/problems/permutations/description/

func permute(_ nums: [Int]) -> [[Int]] {
    let count = nums.count
    var array = [[Int]]()
    if count == 0 {
        return array
    } else if count == 1{
        array.append(nums)
        return array
    } else {
        for i in 0..<count {
            for _array in permute(nums.filter({ (num) -> Bool in
                return num != nums[i]
            })) {
                array.append([nums[i]] + _array)
            }
        }
        return array
    }
}


//print(permute([1,2,3]))

//https://leetcode.com/problems/print-binary-tree/description/

//func printTree(_ root: TreeNode?) -> [[String]] {
//    var treeStr = [[String]]()
//    if let root = root {
//        let level = calculateTreeDeep(level: 1, root: root)
//
//
//
//    }
//
//    return treeStr
//}
//
//
//func calculateTreeDeep(level: Int, root: TreeNode) -> Int {
//    var maxLevel = level
//    if let left = root.left {
//        let leftLevel = calculateTreeDeep(level: maxLevel + 1, root: left)
//        if maxLevel < leftLevel {
//            maxLevel = leftLevel
//        }
//    }
//    if let right = root.right {
//        let rightLevel = calculateTreeDeep(level: maxLevel + 1, root: right)
//        if maxLevel < rightLevel {
//            maxLevel = rightLevel
//        }
//    }
//
//    return maxLevel
//}
//
//print(calculateTreeDeep(level: 1, root: root))

//https://leetcode.com/problems/monotonic-array/description/
func isMonotonic(_ A: [Int]) -> Bool {
    var increase = 0
    if A.count <= 2 {
        return true
    }
    for i in 1..<A.count {
        if increase == 0 {
            increase = A[i] - A[i-1]
        } else if increase > 0 {
            if A[i] - A[i-1] < 0 {
                return false
            }
        } else {
            if A[i] - A[i-1] > 0 {
                return false
            }
        }
    }
    return true
}
//https://leetcode.com/problems/custom-sort-string/description/

func customSortString(_ S: String, _ T: String) -> String {
    var dic = [Character: Int]()
    var index: Int = 0
    for char in S {
        dic[char] = index
        index += 1
    }
    return String(T.sorted { (a, b) -> Bool in
        if let aValue = dic[a], let bValue = dic[b] {
            return aValue < bValue
        } else if let _ = dic[a] {
            return true
        } else if let _ = dic[b] {
            return false
        } else {
            return false
        }
    })
}

//print(customSortString("exv", "xwvee"))

//https://leetcode.com/problems/rectangle-area/description/
enum LineRelationShipWithPoint {
    case right
    case left
    case top
    case bottom
    case inTheLine
    case outTheLine
}

struct Line {
    var start: CGPoint
    var end: CGPoint
    var portrait: Bool
    init(start: CGPoint, end: CGPoint) {
        self.start = start
        self.end = end
        if self.start.x == self.end.x {
            portrait = true
        } else {
            portrait = false
        }
    }
    func relationshipWithPoint(point: CGPoint) -> LineRelationShipWithPoint {
        if self.portrait {
            if point.x == self.start.x {
                if point.y >= start.y && point.y <= end.y {
                    return .inTheLine
                } else {
                    return .outTheLine
                }
            } else if point.x > self.start.x {
                return .right
            } else {
                return .left
            }
        } else {
            if point.y == self.start.y {
                if point.x >= start.x && point.x <= end.x {
                    return .inTheLine
                } else {
                    return .outTheLine
                }
            } else if point.y > self.start.y {
                return .top
            } else {
                return .bottom
            }
        }
    }

    func crossPointWithPoint(point: CGPoint) -> CGPoint? {
        if self.relationshipWithPoint(point: point) == .inTheLine {
            return point
        } else {
            return nil
        }
    }

    func crossPointWithLine(line: Line) -> [CGPoint]? {
        var points = [CGPoint]()
        if self.portrait == line.portrait {
            if self.relationshipWithPoint(point: line.start) == .inTheLine {
                points.append(line.start)
            }
            if self.relationshipWithPoint(point: line.end) == .inTheLine {
                points.append(line.end)
            }
            if line.relationshipWithPoint(point: self.start) == .inTheLine {
                points.append(self.start)
            }
            if line.relationshipWithPoint(point: self.end) == .inTheLine {
                points.append(self.end)
            }
        } else {
            if self.portrait {
                let point = CGPoint(x: self.start.x, y: line.start.y)
                if self.relationshipWithPoint(point: point) == .inTheLine && line.relationshipWithPoint(point: point) == .inTheLine {
                    points.append(point)
                }
            } else {
                let point = CGPoint(x: line.start.x, y: self.start.y)
                if self.relationshipWithPoint(point: point) == .inTheLine && line.relationshipWithPoint(point: point) == .inTheLine{
                    points.append(point)
                }
            }
        }
        if points.count > 0 {
            return points
        } else {
            return nil
        }

    }

}

enum RectangleRelationShipWithPoint {
    case inner
    case outter
}

struct Rectangle {
    var left: Line
    var right: Line
    var bottom: Line
    var top: Line
    var leftTop: CGPoint
    var leftBottom: CGPoint
    var rightTop: CGPoint
    var rightBottom: CGPoint

    init(leftBottom: CGPoint, rightTop: CGPoint) {
        self.leftBottom = leftBottom
        self.rightTop = rightTop
        self.leftTop = CGPoint(x: leftBottom.x, y: rightTop.y)
        self.rightBottom = CGPoint(x: rightTop.x, y: leftBottom.y)
        self.left = Line(start: leftBottom, end: leftTop)
        self.bottom = Line(start: leftBottom, end: rightBottom)
        self.top = Line(start: leftTop, end: rightTop)
        self.right = Line(start: rightBottom, end: rightTop)
    }

    func relationshipWithPoint(point: CGPoint) -> RectangleRelationShipWithPoint{
        if (self.left.relationshipWithPoint(point: point) == .right || self.left.relationshipWithPoint(point: point) == .inTheLine) &&
            (self.right.relationshipWithPoint(point: point) == .left || self.right.relationshipWithPoint(point: point) == .inTheLine) &&
            (self.top.relationshipWithPoint(point: point) == .bottom || self.top.relationshipWithPoint(point: point) == .inTheLine) &&
            (self.bottom.relationshipWithPoint(point: point) == .top || self.bottom.relationshipWithPoint(point: point) == .inTheLine) {
            return .inner
        } else {
            return .outter
        }
    }

    func lines() -> [Line] {
        return [left,right,top,bottom]
    }

    func vertexes() -> [CGPoint] {
        return [leftTop,rightTop,rightBottom,leftBottom]
    }

    func crossPointsWithRectangle(rectangle: Rectangle) -> [CGPoint]? {
        var points = [CGPoint]()
        for line in self.lines() {
            for otherLine in rectangle.lines() {
                if let crossPoints = line.crossPointWithLine(line: otherLine) {
                    points += crossPoints
                }
            }

            for otherPoint in rectangle.vertexes() {
                if let crossPoint = line.crossPointWithPoint(point: otherPoint) {
                    points.append(crossPoint)
                }
            }
        }

        if points.count > 0 {
            return points
        } else {
            return nil
        }
    }
}

func area(pointA: CGPoint, pointB: CGPoint) -> Int {
    let width = pointA.x > pointB.x ? Int(pointA.x - pointB.x) : Int(pointB.x - pointA.x)
    let height = pointA.y > pointB.y ? Int(pointA.y - pointB.y) : Int(pointB.y - pointA.y)
    return width * height
}

func computeArea(_ A: Int, _ B: Int, _ C: Int, _ D: Int, _ E: Int, _ F: Int, _ G: Int, _ H: Int) -> Int {
    let rectangleA = Rectangle(leftBottom: CGPoint(x: CGFloat(A), y: CGFloat(B)), rightTop: CGPoint(x: CGFloat(C), y: CGFloat(D)))
    let rectangleB = Rectangle(leftBottom: CGPoint(x: CGFloat(E), y: CGFloat(F)), rightTop: CGPoint(x: CGFloat(G), y: CGFloat(H)))

    let AreaA = area(pointA: rectangleA.leftBottom, pointB: rectangleA.rightTop)
    let AreaB = area(pointA: rectangleB.leftBottom, pointB: rectangleB.rightTop)

    var points = [CGPoint]()
    for vertex in rectangleB.vertexes() {
        if rectangleA.relationshipWithPoint(point: vertex) == .inner {
            points.append(vertex)
        }
    }
    for vertex in rectangleA.vertexes() {
        if rectangleB.relationshipWithPoint(point: vertex) == .inner {
            points.append(vertex)
        }
    }

    if let crossPointsWithA = rectangleA.crossPointsWithRectangle(rectangle: rectangleB) {
        points += crossPointsWithA
    }

    if let crossPointsWithB = rectangleB.crossPointsWithRectangle(rectangle: rectangleA) {
        points += crossPointsWithB
    }

    var maxX: Int, minX: Int, maxY: Int, minY: Int
    if points.count == 0 {
        return AreaA + AreaB
    } else {
        maxX = Int(points[0].x)
        minX = Int(points[0].x)
        maxY = Int(points[0].y)
        minY = Int(points[0].y)
        for point in points {
            if Int(point.x) > maxX {
                maxX = Int(point.x)
            }
            if Int(point.x) < minX {
                minX = Int(point.x)
            }
            if Int(point.y) > maxY {
                maxY = Int(point.y)
            }
            if Int(point.y) < minY {
                minY = Int(point.y)
            }
        }
        return AreaA + AreaB - (maxX - minX) * (maxY - minY)
    }
}

//print(computeArea(-3, 0, 3, 4, 0, -1, 9, 2))

//https://leetcode.com/problems/top-k-frequent-elements/description/
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var infoDic = [Int: Int]()
    var result = [Int]()
//    var topNumber = k
//    var numsCount = nums.count
//    var average = nums.count / (topNumber + 1)
    for i in 0..<nums.count {
        if let numCount = infoDic[nums[i]] {
            infoDic[nums[i]] = numCount + 1
        } else {
            infoDic[nums[i]] = 1
        }
//        if result.contains(nums[i]) {
//            numsCount -= 1
//            average = numsCount / (topNumber + 1)
//        } else {
//            if infoDic[nums[i]]! > average {
//                result.append(nums[i])
//                if topNumber > 0 {
//                    topNumber -= 1
//                    numsCount -= infoDic[nums[i]]!
//                    average = numsCount / (topNumber + 1)
//                } else {
//                    return result
//                }
//            }
//        }
    }
    if result.count < k {
        let array = Array(infoDic.keys).sorted { (key1, key2) -> Bool in
            return infoDic[key1]! > infoDic[key2]!
        }
        result = [Int]()
        for i in 0..<k {
            result.append(array[i])
        }
    }
    return result
}

//print(topKFrequent([3,0,1,0], 1))

//https://leetcode.com/problems/keys-and-rooms/description/
func canVisitAllRooms(_ rooms: [[Int]]) -> Bool {
    var roomsFlag = [Int](repeating: 0, count: rooms.count)
    roomsFlag[0] = 1
    var keys = rooms[0]
    var ableToOpenNewRoom = true
    while ableToOpenNewRoom {
        ableToOpenNewRoom = false
        for key in keys {
            keys.append(key)
            if roomsFlag[key] == 0 {
                roomsFlag[key] = 1
                ableToOpenNewRoom = true
                keys += rooms[key]
            }
        }
        keys = keys.filter { (key) -> Bool in
            roomsFlag[key] == 0
        }
    }
    for value in roomsFlag {
        if value == 0 {
            return false
        }
    }

    return true
}

//print(canVisitAllRooms([[1,3],[3,0,1],[2],[0]]))

//https://leetcode.com/problems/summary-ranges/description/
func summaryRanges(_ nums: [Int]) -> [String] {
    var result = [String]()
    var start: Int?
    if nums.count > 0 {
        for i in 0..<nums.count {
            if start == nil {
                start = nums[i]
                if i == nums.count - 1 {
                    result.append(String(nums[i]))
                }
            } else {
                if nums[i] - nums[i-1] != 1 {
                    if nums[i-1] != start {
                        result.append(String(start!) + "->" + String(nums[i-1]))
                    } else {
                        result.append(String(start!))
                    }
                    if i == nums.count - 1 {
                        result.append(String(nums[i]))
                    }
                    start = nums[i]
                } else {
                    if i == nums.count - 1 {
                        result.append(String(start!) + "->" + String(nums[i]))
                    }
                }
            }
        }
    }

    return result
}

//print(summaryRanges([-1]))

//https://leetcode.com/problems/01-matrix/description/
func updateMatrix(_ matrix: [[Int]]) -> [[Int]] {
    var result: [[Int]] = matrix
    let length = result.count
    for i in 0..<length {
        update(&result, count: i+1)
    }
    return result
}

func update(_ matrix: inout [[Int]], count: Int){
    let length = matrix.count
    for i in 0..<matrix.count {
        for j in 0..<matrix[i].count {
            if matrix[i][j] != 0 {
                if i > 0 {
                    if matrix[i-1][j] < count {
                        continue
                    }
                }
                if i + 1 < length {
                    if matrix[i+1][j] < count {
                        continue
                    }
                }
                if j > 0 {
                    if matrix[i][j-1] < count {
                        continue
                    }
                }
                if j + 1 < length {
                    if matrix[i][j+1] < count {
                        continue
                    }
                }
                matrix[i][j] += 1
            }
        }
    }
}

//https://leetcode.com/problems/image-overlap/description/

struct Coordinate: Equatable, Hashable {
    var x: Int
    var y: Int

    static func ==(c1: Coordinate, c2: Coordinate) -> Bool {
        if c1.x == c2.x && c1.y == c2.y {
            return true
        }
        return false
    }

    static func - (c1: Coordinate, c2: Coordinate) -> Coordinate {
        return Coordinate(x: c1.x - c2.x, y: c1.y - c2.y)
    }

    func distance() -> Int {
        return x * x + y * y
    }

    func distanceTo(point: Coordinate) -> Int{
        return (point.x - x) * (point.x - x) + (point.y - y) * (point.y - y)
    }
}

struct ImageInfo {
    var units: [Coordinate: Int] = [Coordinate: Int]()
    var leftTopCoordinate: [Coordinate] = [Coordinate]()
    var rightBottomCoordinate: [Coordinate] = [Coordinate]()
    var original: Coordinate = Coordinate(x: 0, y: 0)
    var width: Int
    var height: Int
    init(matrix: [[Int]]) {
        let size = matrix.count
        for i in 0..<size {
            for j in 0..<size {
                let unit = Coordinate(x: i, y: j)
                if matrix[i][j] == 1 {
                    if let first = leftTopCoordinate.first {
                        if unit.distance() < first.distance() {
                            leftTopCoordinate.removeAll()
                            leftTopCoordinate.append(unit)
                        } else if unit.distance() == first.distance() {
                            leftTopCoordinate.append(unit)
                        }
                    } else {
                        leftTopCoordinate.append(unit)
                    }
                    if let last = rightBottomCoordinate.last {
                        if unit.distanceTo(point: Coordinate(x:size - 1, y: size - 1)) < last.distanceTo(point: Coordinate(x:size - 1, y: size - 1)){
                            rightBottomCoordinate.removeAll()
                            rightBottomCoordinate.append(unit)
                        } else if unit.distanceTo(point: Coordinate(x:size - 1, y: size - 1)) == last.distanceTo(point: Coordinate(x:size - 1, y: size - 1)) {
                            rightBottomCoordinate.append(unit)
                        }
                    } else {
                        rightBottomCoordinate.append(unit)
                    }
                    units[unit] = 1
                }
            }
        }
        if leftTopCoordinate.count == 1 {
            original = leftTopCoordinate.first!
        } else if leftTopCoordinate.count == 2 {
            original = Coordinate(x: min(leftTopCoordinate.first!.x, leftTopCoordinate.last!.x), y: min(leftTopCoordinate.first!.y, leftTopCoordinate.last!.y))
        }
        var last: Coordinate = Coordinate(x: 0, y: 0)
        if rightBottomCoordinate.count == 1 {
            last = rightBottomCoordinate.first!
        } else if rightBottomCoordinate.count == 2{
            last = Coordinate(x: max(rightBottomCoordinate.first!.x, rightBottomCoordinate.last!.x), y: max(rightBottomCoordinate.first!.y, rightBottomCoordinate.last!.y))
        }
        width = last.x - original.x + 1
        height = last.y - original.y + 1
    }

    func overLapValue(image: ImageInfo, bias: Coordinate) -> Int {
        var overLapValue = 0
        for unit in Array(units.keys) {
            let newUnit = Coordinate(x: unit.x - original.x + image.original.x + bias.x, y: unit.y - original.y + image.original.y + bias.y)
            if image.units[newUnit] == 1 {
                overLapValue += 1
            }
        }
        return overLapValue
    }

    func maxOverLapValue(image: ImageInfo) -> Int {
        var maxOverLapValue = 0
        for i in -width...width {
            for j in -height...height {
                let overLapValue = self.overLapValue(image: image, bias: Coordinate(x: i, y: j))
                if  overLapValue > maxOverLapValue {
                    maxOverLapValue = overLapValue
                }
            }
        }
        return maxOverLapValue
    }
}

func largestOverlap(_ A: [[Int]], _ B: [[Int]]) -> Int {
    let imageA = ImageInfo(matrix: A)
    let imageB = ImageInfo(matrix: B)
    return imageA.maxOverLapValue(image: imageB)
}

//let inputA = [[1,0],[0,0]]
//
//let inputB = [[0,1],[1,0]]
//
//print(largestOverlap(inputA, inputB))

//https://leetcode.com/problems/remove-nth-node-from-end-of-list/description/


public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    var array = [ListNode]()
    var count = 0
    var node = head
    while node != nil {
        array.append(node!)
        node = node?.next
        count += 1
    }
    array[count - n - 1].next = array[count - n + 1]
    return head
}

let node = removeNthFromEnd(arryToList(array: [1,2,3,4,5]), 2)

//print(node)

//https://leetcode.com/problems/number-of-islands/description/
struct Point: Hashable {
    var x: Int
    var y: Int
}

func numIslands(_ grid: [[Character]]) -> Int {
    var map = [Point: Int]()
    var islandsBlock = [Int: [Point]]()
    let height = grid.count
    var islandNumber = 0
    if height > 0 {
        let length = grid[0].count
        for i in 0..<height {
            for j in 0..<length {
                let point = Point(x: i, y: j)
                var newLand = true

                func check(new: Point) {
                    if let newIsland = map[new] {
                        if let oldIsland = map[point] {
                            if oldIsland != newIsland {
                                for oldPoint in islandsBlock[oldIsland]! {
                                    map[oldPoint] = newIsland
                                }
                                islandsBlock[newIsland] = islandsBlock[newIsland]! + (islandsBlock[oldIsland]!)
                                islandsBlock.removeValue(forKey: oldIsland)
                            }
                        } else {
                            map[point] = newIsland
                            islandsBlock[newIsland]?.append(point)
                            newLand = false
                        }
                    }
                }

                if grid[i][j] == Character.init("1") {
                    if i > 0 {
                        if grid[i - 1][j] == Character.init("1") {
                            let newPoint = Point(x: i - 1, y: j)
                            check(new: newPoint)
                        }
                    }
                    if j > 0 {
                        if grid[i][j - 1] == Character.init("1") {
                            let newPoint = Point(x: i, y: j - 1)
                            check(new: newPoint)
                        }
                    }
                    if newLand {
                        islandNumber += 1
                        map[point] = islandNumber
                        islandsBlock[islandNumber] = [point]
                    }
                }
            }
        }
    }

    return islandsBlock.keys.count
}

//print(numIslands([["1","1","1","1","1","1","1"],["0","0","0","0","0","0","1"],["1","1","1","1","1","0","1"],["1","0","0","0","1","0","1"],["1","0","1","0","1","0","1"],["1","0","1","1","1","0","1"],["1","1","1","1","1","1","1"]]))

//https://leetcode.com/problems/coin-change/description/
//func coinChange(_ coins: [Int], _ amount: Int) -> Int {
//    if amount == 0 {
//        return 0
//    }
//    let sortedCoins = coins.sorted()
//    for i in 0..<sortedCoins.count {
//        var lastAmount = amount
//        var find = false
//        var count = 0
//        var choosenCoins = [Int]()
//        for coin in sortedCoins[0..<sortedCoins.count - i].reversed() {
//            if coin <= lastAmount {
//                choosenCoins.append(coin)
//                count += lastAmount / coin
//                lastAmount = lastAmount % coin
//                if lastAmount == 0 {
//                    find = true
//                    break
//                }
//            }
//        }
//        if find {
//            return count
//        }
//    }
//    return -1
//}


//print(coinChange([186,419,83,408],6249))


//https://leetcode.com/problems/bulls-and-cows/description/
func getHint(_ secret: String, _ guess: String) -> String {
    var bulls = 0
    var cows = 0
    var secretArray: [Character] = Array(secret)
    var guessArray: [Character] = Array(guess)
    var length = secretArray.count
    for i in 0..<length {
        if secretArray[i-bulls] == guessArray[i-bulls]  {
            secretArray.remove(at: i-bulls)
            guessArray.remove(at: i-bulls)
            bulls += 1
            length -= 1
        }
    }
    secretArray.sort()
    guessArray.sort()
    var i = 0
    var j = 0
    while i != length && j != length {
        if secretArray[i] == guessArray[j] {
            cows += 1
            i += 1
            j += 1
        } else if secretArray[i] > guessArray[j]{
            j += 1
        } else {
            i += 1
        }
    }

    return String(bulls)+"A"+String(cows)+"B"
}

//print(getHint("11", "11"))

//https://leetcode.com/problems/longest-absolute-file-path/description/
class MultiLeavesTree {
    var str: String
    var value: Int
    var isFile: Bool
    var leaves = [MultiLeavesTree]()

    init(str: String) {
        self.str = str
        self.value = str.count
        if str.contains(Character.init(".")) {
            isFile = true
        } else {
            isFile = false
        }
    }
}
func tree(_ input: String) -> MultiLeavesTree {
    let arrays = input.components(separatedBy: CharacterSet.init(charactersIn: "\n"))
    if let first = arrays.first {
        let root = MultiLeavesTree(str: first)
        makeATree(father: root, info: Array(arrays[1..<arrays.count]), level: 1)
        return root
    }

    return MultiLeavesTree(str: "")
}

func makeATree(father: MultiLeavesTree, info: [String], level: Int){
    var start = 0
    var node: MultiLeavesTree = MultiLeavesTree(str: "")
    for i in 0..<info.count {
        let array = info[i].components(separatedBy: CharacterSet.init(charactersIn: "\t"))
        if array.count - 1 == level {
            if start + 1 < i {
                makeATree(father: node, info: Array(info[start + 1..<i]), level: level+1)
                start = i
            }
            node = MultiLeavesTree(str: array.last!)
            father.leaves.append(node)
        }
    }
    if start + 1 < info.count {
        makeATree(father: node, info: Array(info[start + 1..<info.count]), level: level+1)
    }
}

func readTree(node: MultiLeavesTree, value: Int) -> Int {
    var max = value
    if node.leaves.count == 0 && !node.isFile {
        return 0
    }
    if node.isFile {
        return max
    }
    var hasFile = false
    for leaf in node.leaves {
        let newValue = readTree(node: leaf, value: leaf.value + value + 1)
        if newValue != 0 {
            hasFile = true
        }
        if newValue > max {
            max = newValue
        }
    }
    if !hasFile {
        return 0
    }
    return max
}

func lengthLongestPath(_ input: String) -> Int {
    var newInput: String = input
    if input.contains(""){
    }
    let root = tree(newInput)
    return readTree(node: root, value: root.value)
}


//print(lengthLongestPath("dir\n\t        file.txt\n\tfile2.txt"))


//https://leetcode.com/problems/swap-nodes-in-pairs/description/
func swapNodes(pre: ListNode?, first: ListNode) {
    let temp = first.next?.next
    if pre != nil {
        pre?.next = first.next

    }
    if first.next?.next != nil {
        first.next?.next = first
        first.next = temp
    } else {
        first.next?.next = first
        first.next = nil
    }
}

func swapPairs(_ head: ListNode?) -> ListNode? {
    var pre: ListNode? = nil
    var result = head
    if let root = head {
        if root.next != nil {
            result = root.next
        }
        var current: ListNode? = head
        while(current?.next != nil) {
            swapNodes(pre: pre, first: current!)
            pre = current
            current = current?.next
        }
    }

    return result
}

//let input = arryToList(array: [1,2,3,4])
//
//print(listToArray(head: swapPairs(input)!))

//https://leetcode.com/problems/push-dominoes/description/

func pushDominoes(_ dominoes: String) -> String {
    var result: [Character] = Array(dominoes)
    var startIndex: Int = 0
    var start: String = "."
    var leftIndex: Int = 0
    var shouldEnd = false
    var index = 0
    while index < result.count {
        let dominoe = String(result[index])
        if dominoe == "." {
            index += 1
            continue
        }
        if !shouldEnd {
            start = dominoe
            if dominoe == "R" {
                startIndex = index + 1
            }
            leftIndex = index
            shouldEnd = true
        } else {
            if start == "L" && dominoe == "L" {
                for i in startIndex..<index {
                    result[i] = Character.init("L")
                }
                shouldEnd = false
                leftIndex = index
            } else if start == "L" && dominoe == "R" {
                for i in startIndex..<leftIndex {
                    result[i] = Character.init("L")
                }
                shouldEnd = true
                start = "R"
                leftIndex = index
            } else if start == "R" && dominoe == "L" {
                let length = (index - leftIndex - 1) / 2
                for i in leftIndex + 1..<leftIndex + 1 + length {
                    result[i] = Character.init("R")
                }
                for i in index - length..<index {
                    result[i] = Character.init("L")
                }
                shouldEnd = false
                leftIndex = index
            } else if start == "R" && dominoe == "R" {
                for i in startIndex..<index {
                    result[i] = Character.init("R")
                }
                shouldEnd = true
                start = "R"
                leftIndex = index
            }
            startIndex = index + 1
        }
        index += 1
    }
    if shouldEnd {
        if start == "R" {
            for i in leftIndex + 1..<result.count {
                result[i] = Character.init("R")
            }
        } else if start == "L" {
            for i in startIndex..<leftIndex {
                result[i] = Character.init("L")
            }
        }

    }
    return String(result)
}

//print(pushDominoes(".RR.."))

//https://leetcode.com/problems/group-anagrams/description/
func hashValue(_ str: String) -> UInt64 {
    var hash: UInt64 = 0
    for code in str.unicodeScalars {
        let value = code.value - 97
        hash += UInt64(pow(5.0, Double(value)))
    }

    return hash
}

func groupAnagrams(_ strs: [String]) -> [[String]] {
    var dic = [UInt64 : [String]]()
    for str in strs {
        let hash = hashValue(str)
        if let strings = dic[hash] {
            dic[hash] = strings + [str]
        } else {
            dic[hash] = [str]
        }
    }
    return Array(dic.values)
}
//print(groupAnagrams(["hos","boo","nay","deb","wow","bop","bob","brr","hey","rye","eve","elf","pup","bum","iva","lyx","yap","ugh","hem","rod","aha","nam","gap","yea","doc","pen","job","dis","max","oho","jed","lye","ram","pup","qua","ugh","mir","nap","deb","hog","let","gym","bye","lon","aft","eel","sol","jab"]))

//https://leetcode.com/problems/koko-eating-bananas/description/
func checkEatingSpeed(_ piles: [Int], _ H: Int, _ S: Int) -> Int {
    var spendHours: Int = 0
    for pile in piles {
        spendHours += pile / S
        if pile % S != 0 {
            spendHours += 1
        }
        if spendHours > H {
            return -1
        }
    }
    if spendHours == H {
        return 0
    }
    return 1
}
func minEatingSpeed(_ piles: [Int], _ H: Int) -> Int {
    let sortedPiles = piles.sorted()
    if H == piles.count {
        return sortedPiles.last!
    } else if H == piles.count + 1 && piles.count > 1{
        return sortedPiles[piles.count - 2]
    }
    var start = 0
    var end = sortedPiles.last!
    for i in sortedPiles {
        if checkEatingSpeed(piles, H, i) < 0 {
            start = i
        } else {
            end = i
            break
        }
    }
    return findMinEatingSpeedScope(start: start, end: end, piles: piles, H: H)
}

func findMinEatingSpeedScope(start: Int, end: Int, piles: [Int], H: Int) -> Int {
    while start != end && start + 1 != end {
        let mid = (start + end) / 2
        let result = checkEatingSpeed(piles, H, mid)
        if result < 0 {
            return findMinEatingSpeedScope(start: mid, end: end, piles: piles, H: H)
        } else if result > 0 {
            return findMinEatingSpeedScope(start: start, end: mid, piles: piles, H: H)
        } else {
            return findMinEatingSpeed(start: start, end: mid, piles: piles, H: H)
        }
    }
    return end
}

func findMinEatingSpeed(start: Int, end: Int, piles: [Int], H: Int) -> Int {
    while start != end && start + 1 != end {
        let mid = (start + end) / 2
        let result = checkEatingSpeed(piles, H, mid)
        if result < 0 {
            return findMinEatingSpeed(start: mid, end: end, piles: piles, H: H)
        } else {
            return findMinEatingSpeed(start: start, end: mid, piles: piles, H: H)
        }
    }
    return end
}

//print(minEatingSpeed([332484035, 524908576, 855865114, 632922376, 222257295, 690155293, 112677673, 679580077, 337406589, 290818316, 877337160, 901728858, 679284947, 688210097, 692137887, 718203285, 629455728, 941802184],
//    823855818))

//https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/description/

func findMin(_ nums: [Int]) -> Int {
    let start = nums.first!
    let end = nums.last!
    if start > end {
        return binarySearchForMin(nums, start: 0, end: nums.count - 1)
    } else {
        return start
    }
}

func binarySearchForMin(_ nums: [Int], start: Int, end: Int) -> Int {
    while start != end && start + 1 != end {
        let mid = (start + 3 * end) / 4
        if nums[mid] > nums[start] {
            return binarySearchForMin(nums, start: mid, end: end)
        } else {
            return binarySearchForMin(nums, start: start, end: mid)
        }
    }
    return nums[end]
}

//https://leetcode.com/problems/loud-and-rich/description/

class LoudRichPerson: Hashable {
    var hashValue: Int

    static func == (lhs: LoudRichPerson, rhs: LoudRichPerson) -> Bool {
        return lhs.index == rhs.index
    }

    var quite: Int
    var index: Int
    var richerThanMe: [LoudRichPerson] = [LoudRichPerson]()
    static var map = [LoudRichPerson: (Int, Int)]()

    init(_ quite: Int, index: Int) {
        self.quite = quite
        self.index = index
        hashValue = index
    }

    static func quitest(_ person: LoudRichPerson) -> (Int,Int) {
        var min = person.quite
        var index = person.index
        for rich in person.richerThanMe {
            var result: (Int, Int)
            if let dicValue = map[rich] {
                result = dicValue
            } else {
                result = LoudRichPerson.quitest(rich)
            }
            if result.0 < min {
                min = result.0
                index = result.1
            }
        }
        map[person] = (min, index)
        return (min,index)
    }
}

func loudAndRich(_ richer: [[Int]], _ quiet: [Int]) -> [Int] {
    var persons = [LoudRichPerson]()
    var answer = [Int]()
    for i in 0..<quiet.count {
        persons.append(LoudRichPerson.init(quiet[i],index: i))
    }
    for pair in richer {
        let r = persons[pair.first!]
        let p = persons[pair.last!]
        p.richerThanMe += [r]
    }
    for person in persons {
        answer.append(LoudRichPerson.quitest(person).1)
    }
    return answer
}

//
//print(loudAndRich([[0,2],[0,3],[0,5],[0,9],[0,10],[0,11],[0,13],[0,20],[0,22],[0,24],[0,25],[0,26],[0,32],[0,34],[0,35],[0,41],[0,43],[0,46],[0,48],[1,3],[1,5],[1,10],[1,11],[1,15],[1,21],[1,22],[1,25],[1,27],[1,30],[1,31],[1,33],[1,34],[1,36],[1,39],[1,40],[1,47],[1,48],[1,49],[2,3],[2,5],[2,6],[2,12],[2,15],[2,16],[2,18],[2,19],[2,20],[2,24],[2,25],[2,26],[2,29],[2,33],[2,37],[2,38],[2,39],[2,44],[2,47],[2,48],[2,49],[3,8],[3,9],[3,11],[3,12],[3,13],[3,16],[3,18],[3,20],[3,28],[3,30],[3,31],[3,32],[3,33],[3,34],[3,45],[3,46],[3,48],[4,6],[4,7],[4,9],[4,12],[4,13],[4,14],[4,15],[4,20],[4,21],[4,22],[4,26],[4,27],[4,29],[4,35],[4,36],[4,37],[4,38],[4,44],[4,45],[4,46],[5,6],[5,9],[5,11],[5,16],[5,17],[5,19],[5,23],[5,24],[5,25],[5,26],[5,27],[5,28],[5,29],[5,30],[5,35],[5,37],[5,40],[5,42],[5,43],[5,44],[5,45],[5,46],[5,47],[5,48],[6,7],[6,8],[6,9],[6,10],[6,11],[6,12],[6,13],[6,15],[6,16],[6,18],[6,21],[6,24],[6,25],[6,29],[6,30],[6,31],[6,37],[6,38],[6,40],[6,41],[6,42],[6,45],[6,46],[6,48],[6,49],[7,10],[7,11],[7,12],[7,13],[7,15],[7,17],[7,18],[7,19],[7,20],[7,21],[7,26],[7,31],[7,33],[7,36],[7,39],[8,10],[8,16],[8,19],[8,20],[8,22],[8,23],[8,24],[8,25],[8,26],[8,27],[8,29],[8,31],[8,33],[8,36],[8,41],[8,44],[8,45],[8,46],[8,48],[9,11],[9,13],[9,14],[9,15],[9,16],[9,17],[9,18],[9,19],[9,22],[9,28],[9,31],[9,34],[9,35],[9,39],[9,40],[9,42],[9,44],[9,49],[10,11],[10,14],[10,15],[10,16],[10,18],[10,19],[10,21],[10,26],[10,29],[10,33],[10,39],[10,44],[10,47],[10,48],[10,49],[11,13],[11,16],[11,18],[11,19],[11,20],[11,23],[11,25],[11,27],[11,29],[11,31],[11,32],[11,33],[11,35],[11,38],[11,39],[11,40],[11,43],[11,45],[11,47],[12,13],[12,17],[12,18],[12,19],[12,20],[12,21],[12,22],[12,23],[12,24],[12,29],[12,35],[12,36],[12,39],[12,40],[12,43],[12,46],[12,47],[12,49],[13,14],[13,15],[13,16],[13,18],[13,21],[13,22],[13,23],[13,28],[13,30],[13,32],[13,34],[13,36],[13,39],[13,43],[13,45],[13,46],[13,47],[13,48],[14,15],[14,16],[14,17],[14,18],[14,19],[14,20],[14,22],[14,25],[14,27],[14,28],[14,30],[14,32],[14,33],[14,34],[14,39],[14,40],[14,41],[14,42],[14,46],[14,47],[14,49],[15,17],[15,21],[15,22],[15,27],[15,28],[15,29],[15,30],[15,37],[15,38],[15,39],[15,40],[15,41],[15,42],[15,44],[15,45],[15,47],[16,17],[16,18],[16,20],[16,27],[16,29],[16,31],[16,36],[16,37],[16,38],[16,39],[16,40],[16,41],[16,42],[16,45],[16,46],[17,19],[17,23],[17,24],[17,25],[17,26],[17,28],[17,29],[17,31],[17,33],[17,34],[17,35],[17,38],[17,39],[17,41],[17,46],[17,47],[17,48],[17,49],[18,22],[18,23],[18,25],[18,27],[18,28],[18,29],[18,31],[18,36],[18,37],[18,39],[18,40],[18,41],[18,42],[18,43],[18,48],[19,20],[19,21],[19,22],[19,23],[19,24],[19,27],[19,28],[19,30],[19,31],[19,33],[19,35],[19,39],[19,40],[19,44],[19,47],[19,48],[20,25],[20,27],[20,28],[20,29],[20,32],[20,34],[20,37],[20,38],[20,41],[20,43],[20,44],[20,45],[20,46],[20,47],[20,49],[21,22],[21,24],[21,26],[21,27],[21,28],[21,29],[21,32],[21,36],[21,37],[21,43],[21,45],[21,47],[21,48],[22,23],[22,25],[22,28],[22,30],[22,32],[22,37],[22,41],[22,42],[22,44],[22,45],[22,47],[22,48],[22,49],[23,25],[23,26],[23,28],[23,29],[23,30],[23,31],[23,32],[23,33],[23,34],[23,35],[23,38],[23,39],[23,40],[23,42],[23,43],[23,46],[23,48],[23,49],[24,26],[24,27],[24,28],[24,30],[24,31],[24,33],[24,35],[24,37],[24,39],[24,40],[24,42],[24,43],[24,47],[24,48],[24,49],[25,28],[25,30],[25,31],[25,32],[25,35],[25,36],[25,39],[25,40],[25,43],[25,44],[25,45],[25,46],[26,28],[26,30],[26,31],[26,33],[26,36],[26,38],[26,40],[26,41],[26,42],[26,44],[26,45],[26,47],[26,48],[26,49],[27,28],[27,30],[27,34],[27,35],[27,36],[27,39],[27,40],[27,44],[27,45],[27,48],[28,30],[28,31],[28,32],[28,33],[28,34],[28,35],[28,36],[28,37],[28,41],[28,45],[28,46],[28,47],[29,30],[29,31],[29,33],[29,35],[29,36],[29,39],[29,40],[29,45],[29,46],[29,47],[30,31],[30,33],[30,37],[30,38],[30,39],[30,41],[30,43],[30,45],[30,46],[30,49],[31,34],[31,35],[31,36],[31,38],[31,40],[31,41],[31,43],[31,45],[31,49],[32,43],[32,44],[32,46],[32,47],[32,48],[33,35],[33,41],[33,43],[33,45],[33,46],[33,47],[34,36],[34,38],[34,39],[34,40],[34,41],[34,42],[34,44],[34,46],[34,48],[35,37],[35,43],[35,45],[36,37],[36,40],[36,43],[36,45],[36,46],[36,48],[37,38],[37,40],[37,42],[37,46],[37,47],[38,39],[38,40],[38,42],[38,46],[38,47],[38,49],[39,43],[39,45],[39,46],[39,47],[39,48],[39,49],[40,41],[40,42],[40,43],[40,45],[40,46],[40,47],[40,48],[41,45],[41,47],[41,48],[41,49],[42,44],[42,46],[42,47],[42,49],[43,44],[43,47],[43,48],[44,45],[44,46],[44,48],[44,49],[45,46],[45,47],[45,49],[46,47],[46,48],[46,49],[47,48],[48,49]], [17,33,29,39,41,10,1,19,5,8,18,15,7,25,45,48,35,28,34,22,31,36,27,47,42,43,14,49,20,9,16,40,44,32,13,24,4,21,30,11,0,46,38,2,12,6,37,23,3,26]))

//https://leetcode.com/problems/hand-of-straights/description/

func isNStraightHand(_ hand: [Int], _ W: Int) -> Bool {
    if hand.count % W != 0 {
        return false
    } else {
        var dic = [Int: Int]()
        for card in hand {
            if let value = dic[card] {
                dic[card] = value + 1
            } else {
                dic[card] = 1
            }
        }
        for card in hand.sorted() {
            if dic[card] == nil {
                continue
            }
            if dic.count == 0 {
                return true
            }
            for i in 0..<W {
                if let value = dic[card + i] {
                    if value == 1 {
                        dic.removeValue(forKey: card + i)
                    } else {
                        dic[card + i] = value - 1
                    }
                } else {
                    return false
                }
            }
        }
        return true
    }
}
//print(isNStraightHand([1,2,3,6,2,3,4,7,8], 3))

//https://leetcode.com/problems/minimum-number-of-arrows-to-burst-balloons/description/

func findMinArrowShots(_ points: [[Int]]) -> Int {
    if points.count == 0 {
        return 0
    }
    var indexSet = Set<Int>()
    for point in points {
        indexSet.insert(point.first!)
    }
    var indexArray = Array(indexSet).sorted()
    var pointsToShot = points
    var shot = 0

    while pointsToShot.count > 0 {
        var maxIndex = -1
        var max = -1
        for index in indexArray {
            let indexBalloons = numbersOfShot(pointsToShot, shot: index)
            if indexBalloons > max {
                maxIndex = index
                max = indexBalloons
            }
        }
        pointsToShot = removeBalloonsAt(maxIndex, points: pointsToShot)
        shot += 1
        indexArray = indexArray.filter({ (each) -> Bool in
            return each != maxIndex
        })
    }

    return shot
}

func numbersOfShot(_ points: [[Int]], shot: Int) -> Int {
    return points.filter({ (balloon) -> Bool in
        return (balloon.first! <= shot && balloon.last! >= shot)
    }).count
}

func removeBalloonsAt(_ x: Int, points:[[Int]]) -> [[Int]] {
    return points.filter({ (balloon) -> Bool in
        return !(balloon.first! <= x && balloon.last! >= x)
        })
}
//print(findMinArrowShots([[9,17],[4,12],[4,8],[4,8],[7,13],[3,4],[7,12],[9,15]]))


//https://leetcode.com/problems/max-increase-to-keep-city-skyline/description/
func maxIncreaseKeepingSkyline(_ grid: [[Int]]) -> Int {
    let count = grid.count
    var total = 0
    var lineMax = [Int].init(repeating: -1, count: count)
    var rowMax = [Int].init(repeating: -1, count: count)
    for i in 0..<count {
        for j in 0..<count {
            let height = grid[i][j]
            total += height
            if height > rowMax[i] {
                rowMax[i] = height
            }
            if height > lineMax[j] {
                lineMax[j] = height
            }
        }
    }
    var newTotal = 0
    for i in 0..<count {
        for j in 0..<count {
           newTotal += min(lineMax[j], rowMax[i])
        }
    }

    return newTotal - total
}

//print(maxIncreaseKeepingSkyline([[3,0,8,4],[2,4,5,7],[9,2,6,3],[0,3,1,0]]))

//https://leetcode.com/problems/open-the-lock/description/
class Lock {
    var status: [Int] = [Int]()
    init(_ str: String) {
        for code in str.unicodeScalars {
            status.append(Int(code.value) - 48)
        }
    }

    func minSteps(_ deadends: [Lock], index: Int, to: Int) -> Int {
        let old = status[index]
        var pathInDeadends = [Int]()
        for deadend in deadends {
            var correct = true
            for i in 0...3 {
                if i != index && deadend.status[i] != self.status[i] {
                    correct = false
                    break
                }
            }
            if correct {
                pathInDeadends.append(deadend.status[index])
            }
        }
        var clockwise = true
        var counter_clockwise = true
        for path in pathInDeadends {
            if path > old && path < to {
                clockwise = false
            }
            if path > to && path < old {
                counter_clockwise = false
            }
        }
        let clockwiseSteps = clockwise ? Lock.stepsBetween(from: old, to: to, clockwise: true) : -1
        let counter_clockwiseSteps = counter_clockwise ? Lock.stepsBetween(from: old, to: to, clockwise: false) : -1

        return min(clockwiseSteps, counter_clockwiseSteps)
    }

    static func stepsBetween(from: Int, to: Int, clockwise: Bool) -> Int {
        if clockwise {
            if to > from {
                return to - from
            } else {
                return 10 - (from - to)
            }
        } else {
            if to > from {
                return 10 - (to - from)
            } else {
                return from - to
            }
        }
    }
}

func openLock(_ deadends: [String], _ target: String) -> Int {
    var deadendsLock = [Lock]()
    for deadend in deadends {
        deadendsLock.append(Lock.init(deadend))
    }
    var lock = Lock.init("0000")
    var target = Lock.init(target)
    return 0
}

//print(openLock(["0201","0101","0102","1212","2002"], "0202"))

//https://leetcode.com/problems/maximum-subarray/

//let input = [-2,1,-3,4,-1,2,1,-5,4]
func maxSubArray(_ nums: [Int]) -> Int {
    var sum = nums[0]
    var tempSum = 0
    for i in 0..<nums.count {
        let num = nums[i]
        tempSum += num
        if tempSum > sum {
            sum = tempSum
        }
        if tempSum < 0 {
            tempSum = 0
        }
    }

    return sum
}

//print(maxSubArray(input))

//https://leetcode.com/problems/spiral-matrix/

//let input = [
//    [ 1, 2, 3 ],
//    [ 4, 5, 6 ],
//    [ 7, 8, 9 ]
//]

func spiralOrder(_ matrix: [[Int]]) -> [Int] {
    var result = [Int]()
    enum Status {
        case landscape_increase
        case portrait_increase
        case landscape_decrease
        case portrait_decrease

        func next() -> Status {
            switch self {
            case .landscape_increase:
                return .portrait_increase
            case .portrait_increase:
                return .landscape_decrease
            case .landscape_decrease:
                return .portrait_decrease
            case .portrait_decrease:
                return .landscape_increase
            }
        }
    }
    if matrix.count > 0 {
        let m = matrix[0].count
        let n = matrix.count
        var status: Status = .landscape_increase
        var mCount = 0
        var nCount = 0
        var x = 0
        var y = 0
        for _ in 0..<m * n {
            result.append(matrix[y][x])
            switch status {
            case .landscape_increase:
                if x == m - mCount - 1 {
                    y += 1
                    status = status.next()
                } else {
                    x += 1
                }
            case .portrait_increase:
                if y == n - nCount - 1 {
                    x -= 1
                    status = status.next()
                } else {
                    y += 1
                }
            case .landscape_decrease:
                if x == mCount {
                    y -= 1
                    status = status.next()
                    nCount += 1
                } else {
                    x -= 1
                }
            case .portrait_decrease:
                if y == nCount {
                    x += 1
                    status = status.next()
                    mCount += 1
                } else {
                    y -= 1
                }
            }
        }
    }
    return result
}

//print(spiralOrder(input))

//https://leetcode.com/problems/jump-game/

//let input = [0]

func canJump(_ nums: [Int]) -> Bool {
    var maxSteps = 1
    for i in 0..<nums.count - 1 {
        maxSteps -= 1
        let number = nums[i]
        if number > maxSteps {
            maxSteps = number
        }
        if maxSteps <= 0 {
            return false
        }
    }
    return true
}

//print(canJump(input))

//https://leetcode.com/problems/merge-intervals/

//let input = [[2,3],[2,2],[3,3],[1,3],[5,7],[2,2],[4,6]]

/*func merge(_ intervals: [[Int]]) -> [[Int]] {
    var returnResult = [[Int]]()
    let executed = ableToMergedWithOthers(intervals)
    var go = executed.1
    var input = executed.0
    while input.count > 0 {
        while go {
            let executed = ableToMergedWithOthers(input)
            go = executed.1
            input = executed.0
        }
        returnResult.append(input.first!)
        input.remove(at: 0)
        let executed = ableToMergedWithOthers(input)
        go = executed.1
        input = executed.0
    }

    return returnResult
}

func ableToMergedWithOthers(_ intervals: [[Int]]) -> ([[Int]], Bool) {
    var returnResult = intervals
    let count = intervals.count
    if count > 1 {
        if let firstElement = intervals.first {
            for i in 1..<count {
                let other = intervals[i]
                if let result = ableToMerged((firstElement, other)) {
                    returnResult.remove(at: 0)
                    returnResult.remove(at: i - 1)
                    returnResult.insert(result, at: 0)
                    return (returnResult, true)
                }
            }
        }
    }
    return (intervals,false)

}

func ableToMerged(_ intervals: ([Int],[Int])) -> ([Int]?) {
    let rangeA = intervals.0
    let rangeB = intervals.1
    let rangeAMin = rangeA[0]
    let rangeAMax = rangeA[1]
    let rangeBMin = rangeB[0]
    let rangeBMax = rangeB[1]
    if (rangeAMax < rangeBMin) || rangeBMax < rangeAMin {
        return (nil)
    } else {
        return [min(rangeAMin, rangeBMin), max(rangeAMax, rangeBMax)]
    }
}*/


//print(merge(input))


//https://leetcode.com/problems/merge-intervals/
// another method to solve this problem
//let input = [[2,3],[2,2],[3,3],[1,3],[5,7],[2,2],[4,6],[1,4]]

func merge(_ intervals: [[Int]]) -> [[Int]] {
    let input = intervals.sorted { (a, b) -> Bool in
        if a[0] > b[0] {
            return false
        } else if a[0] < b[0] {
            return true
        } else {
            return a[1] < b[1]
        }
    }
    print(input)
    if input.count > 0 {
        var result = [[Int]]()
        var start = input[0][0]
        var end = input[0][1]
        for i in 1..<input.count {
            let range = input[i]
            let secondStart = range[0]
            let secondEnd = range[1]
            if secondStart == start {
                end = max(end, secondEnd)
                continue
            } else {
                if secondEnd < end {
                    continue
                } else if secondStart <= end {
                    end = max(end, secondEnd)
                } else if secondEnd > end {
                    result.append([start, end])
                    start = secondStart
                    end = secondEnd
                }
            }
        }
        result.append([start, end])
        return result
    }
    return intervals
}
//print(merge(input))


//https://leetcode.com/problems/rotate-list/
//let input = arryToList(array: [1,2,3,4,5])
func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
    if let head = head {
        var result = head
        var map = [ListNode]()
        map.append(head)
        var next = head.next
        while next != nil {
            map.append(next!)
            if next?.next == nil {
                next?.next = head
                break
            } else {
                next = next?.next
            }
        }
        let count = map.count - k % map.count
        if count == map.count {
            result = map[0]
        } else {
            result = map[count]
        }
        if count == 0 {
            map[map.count - 1].next = nil
        } else {
            map[count - 1].next = nil
        }
        return result
    }
    return nil
}

//print(listToArray(head: rotateRight(input, 0)))

//https://leetcode.com/problems/unique-paths/
func uniquePaths(_ m: Int, _ n: Int) -> Int {
    if m == 1 || n == 1{
        return 1
    } else {
        return uniquePaths(m - 1, n) + uniquePaths(m, n - 1)
    }
}

//print(uniquePaths(3, 3))

//https://leetcode.com/problems/partition-list/
//let input = arryToList(array: [1,4,3,2,5,2])
func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
    if let head = head {
        var greaterHead: ListNode? = nil
        var greater: ListNode? = nil
        var lesser: ListNode? = nil
        var lesserHead: ListNode? = nil
        var nextCruise: ListNode? = head
        while let next = nextCruise {
            if next.val < x {
                if lesserHead == nil {
                    lesserHead = next
                    lesser = next
                } else {
                    lesser?.next = next
                    lesser = next
                }
            } else {
                if greaterHead == nil {
                    greaterHead = next
                    greater = next
                } else {
                    greater?.next = next
                    greater = next
                }
            }

            nextCruise = next.next
        }
        lesser?.next = greaterHead
        greater?.next = nil
        if lesserHead == nil {
            return head
        }
        return lesserHead
    }
    return head
}

//print(listToArray(head: partition(input, 3)))

//https://leetcode.com/problems/3sum/
let input = [-1,0,1]
func threeSum(_ nums: [Int]) -> [[Int]] {
    var result = [[Int]]()
    let preNums = prePareNums(nums)
    let first = preNums.0
    let second = preNums.1
    let third = preNums.2
    if second.count >= 3 {
        result.append([0,0,0])
    } else if second.count > 0 {
        for i in first {
            for j in third {
                if i + j == 0 {
                    if !result.contains([i, 0 ,j]) {
                        result.append([i, 0, j])
                    }
                }
            }
        }
    }
    if first.count > 0 && third.count > 0 {
        let firstCouples = coupleFromArray(first)
        let thirdCouples = coupleFromArray(third)
        if let fistCoupleWithThird = coupleWithArray(third, couples: firstCouples) {
            result.append(contentsOf: fistCoupleWithThird)
        }
        if let thirdCoupleWithThird = coupleWithArray(first, couples: thirdCouples) {
            result.append(contentsOf: thirdCoupleWithThird)
        }
    }

    return result
}

func coupleFromArray(_ nums:[Int]) -> [(Int, Int)] {
    var result = [(Int, Int)]()
    let length = nums.count
    for i in 0..<length {
        for j in i+1..<length {
            result.append((nums[i], nums[j]))
        }
    }

    return result
}

func coupleWithArray(_ nums: [Int], couples: [(Int, Int)]) -> [[Int]]? {
    var result = [[Int]]()
    let length = nums.count
    for couple in couples {
        for i in 0..<length {
            if couple.0 + couple.1 + nums[i] == 0 {
                result.append([couple.0, couple.1, nums[i]])
            }
        }
    }
    if result.count > 0 {
        return result
    } else {
        return nil
    }

}

func sumByCount(_ nums: [Int], sum: Int, count: Int) -> [[Int]]? {
    let length = nums.count
    var result = [[Int]]()
    for i in 0..<length {
        let compare = nums[i]
        if count == 1 {
            if compare == sum {
                result.append([compare])
            }
        } else {
            let restArray = Array(nums.dropFirst(i+1))
            let nextSum = sum - compare
            if let restResult = sumByCount(restArray, sum: nextSum, count: count-1) {
                for restArray in restResult {
                    var array = [compare]
                    array.append(contentsOf: restArray)
                    result.append(array)
                }
            }
        }
    }
    if result.count > 0 {
        return result
    } else {
        return nil
    }
}

func prePareNums(_ nums: [Int]) -> ([Int], [Int], [Int]) {
    var preNums = [Int]()
    var sortedNums = nums.sorted()
    var startZero = -1
    var moreThanZeroIndex = -1
    if sortedNums.count > 0 {
        var lastNum = sortedNums[0]
        if lastNum == 0 {
            startZero = 0
        } else if lastNum > 0 {
            moreThanZeroIndex = 0
        }
        var isUpToTwo = false
        preNums.append(lastNum)
        for i in 1..<sortedNums.count {
            let num = sortedNums[i]
            if num == 0 {
                if startZero == -1 {
                    startZero = preNums.count
                }
                preNums.append(num)
                continue
            }
            if num > 0 && startZero == -1 {
                startZero = preNums.count
            }
            if num > 0 && moreThanZeroIndex == -1 {
                moreThanZeroIndex = preNums.count
            }
            if num == lastNum {
                if isUpToTwo {
                    continue
                } else {
                    preNums.append(num)
                    isUpToTwo = true
                }
            } else {
                lastNum = num
                isUpToTwo = false
                preNums.append(num)
            }
        }
    }

    var firstArray = [Int]()
    var zeroArray = [Int]()
    var lastArray = [Int]()
    if startZero == -1 {
        startZero = preNums.count
    }
    if moreThanZeroIndex == -1 {
        moreThanZeroIndex = preNums.count
    }
    firstArray = Array(preNums[0...startZero-1])
    if moreThanZeroIndex > startZero {
        zeroArray = Array(preNums[startZero...moreThanZeroIndex-1])
    }
    if preNums.count > moreThanZeroIndex {
        lastArray = Array(preNums[moreThanZeroIndex...preNums.count-1])
    }
    return (firstArray,zeroArray,lastArray)
}


print(threeSum(input))


