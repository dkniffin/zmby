require "zmby/version"
require 'zmby/cli'
require 'zmby/gui'

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
