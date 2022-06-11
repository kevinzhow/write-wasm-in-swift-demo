import Foundation

@_cdecl("allocate")
func allocate(size: Int) -> UnsafeMutableRawPointer {
  return UnsafeMutableRawPointer.allocate(byteCount: size, alignment: MemoryLayout<UInt8>.alignment)
}
@_cdecl("deallocate")
func deallocate(pointer: UnsafeMutableRawPointer) {
  pointer.deallocate()
}

@_cdecl("change_article_proto")
func changeBookProto(protoData: UnsafeMutableRawPointer,  size: Int,  newAuthor: UnsafeRawPointer, authorSize: Int, newSize: UnsafeMutablePointer<Int>) -> UnsafeRawPointer {
    // Decode proto binary data
    let data = Data(bytes: protoData, count: size)
    var book = try! BookInfo(serializedData: data)

    // Change author
    book.author =  String(data: Data(bytes: newAuthor, count: authorSize), encoding: .utf8)!

    let newData = try! book.serializedData()
    newSize.pointee = newData.count

    // get the data pointer of the new book proto data
    let pointer = newData.withUnsafeBytes{ (bufferRawBufferPointer) -> UnsafeRawPointer in

        let bufferPointer: UnsafePointer<UInt8> = bufferRawBufferPointer.baseAddress!.assumingMemoryBound(to: UInt8.self)
        return UnsafeRawPointer(bufferPointer)
    }

    return pointer
}