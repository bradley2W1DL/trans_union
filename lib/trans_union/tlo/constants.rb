module TransUnion::TLO
  module Constants
    TLO_WSDL = 'https://webservice.tlo.com/TLOWebService.asmx?wsdl'
    REQUIRED_CREDENTIALS = [:username, :password, :dppa_purpose, :glb_purpose, :permissible_use_code, :version]

    RESOURCE_PATH = Pathname.new(__dir__).join('../../res')
    CA_CERT = RESOURCE_PATH.join('cacert.pem')

    NAME_SUFFIXES = %w(II III IV V JR SR)
  end
end
