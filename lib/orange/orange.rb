# encoding: utf-8
#!/usr/bin/env ruby
require 'thread'

# Constante ligada a la máxima edad posible del naranjero
MAX_EDAD = 10

# Módulo representativo de los estados posibles del naranjero
module ESTADO_NARANJERO
  VIVO = 0 
  MUERTO = 1 
end

# Clase gestora del comportamiento del naranjero
class Orange
  attr_accessor :altura, :edad, :contador, :estado, :inc_altura, :min_fruto
  
  # Instancia un nuevo objeto de la clase Orange indicando el incremento de altura y la edad mínima a la cual da frutos.
  def initialize(*args)
    raise ArgumentError unless (args.size == 2)
    @altura = 0 
    @edad = 0 
    @contador = 0 
    @estado = ESTADO_NARANJERO::VIVO
    @inc_altura = args[0]
    @min_fruto = args[1]
  end 
  
  # Incrementa la edad del naranjero en uno si es posible. En caso contrario, mata el naranjero.
  def uno_mas
    @edad += 1
    if @edad < MAX_EDAD
      @altura += @inc_altura
      @contador += producirFruta if @edad >= @min_fruto
    else
      morir
    end 
    @edad
  end 

  # Recoleta una naranja si es posible y devuelve un mensaje ligado al resultado.
  def recolectar_una
    s = ""
    if @estado == ESTADO_NARANJERO::MUERTO
      s = "El árbol está muerto :("
    else
      if @contador == 0
        s = "¡Ups! No quedan naranjas"
      else
        s = "La naranja estaba deliciosa :D"
        @contador -= 1
      end 
    end 
    s   
  end 

  # Devuelve una nueva cantidad de frutas a partir de la edad actual.
  def producirFruta
    @edad + 2 
  end 

  # Cambia el estado del naranjero de vivo a muerto
  def morir
    @estado = ESTADO_NARANJERO::MUERTO
  end 

  private :producirFruta, :morir

end

if __FILE__ == $0
  n = Naranjero.new 2, 5
  q = Queue.new
  tCrecimiento = Thread.new do
                     while n.estado == ESTADO_NARANJERO::VIVO do
                       delay = 2
                       puts "> Crecimiento del naranjero detenido durante #{delay} segundos"
                       sleep delay
                       puts "> Crecimiento del naranjero reanimado después de dormir #{delay} segundos"
                       n.uno_mas
                       puts "> Crecimiento del naranjero en una unidad"
                       q.enq n
                       delay = 4
                       puts "> Crecimiento del naranjero detenido durante #{delay} segundos"
                       sleep delay
                       puts "> Crecimiento del naranjero reanimado después de dormir #{delay} segundos"
                       n.uno_mas
                       puts "> Crecimiento del naranjero en una unidad"
                       q.enq n
                     end
                 end
  tRecogida = Thread.new do
                  while n.estado == ESTADO_NARANJERO::VIVO do
                    delay = 0
                    puts "- Recogida de naranjas detenida durante #{delay} segundos"
                    sleep delay
                    puts "- Recogida de naranjas reanimada después de dormir #{delay} segundos"
                    puts "- Recogida de naranjas esperando pacientemente ..."
                    puts "- #{q.deq.recolectar_una}"
                    delay = 4
                    puts "- Recogida de naranjas detenida durante #{delay} segundos"
                    sleep delay
                    puts "- Recogida de naranjas reanimada después de dormir #{delay} segundos"
                    puts "- Recogida de naranjas esperando pacientemente ..."
                    puts "- #{q.deq.recolectar_una}"
                  end
                end
  tCrecimiento.join
  tRecogida.join
end
