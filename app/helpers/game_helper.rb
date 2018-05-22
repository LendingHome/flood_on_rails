module GameHelper
    def colorMapper(color)
        colorMap = { 1 => 'red',
            2 => 'blue',
            3 => 'green',
            4 => 'white',
            5 => 'black',
            6 => 'purple',
        }
        colorMap[color]
    end  
end
