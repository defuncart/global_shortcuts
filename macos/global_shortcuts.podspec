#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint global_shortcuts.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'global_shortcuts'
  s.version          = '0.0.1'
  s.summary          = 'A macOS plugin which can register a callback for a global keyboard shortcut.'
  s.description      = <<-DESC
  A macOS plugin which can register a callback for a global keyboard shortcut.
                       DESC
  s.homepage         = 'https://github.com/defuncart/global_shortcuts/'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'defuncart@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.subspec 'Core' do |ss|
    ss.dependency 'FlutterMacOS'
    ss.dependency 'HotKey'
  end

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
