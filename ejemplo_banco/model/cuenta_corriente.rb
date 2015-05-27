class CuentaCorriente

	def initialize
		@saldo = 0
	end

	def saldo
		@saldo
	end

	def acreditar(monto)
		@saldo += monto
	end

	def debitar(a_debitar)
		@saldo -= a_debitar
	end
end