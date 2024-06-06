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

-- Função para mover a turtle para frente e nivelar o terreno
local function moveForwardAndLevel()
    if not turtle.forward() then
        turtle.dig()
        turtle.forward()
    end
    placeBlockBelow()
end

-- Função para mover a turtle para a próxima linha
local function moveToNextLine()
    turtle.turnRight()
    if not turtle.forward() then
        turtle.dig()
        turtle.forward()
    end
    placeBlockBelow()
    turtle.turnRight()
end

-- Função para mover a turtle para a linha anterior
local function moveToPreviousLine()
    turtle.turnLeft()
    if not turtle.forward() then
        turtle.dig()
        turtle.forward()
    end
    placeBlockBelow()
    turtle.turnLeft()
end

-- Função principal para percorrer a área e planar o terreno
local function main()
    initializeTurtle()

    local direction = 1  -- 1 para direita, -1 para esquerda

    for z = zMin, zMax do
        for x = xMin, xMax, direction do
            moveForwardAndLevel()
        end
        
        -- Mudar a direção e ir para a próxima linha
        if z < zMax then
            if direction == 1 then
                moveToNextLine()
            else
                moveToPreviousLine()
            end
            direction = direction * -1
        end
    end

    print("Terreno nivelado e blocos colocados.")
end

main()