//: [Previous](@previous)

import Foundation

let main = DispatchQueue.main
let serialQueue = DispatchQueue(label: "serial")
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
let concurrentQueue = DispatchQueue(label: "", qos: .userInteractive, attributes: .concurrent)

// MARK - Task

let mySerialQueue = DispatchQueue(label: "serial_custom")
let dispatchGroup = DispatchGroup()

var value = "🤡"

func changeValue(variant: Int) {
    sleep(5)
    value = value + "🧐"
    print("\(value) - \(variant)")
}

dispatchGroup.enter() // + 1 (1)
mySerialQueue.async {
    changeValue(variant: 1)
    dispatchGroup.leave() // - 1
}

value

value += "⛷" // main
dispatchGroup.enter() // + 1 (2)
mySerialQueue.async {
    changeValue(variant: 2) // serial_custom
    dispatchGroup.leave() // - 1
}


dispatchGroup.notify(queue: mySerialQueue) {
    value
}
 // main

// 🤡🧐⛷🧐

//: [Next](@next)
