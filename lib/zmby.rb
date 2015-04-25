require_relative "zmby/version"
require_relative 'zmby/cli'
require_relative 'zmby/gui'

module Zmby
	class << self
		def run_cli
			Zmby::CLI.instance.run
		end
		def run_gui
			Zmby::GUI.new.show
		end
	end
end
