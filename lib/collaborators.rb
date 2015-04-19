require "print_mode"
require "barcode"
require "format"
require "control"

class Collaborators

	def initialize(connection)
	    @print_mode = PrintMode.new @connection
	    @barcode = Barcode.new @connection
	    @format = Format.new @connection
	    @control = Control.new @connection
	end

	def method_missing(method_name, *args, &block)	
		collaborators = obtain_collaborators

		collaborators.each { |collaborator|
			if(collaborator.respond_to?(method_name))
				collaborator.send(method_name, *args, &block)
				break
			end 
		}
	end 


	private

	def obtain_collaborators
		self.instance_variables
	end 
end