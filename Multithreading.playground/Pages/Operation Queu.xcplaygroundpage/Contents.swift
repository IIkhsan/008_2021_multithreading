//: [Previous](@previous)

import Foundation



func obtainDataOperation(completion: @escaping (([String]) -> Void)) {
    var data = [String]()
    
    let operationQueue = OperationQueue.main // не путать с DispatchQueue.main
    operationQueue.maxConcurrentOperationCount = 1
    operationQueue.qualityOfService = .background
    
    let operation = Operation()
    operation.completionBlock = {

        for i in 0..<5 {
            data.append("\(i) ✅")
            print(("\(i) ✅"))
        }
    }
    
    let operationBlock = BlockOperation {
        for i in 0..<5 {
            data.append("\(i) 🤓")
            print("\(i) 🤓")
        }
    }
    
//        operationBlock.start() // откуда был вызван start в таком потоке и будет обработан блок
        
//    operation.start()
        
//    operation.addDependency(operationBlock)
    
    operationQueue.addOperations([operation, operationBlock], waitUntilFinished: true)
        
    completion(data)
}

obtainDataOperation {
    $0.forEach { print($0) }
}
//: [Next](@next)

// ✅
// ✅
// 🤓
// 🤓
// 🤓

