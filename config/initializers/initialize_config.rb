require 'soap/wsdlDriver'
CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), '../config.yml'))
SMS_SERVICE = CONFIG['SMS_service']
SMS_DRIVER = SOAP::WSDLDriverFactory.new(SMS_SERVICE).create_rpc_driver unless SMS_SERVICE.blank?