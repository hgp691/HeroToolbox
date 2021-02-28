//
//  FatalErrorUtil.swift
//  HeroCommons
//
//  Created by Horacio Guzman on 19/02/21.
//

import Foundation

public func fatalError(_ message: @autoclosure () -> String = "",
                file: StaticString = #file,
                line: UInt = #line) -> Never {
    
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}

public func unreachable() -> Never {
    repeat {
        RunLoop.current.run()
    } while (true)
}

public struct FatalErrorUtil {
    
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
    
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
    
    public static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }
    
    public static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}
