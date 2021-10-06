import Foundation

class SampleData {
    let RED_THRESHOLD = 100
    let YELLOW_THRESHOLD = 150
    let BLUE_THRESHOLD = 100
    
    var sampleName: String
    var concentrationValue: Double
    var pathlengthValue: Double
    var redValue: Int
    var greenValue: Int
    var blueValue: Int
    var intensity: Double
    var wavelengthValue: Double
    var absorbanceValue: Double
    
    //Initialize a SampleData object
    init() {
        sampleName = ""
        concentrationValue = 0.0
        pathlengthValue = 1.15
        redValue = 0
        greenValue = 0
        blueValue = 0
        intensity = (Double)(redValue + blueValue + greenValue)
        wavelengthValue = 0.0
        absorbanceValue = 0.0
    }
    
    //Getter for sample name
    func getSampleName() -> String {
        return self.sampleName
    }
    //Setter for sample name
    func setSampleName(name: String) {
        self.sampleName = name
    }
    //Getter for concentration value
    func getConcentrationValue() -> Double {
        return self.concentrationValue
    }
    //Setter for concentration value
    func setConcentrationValue(concentrationValue: Double) {
        self.concentrationValue = concentrationValue
    }
    //Getter for path length value
    func getPathlengthValue() -> Double {
        return self.pathlengthValue
    }
    //Setter for path length value
    func setPathlengthValue(pathlengthValue: Double) {
        self.pathlengthValue = pathlengthValue
    }
    //Getter for red value
    func getRedValue() -> Int {
        return self.redValue
    }
    //Setter for red value
    func setRedValue(redValue: Int) {
        self.redValue = redValue
    }
    //Getter for green value
    func getGreenValue() -> Int {
        return self.greenValue
    }
    //Setter for green value
    func setGreenValue(greenValue: Int) {
        self.greenValue = greenValue
    }
    //Getter for blue value
    func getBlueValue() -> Int {
        return self.blueValue
    }
    //Setter for blue value
    func setBlueValue(blueValue: Int) {
        self.blueValue = blueValue
    }
    //Getter for intensity
    func getIntensity() -> Double {
        return self.intensity
    }
    //Setter for intensity
    func setIntensity(intensity: Double) {
        self.intensity = intensity
    }
    //Getter for wavelength value
    func getWavelengthValue() -> Double {
        return self.wavelengthValue
    }
    //Setter for wavelength value
    func setWavelengthValue(wavelengthValue: Double) {
        self.wavelengthValue = wavelengthValue
    }
    //Getter for absorbance value
    func getAbsorbanceValue() -> Double {
        return self.absorbanceValue
    }
    //Setter for absorbance value
    func setAbsorbanceValue(absorbanceValue: Double) {
        self.absorbanceValue = absorbanceValue
    }
    
    //calculate absorbance value of a sample
    func calculateAbsorbanceValue(control: SampleData) -> Double {
        var sampleIntensity = self.getIntensity()
        var controlIntensity = control.getIntensity()
        //Divide by zero
        if(controlIntensity == 0) {
            return 0
        }
        //Function will return negative infinity if this case is not accounted for
        if(sampleIntensity == 0) {
            return 1
        }
        var quotient = 1.0 * sampleIntensity / controlIntensity
        self.absorbanceValue = log10(quotient)
        return self.absorbanceValue
    }
    //calculate the name for a color
    func calculateColorName() -> String {
        //uninitialized or black
        if(redValue == 0 && greenValue == 0 && blueValue == 0) {
            return "---"
        }
        //red first, green second
        if (redValue >= greenValue && greenValue >= blueValue) {
            if (greenValue < RED_THRESHOLD) {
                return "Red"
            }
            else if (greenValue >= YELLOW_THRESHOLD) {
                return "Yellow"
            }
            else {
                return "Orange"
            }
        }
        //red first, blue second
        else if (redValue >= blueValue && blueValue >= greenValue) {
            return "Magenta"
        }
        //green first, red second
        else if (greenValue >= redValue && redValue >= blueValue) {
            return "Green"
        }
        //green first, blue second
        else if (greenValue >= blueValue && blueValue >= redValue) {
            return "Cyan"
        }
        //blue first, red second
        else if (blueValue >= redValue && redValue >= greenValue) {
            if (redValue < BLUE_THRESHOLD) {
                return "Blue"
            }
            else {
                return "Purple"
            }
        }
        //blue first, green second
        else if (blueValue >= greenValue && greenValue >= redValue) {
            return "Teal"
        } else {
            return "Undefined"
        }
    }
    
    //calculate the wavelength absorption range of a sample
    func calculateWavelengthValue() -> String {
        //uninitialized or black
        if(redValue == 0 && greenValue == 0 && blueValue == 0) {
            return "---"
        }
        //red first, green second
        if (redValue >= greenValue && greenValue >= blueValue) {
            if (greenValue < RED_THRESHOLD) {
                return "460-500 nm"
            }
            else if (greenValue >= YELLOW_THRESHOLD) {
                return "435-480 nm"
            }
            else {
                return "480-490 nm"
            }
        }
        //red first, blue second
        else if (redValue >= blueValue && blueValue >= greenValue) {
            return "500-560 nm"
        }
        //green first, red second
        else if (greenValue >= redValue && redValue >= blueValue) {
            return "400-450 nm & 700-750 nm"
        }
        //green first, blue second
        else if (greenValue >= blueValue && blueValue >= redValue) {
            return "605-750 nm"
        }
        //blue first, red second
        else if (blueValue >= redValue && redValue >= greenValue) {
            if (redValue < BLUE_THRESHOLD) {
                return "580-595 nm"
            }
            else {
                return "560-580 nm"
            }
        }
        //blue first, green second
        else if (blueValue >= greenValue && greenValue >= redValue) {
            return "595-605 nm"
        } else {
            return "Undefined"
        }
    }
}
