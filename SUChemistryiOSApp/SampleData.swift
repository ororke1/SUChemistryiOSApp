//
//  SampleData.swift
//  SUChemistryiOSApp
//
//  Created by Luke Engle on 10/20/21.
//

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
    var colorName: String
    var wavelengthValue: String
    var absorbanceValue: Double
    
    //Initialize a SampleData object
    init() {
        sampleName = ""
        concentrationValue = 0.0
        pathlengthValue = 1.15
        redValue = 0
        greenValue = 0
        blueValue = 0
        intensity = 0
        colorName = "---"
        wavelengthValue = "---"
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
    //Getter for color name
    func getColorName() -> String {
        return self.colorName
    }
    //Setter for color name
    func setColorName(colorName: String) {
        self.colorName = colorName
    }
    //Getter for wavelength value
    func getWavelengthValue() -> String {
        return self.wavelengthValue
    }
    //Setter for wavelength value
    func setWavelengthValue(wavelengthValue: String) {
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
    func calculateAbsorbanceValue(control: SampleData) {
        let sampleIntensity = self.getIntensity()
        let controlIntensity = control.getIntensity()
        //divide by zero
        if(controlIntensity == 0) {
            self.absorbanceValue = 0
            return
        }
        //function will return negative infinity if this case is not accounted for
        if(sampleIntensity == 0) {
            self.absorbanceValue = 1
            return
        }
        let quotient = 1.0 * sampleIntensity / controlIntensity
        self.absorbanceValue = log10(quotient)
    }
    //calculate the name for a color
    func calculateColorName() {
        //uninitialized or black
        if(redValue == 0 && greenValue == 0 && blueValue == 0) {
            self.colorName = "---"
        }
        //red first, green second
        if (redValue >= greenValue && greenValue >= blueValue) {
            if (greenValue < RED_THRESHOLD) {
                self.colorName = "Red"
            }
            else if (greenValue >= YELLOW_THRESHOLD) {
                self.colorName = "Yellow"
            }
            else {
                self.colorName = "Orange"
            }
        }
        //red first, blue second
        else if (redValue >= blueValue && blueValue >= greenValue) {
            self.colorName = "Magenta"
        }
        //green first, red second
        else if (greenValue >= redValue && redValue >= blueValue) {
            self.colorName = "Green"
        }
        //green first, blue second
        else if (greenValue >= blueValue && blueValue >= redValue) {
            self.colorName = "Cyan"
        }
        //blue first, red second
        else if (blueValue >= redValue && redValue >= greenValue) {
            if (redValue < BLUE_THRESHOLD) {
                self.colorName = "Blue"
            }
            else {
                self.colorName = "Purple"
            }
        }
        //blue first, green second
        else if (blueValue >= greenValue && greenValue >= redValue) {
            self.colorName = "Teal"
        }
        else {
            self.colorName = "Undefined"
        }
    }
    
    //calculate the wavelength absorption range of a sample
    func calculateWavelengthValue() {
        //uninitialized or black
        if(redValue == 0 && greenValue == 0 && blueValue == 0) {
            self.wavelengthValue = "---"
        }
        //red first, green second
        if (redValue >= greenValue && greenValue >= blueValue) {
            if (greenValue < RED_THRESHOLD) {
                self.wavelengthValue = "460-500 nm"
            }
            else if (greenValue >= YELLOW_THRESHOLD) {
                self.wavelengthValue = "435-480 nm"
            }
            else {
                self.wavelengthValue = "480-490 nm"
            }
        }
        //red first, blue second
        else if (redValue >= blueValue && blueValue >= greenValue) {
            self.wavelengthValue = "500-560 nm"
        }
        //green first, red second
        else if (greenValue >= redValue && redValue >= blueValue) {
            self.wavelengthValue = "400-450 nm & 700-750 nm"
        }
        //green first, blue second
        else if (greenValue >= blueValue && blueValue >= redValue) {
            self.wavelengthValue = "605-750 nm"
        }
        //blue first, red second
        else if (blueValue >= redValue && redValue >= greenValue) {
            if (redValue < BLUE_THRESHOLD) {
                self.wavelengthValue = "580-595 nm"
            }
            else {
                self.wavelengthValue = "560-580 nm"
            }
        }
        //blue first, green second
        else if (blueValue >= greenValue && greenValue >= redValue) {
            self.wavelengthValue = "595-605 nm"
        }
        else {
            self.wavelengthValue = "Undefined"
        }
    }
}
