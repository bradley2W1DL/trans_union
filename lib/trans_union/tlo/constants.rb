module TransUnion::TLO
  module Constants
    TLO_WSDL = 'https://webservice.tlo.com/TLOWebService.asmx?wsdl'
    REQUIRED_CREDENTIALS = [:username, :password, :dppa_purpose, :glb_purpose, :permissible_use_code, :version]

    NAME_SUFFIXES = %w(II III IV V JR SR)
  end
end
