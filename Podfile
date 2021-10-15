# vi: set filetype=ruby:

# The global platform for this project.
platform :ios, '14.5'

target 'Vacatio' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Google Analytics without IDFA collection capability.
  #pod 'Firebase/AnalyticsWithoutAdIdSupport'

  # Firebase Firestore product.
  pod 'Firebase/Firestore', '8.7.0'

  # Firebase Authentication service.
  pod 'Firebase/Auth', '8.7.0'

  target 'VacatioTests' do
    inherit! :search_paths
  end

  target 'VacatioUITests' do
  end
end
