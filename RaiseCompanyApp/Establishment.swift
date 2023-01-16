class Establishment {
    public let location: String
    public let image : String
    public let rating : Float
    public let benefits : Int
    public let losses : Int
    public let nEmployees : Int
    
    
    init (location : String, image: String, rating : Float, benefits : Int, losses : Int, nEmployees : Int) {
        self.location = location
        self.image = image
        self.rating = rating
        self.benefits = benefits
        self.losses = losses
        self.nEmployees = nEmployees
    }
}
