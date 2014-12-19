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
