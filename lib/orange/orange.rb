#!/usr/bin/env ruby
require 'thread'

MAX_EDAD = 10

module ESTADO_NARANJERO
  VIVO = 0 
  MUERTO = 1 
end

class Orange
  attr_accessor :altura, :edad, :contador, :estado, :inc_altura, :min_fruto
  
  def initialize(*args)
    raise ArgumentError unless (args.size == 2)
    @altura = 0 
    @edad = 0 
    @contador = 0 
    @estado = ESTADO_NARANJERO::VIVO
    @inc_altura = args[0]
    @min_fruto = args[1]
  end 
  
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

  def producirFruta
    @edad + 2 
  end 

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
