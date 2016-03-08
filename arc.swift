// This is a commented walkthrough some of the ARC concepts
// very well detailed at:
// https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID54

import Foundation

class Person {
  let name: String
  var apartment: Apartment? // strong reference to an Apartment instance

  init(name: String) {
      self.name = name
        print("\(name) is being initialized")
  }

  deinit {
    print("\(name) is being deinitialized")
  }
}

class Apartment {
  let unit: String
  var tenant: Person? // strong reference to a Person instance

  init(unit: String) {
    self.unit = unit
    print("Apartment \(unit) is being initialized")
  }

  deinit {
    print("Apartment \(unit) is being deinitialized")
  }
}

do {
  // diego is deallocated as soon as this block scope ends
  let diego = Person(name: "Diego")
}

var john: Person? = Person(name: "John")
var unit4A: Apartment? = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john

// Neither Person(name: "John") nor Apartment(unit: "4A") are deallocated
// since there is a reference cycle between them, causing a potential memmory leak.
// One way to fix this is to use weak references in order to get a hold of an optional
// instance of Person in the Apartment implementation and similarlly an optional instance
// of Apartment within the Person implementation none of which will cause ARC to add 1 to
// its reference counters.
john = nil
unit4A = nil
