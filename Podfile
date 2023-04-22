target 'PatriotRV' do
  platform :ios, '16.2'
  use_frameworks!

  # Pods for PatriotRV
  # Fix for crash until merged to CocoaMQTT #802
  pod 'CocoaAsyncSocket', :git => 'https://github.com/dauerr/CocoaAsyncSocket'
  pod 'CocoaMQTT', :git => 'https://github.com/dauerr/CocoaMQTT'
#  pod 'CocoaMQTT'

  target 'PatriotRVTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PatriotRVUITests' do
    # Pods for testing
  end

end
