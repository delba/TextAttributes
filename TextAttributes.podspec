Pod::Spec.new do |s|
  s.name          = 'TextAttributes'
  s.version       = '2.0.2'
  s.license       = 'MIT'
  s.homepage      = 'https://github.com/delba/TextAttributes'
  s.author        = { 'Damien' => 'damien@delba.io' }
  s.summary       = 'An easier way to compose attributed strings'
  s.source        = { :git => 'https://github.com/delba/TextAttributes.git', :tag => s.version }
  s.swift_version = '5.0'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Source/**/*.{swift,h}'
end
