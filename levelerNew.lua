-- Função para solicitar valores do usuário
local function prompt(message)
    print(message)
    return tonumber(read())
end

-- Solicitar coordenadas do usuário
local xMin = prompt("Digite o valor de X mínimo:")
local xMax = prompt("Digite o valor de X máximo:")
local zMin = prompt("Digite o valor de Z mínimo:")
local zMax = prompt("Digite o valor de Z máximo:")
local x, y, z = gps.locate()

-- Inicializar a turtle
local function initializeTurtle()
    print("Iniciando a turtle...")
    turtle.select(1)
end

-- Função para verificar e colocar bloco abaixo da turtle
local function placeBlockBelow()
    if not turtle.detectDown() then
        turtle.placeDown()
    end
end

local function updateLocation()
    x, y, z = gps.locate()
end

local function changeLine()
    turtle.turnRight()
    if not turtle.forward() then
        turtle.dig()
        turtle.forward()
    end
    turtle.turnRight()
    turtle.forward()
    if z >= zMin and z <= zMax then
        walk()
    end
end

function walk()
    while x < xMax and x > xMin and z > zMin and z < zMax do
        if turtle.getFuelLevel() > 0 then
            placeBlockBelow()
            placeBlockBelow()
            if not turtle.forward() then
                turtle.dig()
            end
            turtle.forward()
            updateLocation()
        else
            print("Falha, falta de combustivel.")
            break
        end
    end
    changeLine()
end

walk()
