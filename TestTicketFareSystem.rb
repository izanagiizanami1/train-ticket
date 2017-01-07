require 'test/unit'
require './TicketFareSystem.rb'



class TestTicketFareSystem < Test::Unit::TestCase
	@umedaTicketMachine = nil
	@jyuusouTicketMachine = nil
	@shounaiTicketMachine = nil
	@okamachiTicketMachine = nil
	@umeda_station = nil
	@jyuusou_station = nil
	@shounai_station = nil
	@okamachi_station = nil

	def setup
		@umeda_station = TicketFareSystem::Station.new(1,"梅田")
		@jyuusou_station = TicketFareSystem::Station.new(2,"十三")
		@shounai_station = TicketFareSystem::Station.new(3,"庄内")
		@okamachi_station = TicketFareSystem::Station.new(4,"岡町")
		@umedaTicketMachine = TicketFareSystem::TicketMachine.new(@umeda_station)
		@jyuusouTicketMachine = TicketFareSystem::TicketMachine.new(@jyuusou_station)
		@shounaiTicketMachine = TicketFareSystem::TicketMachine.new(@shounai_station)
		@okamachiTicketMachine = TicketFareSystem::TicketMachine.new(@okamachi_station)

  	end



  	description "シナリオ1（1区間）"
	def test_sinario1
		ticket = TicketFareSystem::Ticket.new(150)
		@umedaTicketMachine.entry(ticket)
		exit_val = @jyuusouTicketMachine.exit(ticket)

		assert_equal(1,exit_val)
  	end


  	description "シナリオ2（2区間・運賃不足）"
  	def test_sinario2
		ticket = TicketFareSystem::Ticket.new(150)
		@umedaTicketMachine.entry(ticket)
		exit_val = @shounaiTicketMachine.exit(ticket)

		assert_equal(-4,exit_val)
  	end


  	description "シナリオ3（2区間・運賃ちょうど）"
  	def test_sinario3
		ticket = TicketFareSystem::Ticket.new(180)
		@umedaTicketMachine.entry(ticket)
		exit_val = @shounaiTicketMachine.exit(ticket)

		assert_equal(1,exit_val)

  	end


  	description "シナリオ4（2区間・運賃）"
  	def test_sinario4
		ticket = TicketFareSystem::Ticket.new(220)
		@umedaTicketMachine.entry(ticket)
		exit_val = @shounaiTicketMachine.exit(ticket)

		assert_equal(1,exit_val)
  	end


  	description "シナリオ5（3区間・運賃不足）"
  	def test_sinario5
		ticket = TicketFareSystem::Ticket.new(180)
		@umedaTicketMachine.entry(ticket)
		exit_val = @okamachiTicketMachine.exit(ticket)

		assert_equal(-4,exit_val)
  	end


  	description "シナリオ6（3区間・運賃ちょうど）"
  	def test_sinario6
		ticket = TicketFareSystem::Ticket.new(220)
		@umedaTicketMachine.entry(ticket)
		exit_val = @okamachiTicketMachine.exit(ticket)

		assert_equal(1,exit_val)
  	end


  	description "シナリオ7（梅田以外の駅から乗車する・運賃不足）"
  	def test_sinario7
		ticket = TicketFareSystem::Ticket.new(150)
		@jyuusouTicketMachine.entry(ticket)
		exit_val = @okamachiTicketMachine.exit(ticket)

		assert_equal(-4,exit_val)
  	end

  	description "シナリオ8（梅田以外の駅から乗車する・運賃ちょうど）"
  	def test_sinario8
		ticket = TicketFareSystem::Ticket.new(180)
		@jyuusouTicketMachine.entry(ticket)
		exit_val = @okamachiTicketMachine.exit(ticket)

		assert_equal(1,exit_val)
  	end


  	description "シナリオ9（岡町方面から梅田方面へ向かう）"
  	def test_sinario9
		ticket = TicketFareSystem::Ticket.new(220)
		@okamachiTicketMachine.entry(ticket)
		exit_val = @umedaTicketMachine.exit(ticket)

		assert_equal(1,exit_val)
  	end


  	description "シナリオ10（同じ駅で降りる）"
  	def test_sinario10
		ticket = TicketFareSystem::Ticket.new(150)
		@umedaTicketMachine.entry(ticket)
		exit_val = @umedaTicketMachine.exit(ticket)

		assert_equal(-3,exit_val)
  	end


  	description "シナリオ11（一度入場した切符でもう一度入場する）"
  	def test_sinario11
		ticket = TicketFareSystem::Ticket.new(150)
		@umedaTicketMachine.entry(ticket)
		entry_val = @umedaTicketMachine.entry(ticket)

		assert_equal(-1,entry_val)
  	end


  	description "シナリオ12（使用済みの切符でもう一度出場する）"
  	def test_sinario12
		ticket = TicketFareSystem::Ticket.new(150)
		@umedaTicketMachine.entry(ticket)
		@jyuusouTicketMachine.exit(ticket)
		#assert_boolean(true,ticket.used?)
		exit_val = @jyuusouTicketMachine.entry(ticket)

		
		assert_equal(-2,exit_val)
  	end


  	description "シナリオ13（改札を通っていない切符で出場する）"
  	def test_sinario13
		ticket = TicketFareSystem::Ticket.new(150)
		exit_val = @jyuusouTicketMachine.exit(ticket)

		assert_equal(-1,exit_val)
  	end



end