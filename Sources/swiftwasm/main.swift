import Foundation

@_cdecl("allocate")
func allocate(size: Int) -> UnsafeMutableRawPointer {
  return UnsafeMutableRawPointer.allocate(byteCount: size, alignment: MemoryLayout<UInt8>.alignment)
}
@_cdecl("deallocate")
func deallocate(pointer: UnsafeMutableRawPointer) {
  pointer.deallocate()
}

@_cdecl("change_article_json")
func changeArticleJSONData(articleJSONDataStrPtr: UnsafeMutableRawPointer, size: Int, newAuthor: UnsafeRawPointer, authorSize: Int, newSize: UnsafeMutablePointer<Int>) -> UnsafeRawPointer {
    
    let jsonData = Data(bytes: articleJSONDataStrPtr, count: size)

    // Decode Data into Struct
    let decoder = JSONDecoder()
    var article = try! decoder.decode(Article.self, from: jsonData)
    // Modify the author
    article.author =  String(data: Data(bytes: newAuthor, count: authorSize), encoding: .utf8)!

    let encoder = JSONEncoder()

    // Encode the struct into data
    let newStrData = try! encoder.encode(article)
    // Count the data byte length
    newSize.pointee = newStrData.count

    // Get Pointer of the data
    let pointer = newStrData.withUnsafeBytes{ (bufferRawBufferPointer) -> UnsafeRawPointer in
        let bufferPointer: UnsafePointer<UInt8> = bufferRawBufferPointer.baseAddress!.assumingMemoryBound(to: UInt8.self)
        return UnsafeRawPointer(bufferPointer)
    }

    return pointer
}
