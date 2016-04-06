public struct Data {
    public var bytes: [Byte]

    public init(_ bytes: [Byte]) {
        self.bytes = bytes
    }
}

public protocol DataInitializable {
    init(data: Data) throws
}

public protocol DataRepresentable {
    var data: Data { get }
}

public protocol DataConvertible: DataInitializable, DataRepresentable {}

extension Data {
    public init(_ string: String) {
        self.init([Byte](string.utf8))
    }
}

#if swift(>=3.0)
extension Data: RangeReplaceableCollection {}
#else
extension Data: RangeReplaceableCollectionType {}
#endif

extension Data {
    public init() {
        self.init([])
    }

    #if swift(>=3.0)
    public init(repeating repeatedValue: Byte, count: Int) {
        self.init([Byte](repeating: repeatedValue, count: count))
    }
    #else
    public init(count: Int, repeatedValue: Byte) {
        self.init([Byte](count: count, repeatedValue: repeatedValue))
    }
    #endif

    #if swift(>=3.0)
    public mutating func replaceSubrange<C : Collection where C.Iterator.Element == Byte>(subRange: Range<Int>, with newElements: C) {
        self.bytes.replaceSubrange(subRange, with: newElements)
    }
    #else
    public mutating func replaceRange<C : CollectionType where C.Generator.Element == Byte>(subRange: Range<Int>, with newElements: C) {
        self.bytes.replaceRange(subRange, with: newElements)
    }
    #endif

    public mutating func reserveCapacity(n: Int) {
        self.bytes.reserveCapacity(n)
    }

    #if swift(>=3.0)
    public init<S : Sequence where S.Iterator.Element == Byte>(_ elements: S) {
        self.init([Byte](elements))
    }
    #else
    public init<S : SequenceType where S.Generator.Element == Byte>(_ elements: S) {
        self.init([Byte](elements))
    }
    #endif

    public mutating func append(x: Byte) {
        self.bytes.append(x)
    }

    #if swift(>=3.0)
    public mutating func append<S : Sequence where S.Iterator.Element == Byte>(contentsOf newElements: S) {
        self.bytes.append(contentsOf: newElements)
    }
    #else
    public mutating func appendContentsOf<S : SequenceType where S.Generator.Element == Byte>(newElements: S) {
        self.bytes.appendContentsOf(newElements)
    }
    #endif

    #if swift(>=3.0)
    public mutating func insert(newElement: Byte, at i: Int) {
        self.bytes.insert(newElement, at: i)
    }
    #else
    public mutating func insert(newElement: Byte, atIndex i: Int) {
        self.bytes.insert(newElement, atIndex: i)
    }
    #endif

    #if swift(>=3.0)
    public mutating func insert<S : Collection where S.Iterator.Element == Byte>(contentsOf newElements: S, at i: Int) {
        self.bytes.insert(contentsOf: newElements, at: i)

    }
    #else
    public mutating func insertContentsOf<S : CollectionType where S.Generator.Element == Byte>(newElements: S, at i: Int) {
        self.bytes.insertContentsOf(newElements, at: i)

    }
    #endif

    #if swift(>=3.0)
    public mutating func remove(at i: Int) -> Byte {
        return self.bytes.remove(at: i)
    }
    #else
    public mutating func removeAtIndex(i: Int) -> Byte {
        return self.bytes.removeAtIndex(i)
    }
    #endif

    public mutating func removeFirst() -> Byte {
        return self.bytes.removeFirst()
    }

    public mutating func removeFirst(n: Int) {
        self.bytes.removeFirst(n)
    }

    #if swift(>=3.0)
    public mutating func removeSubrange(bounds: Range<Int>) {
        self.bytes.removeSubrange(bounds)
    }
    #else
    public mutating func removeRange(bounds: Range<Int>) {
        self.bytes.removeRange(bounds)
    }
    #endif

    #if swift(>=3.0)
    public mutating func removeAll(keepingCapacity keepCapacity: Bool) {
        self.bytes.removeAll(keepingCapacity: keepCapacity)
    }
    #else
    public mutating func removeAll(keepCapacity keepCapacity: Bool) {
        self.bytes.removeAll(keepCapacity: keepCapacity)
    }
    #endif
}

#if swift(>=3.0)
extension Data: MutableCollection {}
#else
extension Data: MutableCollectionType {}
#endif

extension Data {
    #if swift(>=3.0)
    public func makeIterator() -> IndexingIterator<[Byte]> {
        return bytes.makeIterator()
    }
    #else
    public func generate() -> IndexingGenerator<[Byte]> {
        return bytes.generate()
    }
    #endif

    public var startIndex: Int {
        return bytes.startIndex
    }

    public var endIndex: Int {
        return bytes.endIndex
    }

    public var count: Int {
        return bytes.count
    }

    public subscript(index: Int) -> Byte {
        get {
            return bytes[index]
        }

        set(value) {
            bytes[index] = value
        }
    }

    public subscript (bounds: Range<Int>) -> ArraySlice<Byte> {
        get {
            return bytes[bounds]
        }

        set(slice) {
            bytes[bounds] = slice
        }
    }
}

extension Data: ArrayLiteralConvertible {
    public init(arrayLiteral bytes: Byte...) {
        self.init(bytes)
    }
}

extension Data: StringLiteralConvertible {
    public init(stringLiteral string: String) {
        self.init(string)
    }

    public init(extendedGraphemeClusterLiteral string: String){
        self.init(string)
    }

    public init(unicodeScalarLiteral string: String){
        self.init(string)
    }
}

extension Data: Equatable {}

public func ==(lhs: Data, rhs: Data) -> Bool {
    return lhs.bytes == rhs.bytes
}

#if swift(>=3.0)
public func +=<S : Sequence where S.Iterator.Element == Byte>(lhs: inout Data, rhs: S) {
    return lhs.bytes += rhs
}
#else
public func +=<S : SequenceType where S.Generator.Element == Byte>(inout lhs: Data, rhs: S) {
    return lhs.bytes += rhs
}
#endif

#if swift(>=3.0)
public func +=(lhs: inout Data, rhs: Data) {
    return lhs.bytes += rhs.bytes
}
#else
public func +=(inout lhs: Data, rhs: Data) {
    return lhs.bytes += rhs.bytes
}
#endif

#if swift(>=3.0)
public func +=(lhs: inout Data, rhs: DataConvertible) {
    return lhs += rhs.data
}
#else
public func +=(inout lhs: Data, rhs: DataConvertible) {
    return lhs += rhs.data
}
#endif

@warn_unused_result
public func +(lhs: Data, rhs: Data) -> Data {
    return Data(lhs.bytes + rhs.bytes)
}

@warn_unused_result
public func +(lhs: Data, rhs: DataConvertible) -> Data {
    return lhs + rhs.data
}

@warn_unused_result
public func +(lhs: DataConvertible, rhs: Data) -> Data {
    return lhs.data + rhs
}

extension String: DataConvertible {
    #if swift(>=3.0)
    public init(data: Data) throws {
        struct Error: ErrorProtocol {}
        var string = ""
        var decoder = UTF8()
        var generator = data.makeIterator()

        loop: while true {
            switch decoder.decode(&generator) {
            case .scalarValue(let char): string.append(char)
            case .emptyInput: break loop
            case .error: throw Error()
            }
        }

        self.init(string)
    }
    #else
    public init(data: Data) throws {
        struct Error: ErrorProtocol {}
        var string = ""
        var decoder = UTF8()
        var generator = data.generate()

        loop: while true {
            switch decoder.decode(&generator) {
            case .Result(let char): string.append(char)
            case .EmptyInput: break loop
            case .Error: throw Error()
            }
        }

        self.init(string)
    }
    #endif

    public var data: Data {
        return Data(self)
    }
}

extension Data {
    public func withUnsafeBufferPointer<R>(@noescape body: (UnsafeBufferPointer<Byte>) throws -> R) rethrows -> R {
        return try bytes.withUnsafeBufferPointer(body)
    }

    public mutating func withUnsafeMutableBufferPointer<R>(@noescape body: (inout UnsafeMutableBufferPointer<Byte>) throws -> R) rethrows -> R {
       return try bytes.withUnsafeMutableBufferPointer(body)
    }

    #if swift(>=3.0)
    public static func bufferWithSize(size: Int) -> Data {
        return Data([UInt8](repeating: 0, count: size))
    }
    #else
    public static func bufferWithSize(size: Int) -> Data {
        return Data([UInt8](count: size, repeatedValue: 0))
    }
    #endif
}

extension Data {
    #if swift(>=3.0)
    public func hexString(delimiter delimiter: Int = 0) -> String {
        var string = ""
        for (index, value) in self.enumerated() {
            if delimiter != 0 && index > 0 && index % delimiter == 0 {
                string += " "
            }
            string += (value < 16 ? "0" : "") + String(value, radix: 16)
        }
        return string
    }
    #else
    public func hexString(delimiter delimiter: Int = 0) -> String {
        var string = ""
        for (index, value) in self.enumerate() {
            if delimiter != 0 && index > 0 && index % delimiter == 0 {
                string += " "
            }
            string += (value < 16 ? "0" : "") + String(value, radix: 16)
        }
        return string
    }
    #endif

    public var hexDescription: String {
        return hexString(delimiter: 2)
    }
}

extension Data: CustomStringConvertible {
    public var description: String {
        if let string = try? String(data: self) {
            return string
        }

        return debugDescription
    }
}

extension Data: CustomDebugStringConvertible {
    public var debugDescription: String {
        return hexDescription
    }
}