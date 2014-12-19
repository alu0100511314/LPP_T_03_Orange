# encoding: utf-8
require 'spec_helper'
require 'orange'

class Orange
     describe Orange do
        before :each do
	    @o = Orange.new(2,5)
	end

     	context "Orange" do
		it "Debe tener una altura, edad, contador,estado, incremento de altura y un minimo de fruto" do
                   expect(@o.altura)== 0
		   expect(@o.edad)== 0
		   expect(@o.contador)== 0
		   expect(@o.estado)== ESTADO_NARANJERO::VIVO
		   expect(@o.inc_altura)== 2
                   expect(@o.min_fruto)== 5	
		end
                it "Debe tener dos componentes" do
		   expect {Orange.new(2)}.to raise_error(ArgumentError)
		end
                it "Debe saber crecer" do
		  expect(@o).to respond_to :uno_mas
		end
                it "Debe saber recolectar" do
                  expect(@o).to respond_to :recolectar_una
                end
		it "Metodo privado donde debe saber morir" do
                  expect(@o.private_methods.include? :morir).to eq(true) 
                end
		it "Metodo privado donde debe producir fruta" do
                  expect(@o.private_methods.include? :producirFruta).to eq(true)
                end
		it "Debe calcular bien la edad" do
                  q = Queue.new
                  t1 = Thread.new do
                        while @o.estado == ESTADO_NARANJERO::VIVO do
                           delay = 1
                           sleep delay
                           @o.uno_mas
                           q.enq @o
                           delay = 2
                           sleep delay
                           @o.uno_mas
                           q.enq @o
                        end
                        @o.edad
                  end
                  t2 = Thread.new do
                        while @o.estado == ESTADO_NARANJERO::VIVO do
                           delay = 0
                           sleep delay
                           q.deq.recolectar_una
                           delay = 2
                           sleep delay
                           q.deq.recolectar_una
                        end
                  end
                  t1.join
                  t2.join
                  expect(t1.value)== 10

                end
     	end
     end 
end
