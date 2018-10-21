func baklava(maxWidth: Int = 10) -> Void {
    let width = 0...maxWidth
    for number in width {
        let repeatedSpaces = repeatElement(" ", count:maxWidth-number)
        for space in repeatedSpaces {
            print(space,terminator:"")
        }
        
        let repeatedAsterisks = repeatElement("*", count:number*2+1)
        for asterisk in repeatedAsterisks {
            print(asterisk,terminator:"")
        }
        print("")
    }
    for number in width.reversed() {
        let repeatedSpaces = repeatElement(" ", count:maxWidth-number)
        for space in repeatedSpaces {
            print(space,terminator:"")
        }
        let repeatedAsterisks = repeatElement("*", count:number*2+1)
        for asterisk in repeatedAsterisks {
            print(asterisk,terminator:"")
        }
        print("")
    }
}
baklava()
