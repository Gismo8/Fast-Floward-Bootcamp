pub struct Canvas {
    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: [String]
    pub let hash: String

    init(width: UInt8, height: UInt8, pixels: [String]) {
        self.width = width
        self.height = height
        self.pixels = pixels
        self.hash = seralizeStringArray(lines: pixels)
    }
}

pub resource Picture {
  pub let canvas: Canvas
  
  init(canvas: Canvas) {
    self.canvas = canvas
  }
}

pub resource Printer {
  pub let printedCanvases:{String:Bool}
  
  init() {
    self.printedCanvases = {}
  }

  pub fun print(canvas: Canvas): @Picture? {
    if (!self.printedCanvases.containsKey(canvas.hash)){
      let picture <- create Picture(canvas: canvas)
      display(canvas: picture.canvas)
      self.printedCanvases[canvas.hash] = true
      destroy picture
      //not allowed to return the picture likely due to scoping
      return <- create Picture(canvas: canvas)
    } else {
      log("This has been printed already");
      return nil
    }
  }
}

pub fun main() {
let pixelsX = [
    "*   *",
    " * * ",
    "  *  ",
    " * * ",
    "*   *"
]

let pixelsY = [
    "*   *",
    " * * ",
    "  *  ",
    "  *  ",
    "  *  "
]

let canvasX = Canvas(
    width: 5,
    height: 5, 
    pixels: pixelsX
)

let canvasY = Canvas(
    width: 5,
    height: 5, 
    pixels: pixelsY
)

let printer <- create Printer()
let printX1 <- printer.print(canvas: canvasX)
let printX2 <- printer.print(canvas: canvasX)
let printY1 <- printer.print(canvas: canvasY)
let printY2 <- printer.print(canvas: canvasY)

destroy printer
destroy printX1
destroy printX2
destroy printY1
destroy printY2
}

pub fun display(canvas: Canvas) {
    var lines = canvas.pixels
    var topAndBottom = "+-----+"
    log(topAndBottom)
    for line in lines {
        log(("|").concat(line).concat("|"))
    }
    log(topAndBottom)
}

pub fun seralizeStringArray (lines: [String]): String {
    var topAndBottom = "+-----+\n"
    var buffer = topAndBottom
    for line in lines {
        buffer = buffer.concat("|").concat(line).concat("|\n")
    }
    buffer = buffer.concat(topAndBottom)
    return buffer
}

