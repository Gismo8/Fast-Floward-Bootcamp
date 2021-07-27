
pub struct Canvas {
    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: [String]

    init(width: UInt8, height: UInt8, pixels: [String]) {
        self.width = width
        self.height = height
        self.pixels = pixels
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

let canvasX = Canvas(
    width: 5,
    height: 5, 
    pixels: pixelsX
)

display(canvas: canvasX)
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

