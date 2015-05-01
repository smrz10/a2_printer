require "print_mode"
require "barcode"
require "format"
require "control"

class Collaborators

	def initialize(connection)
	    @print_mode = PrintMode.new connection
	    @barcode = Barcode.new connection
	    @format = Format.new connection
	    @control = Control.new connection
	end

	def method_missing(method_name, *args, &block)
		collaborators = obtain_collaborators

		collaborators.each { |collaborator|
			if(collaborator.respond_to?(method_name))				
				return collaborator.send(method_name, *args, &block)				
			end 
		}
		raise NoMethodError.new("Not Found")
	end 


	private

	def obtain_collaborators		
		#instance_variables
		[@print_mode, @barcode, @format, @control]
	end 
end