#!/usr/bin/swift

import Foundation

class Observable<T> {
	typealias Updater = (T?) -> Void

	let updater : Updater?

	var value: T? {
		didSet {
			updater?(value)
		}
	}

	init(_ v: T? = nil, u: Updater? = nil) {
		value = v
		updater = u
	}
}

let d = Observable(123) { print("New value \($0)\n") }

d.value = 321
d.value = 76589

let s = Observable("LOL") { print("\($0)\n") }

s.value = "Big LOL"

let z = Observable("Nice work")

z.value = "WAT?!"

let lol = Observable<Int>() { print("New value: \($0)\n") }
lol.value = 123

enum APIError : ErrorType {
  case BadRequest
  case MalformedURL(url: String)
}

class Service {
  init?(url: String) throws {
    guard url.characters.count > 10 else {
      throw APIError.MalformedURL(url: url)
    }
  }
}

class MaybeURL {
  init?(url: String) {
    guard url.characters.count > 10 else {
      return nil
    }
  }
}

do {
  let service = try Service(url: "lol")
  print("#### \(service)\n")

} catch APIError.MalformedURL(let url) {
  print("Malformed URL: \(url)\n")
}

let url1 = MaybeURL(url: "lol2")
let url2 = MaybeURL(url: "www.google.com")

print("url1: \(url1)\n")
print("url2: \(url2)\n")
