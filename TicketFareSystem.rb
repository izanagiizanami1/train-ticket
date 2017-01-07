# coding: utf-8 

module TicketFareSystem

	#=========================================
	# 駅クラス
	#=========================================
	class Station
		attr_accessor :num,:name

		def initialize(num,name)
			@num = num
			@name = name
		end

	end

	#=========================================
	# 切符クラス
	#=========================================
	class Ticket
		attr_accessor :price,:entry_station,:exit_station,:entry_datetime,:exit_datetime,:kind,:buy_station

		def initialize(price)
			@kind = 0
			@price = price
		end

		#=======================================
		# 入場済みかどうか
		#=======================================
		def entried?
			entried = !@entry_station.nil?

		end

		#=======================================
		# 使用済みかどうか
		#=======================================
		def used?
			!@exit_station.nil?
		end

	end

	#===========================================
	# 改札機クラス
	#===========================================
	class TicketMachine
		attr_accessor :station

		def initialize(station)
			@station = station
		end
=begin
		#=======================================
		# 入場する
		#=======================================
		def entry?(ticket)
			enabled = false

			return false if ticket.nil?

			#切符に入場記録がなされているかどうか
			return false if ticket.entried? 

			#切符に入場記録する
			ticket.entry_station = @station

			enabled = true
		end


		#=======================================
		# 出場する
		#=======================================
		def exit?(ticket)
			enabled = false

			return false if ticket.nil?

			#切符に入場記録がなされているかどうか
			return false unless ticket.entried? 

			#切符に出場記録がなされているか
			return false if ticket.used?

			#入場駅と出場予定の駅の区間差を求める
			diff = calc_interval(ticket)

			#入場駅と出場予定の駅が同じ場合
			return false if diff == 0

			#チケット価格と入出場駅区間の価格の照合
			enabled = judge_price(ticket)

			#切符に出場記録をする
			ticket.exit_station = @station

			return enabled
		end
=end
		#=======================================
		# 入場する
		# [返り値]
		# 1:入場できる
		# -1:すでに切符に入場記録がなされている
		#=======================================
		def entry(ticket)
			ret = 1

			return false if ticket.nil?

			#切符に入場記録がなされているかどうか
			return -1 if ticket.entried? 

			#切符に入場記録する
			ticket.entry_station = @station

			return ret
		end
		#=======================================
		# 出場する
		# [返り値]
		# 1:出場できる
		# -1:入場記録されていない切符である
		# -2:すでに出場済みである
		# -3:同じ駅で入場している
		# -4:価格不足
		#=======================================
		def exit(ticket)
			ret = 1

			return false if ticket.nil?

			#切符に入場記録がなされているかどうか
			return -1 unless ticket.entried? 

			#切符に出場記録がなされているか
			return -2 if ticket.used? 

			#入場駅と出場予定の駅の区間差を求める
			diff = calc_interval(ticket)

			#入場駅と出場予定の駅が同じ場合
			return -3 if diff == 0

			#チケット価格と入出場駅区間の価格の照合
			enabled = judge_price(ticket)
			return -4 unless enabled 

			#切符に出場記録をする
			ticket.exit_station = @station

			return ret
		end

		#=======================================
		# 入場駅と出場予定の駅の区間差を求める
		#=======================================
		def calc_interval(ticket)
			interval = (ticket.entry_station.num - @station.num).abs
		end


		#=======================================
		# チケット価格と入出場駅区間の価格の照合
		#=======================================
		def judge_price(ticket)
			enabled = false

			#区間差を求める
			interval = calc_interval(ticket)
			#区間差から価格を求める
			price = calc_fare_from_diff_interval(interval)

			#チケット価格と照合する
			if ticket.price == price then
				enabled = true
			elsif ticket.price > price then
				enabled = true
			elsif ticket.price < price then
				enabled = false
			end

			return enabled
		end

		#=======================================
		# 区間差から価格を求める
		#=======================================
		def calc_fare_from_diff_interval(interval)
			price = 0

			case interval
				when 1 then price = 150
				when 2 then price = 180
				when 3 then price = 220
				else price  = 0 
			end

			return price
		end

	end

end
